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
    vim.api.nvim_open_win(buf_nr, true, {
        relative = "editor",
        width = 80,
        height = 10,
        row = 10,
        col = 10,
    })
end

return {
    show_in_comment = show_in_comment,
    show_in_window = show_in_window,
}
