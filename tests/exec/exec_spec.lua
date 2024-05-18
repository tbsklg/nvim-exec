local execute_code = function(max_execution_time, fn)
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

describe("nvim-exec", function()
    before_each(function()
        clear_buffer()
        set_filetype("javascript")
    end)

    it("should execute code for function call", function()
        local code = {
            "// add(1, 2)",
            "function add(x, y) {",
            " return x + y",
            "}",
        }

        vim.api.nvim_buf_set_lines(0, 0, 0, false, code)

        vim.api.nvim_win_set_cursor(0, { 1, 0 })

        execute_code(2000, function()
            require("nvim-exec").run()
        end)

        local result = vim.api.nvim_buf_get_lines(0, 2, 3, false)
        assert.are.same({ "// 3" }, result)
    end)

    it("should execute code in a file without semicolons", function()
        local code = {
            "// [1,2,3].map(x => x + 2)",
            "const add = (x, y) => x + y",
            "module.exports = add",
        }
        vim.api.nvim_buf_set_lines(0, 0, 0, false, code)

        vim.api.nvim_win_set_cursor(0, { 1, 0 })

        execute_code(2000, function()
            require("nvim-exec").run()
        end)

        local result = vim.api.nvim_buf_get_lines(0, 2, 3, false)
        assert.are.same({ "// [ 3, 4, 5 ]" }, result)
    end)
end)
