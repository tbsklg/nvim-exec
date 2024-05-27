local helpers = require("nvim-exec.helpers")

local show_in_comment = function(result)
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

local show_in_window = function(result)
    local buf_nr = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf_nr, 0, -1, false, result)

    local win_id = vim.api.nvim_open_win(buf_nr, true, {
        relative = "editor",
        width = 80,
        height = 10,
        row = math.floor(((vim.o.lines - 10) / 2) - 1),
        col = math.floor((vim.o.columns - 80) / 2),
        border = "single",
        style = "minimal",
        title = "Code execution result",
        title_pos = "center",
    })

    vim.api.nvim_set_option_value("number", true, {
        win = win_id,
    })
end

return {
    show_in_comment = show_in_comment,
    show_in_window = show_in_window,
}
