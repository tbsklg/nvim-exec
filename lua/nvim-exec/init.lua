local view = require("nvim-exec.view")
local helpers = require("nvim-exec.helpers")
local parser = require("nvim-treesitter.parsers").get_parser()

local config = {
    timeout_in_ms = 10000,
    show_result_in = "comment",
}

local print_result = {
    comment = view.show_in_comment,
    window = view.show_in_window,
}

local filetype_executable = {
    javascript = function(code)
        return { "node", "-p", code }
    end,
    typescript = function(code)
        return { "npx", "ts-node", "-p", "-e", code }
    end,
}

local execute_code = function(code)
    if not code then
        return
    end

    local filetype = vim.bo.filetype
    local executable = filetype_executable[filetype]

    if not executable then
        return
    end

    return vim.fn.jobstart(executable(code), {
        stdout_buffered = true,
        stderr_buffered = true,
        on_stdout = function(_, data)
            local filtered_data = helpers.without_empty_lines(data)
            if #filtered_data > 0 then
                print_result[config.show_result_in](data)
            end
        end,
        on_stderr = function(_, data)
            local filtered_data = helpers.without_empty_lines(data)
            if #filtered_data > 0 then
                print_result[config.show_result_in](data)
            end
        end,
    })
end

local on_timeout = function(job_id, callback)
    vim.defer_fn(function()
        if vim.fn.jobwait({ job_id }, 0)[1] == -1 then
            vim.fn.jobstop(job_id)
            callback()
        end
    end, config.timeout_in_ms)
end

local parse_comments = function()
    local buf_nr = vim.api.nvim_get_current_buf()

    local query =
        vim.treesitter.query.parse(parser:lang(), "((comment) @comment)")

    local tree = parser:parse()[1]
    return query:iter_captures(tree:root(), buf_nr)
end

local extract_instruction_from = function(node)
    local buf_nr = vim.api.nvim_get_current_buf()

    return vim.treesitter.get_node_text(node, buf_nr):gsub("//", "")
end

local create_execution_for = function(node)
    local buf_nr = vim.api.nvim_get_current_buf()

    local file_content = vim.api.nvim_buf_get_lines(buf_nr, 0, -1, false)
    local instruction = extract_instruction_from(node)

    return table.concat(file_content, "\n") .. "\n;" .. instruction
end

local run = function()
    for _, node, _ in parse_comments() do
        local node_line = vim.treesitter.get_node_range(node) + 1
        local cursor_line = vim.api.nvim_win_get_cursor(0)[1]

        if node_line == cursor_line then
            on_timeout(execute_code(create_execution_for(node)), function()
                print_result({ "Job timed out" })
            end)
        end
    end
end

vim.api.nvim_create_user_command("ExecCode", run, {})

return {
    run = run,
}
