local helpers = require("nvim-exec.helpers")
local parser = require("nvim-treesitter.parsers").get_parser()

local config = {
    timeout_in_ms = 10000,
}

local print_result = function(result)
    local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
    local buf_nr = vim.api.nvim_get_current_buf()

    vim.api.nvim_buf_set_lines(
        buf_nr,
        cursor_line,
        cursor_line,
        false,
        helpers.as_comment(result)
    )
end

local execute_code = function(code)
    if not code then
        return
    end
    print(code)

    return vim.fn.jobstart({ "node", "-p", code }, {
        stdout_buffered = true,
        stderr_buffered = true,
        on_stdout = function(_, data)
            if data then
                print_result(data)
            end
        end,
        on_stderr = function(_, data)
            if data then
                print_result(data)
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

local comments_with_marker = function()
    local buf_nr = vim.api.nvim_get_current_buf()

    local query = vim.treesitter.query.parse(
        "javascript",
        '((comment) @comment)'
    )

    local tree = parser:parse()[1]
    return query:iter_captures(tree:root(), buf_nr)
end

local extract_instruction_from = function(node)
    local buf_nr = vim.api.nvim_get_current_buf()

    return vim.treesitter
        .get_node_text(node, buf_nr)
        :gsub("//", "")
end

local create_execution_for = function(node)
    local buf_nr = vim.api.nvim_get_current_buf()

    local file_content = vim.api.nvim_buf_get_lines(buf_nr, 0, -1, false)
    local instruction = extract_instruction_from(node)

    return table.concat(file_content, "\n") .. "\n" .. instruction
end

local run = function()
    for _, node, _ in comments_with_marker() do
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
