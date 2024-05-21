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

return {
    execute_code = execute_code,
    clear_buffer = clear_buffer,
    set_filetype = set_filetype,
}
