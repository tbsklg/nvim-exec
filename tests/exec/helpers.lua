execute_code = function(max_execution_time, fn)
    local co = coroutine.running()

    vim.defer_fn(function()
        coroutine.resume(co)
    end, max_execution_time)

    fn()

    coroutine.yield()
end

local clear_buffer = function()
    vim.api.nvim_buf_set_lines(0, 0, -1, false, {})
end

local set_filetype = function(filetype)
    vim.api.nvim_buf_set_option(0, "filetype", filetype)
end

local screen = {
    debug = function()
        local buf_nr = vim.api.nvim_get_current_buf()
        local lines = vim.api.nvim_buf_get_lines(buf_nr, 0, -1, false)
        print(vim.inspect(lines))
    end,
}

return {
    screen = screen,
    execute_code = execute_code,
    clear_buffer = clear_buffer,
    set_filetype = set_filetype,
}
