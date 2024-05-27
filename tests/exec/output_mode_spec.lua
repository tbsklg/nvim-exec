local helpers = require("tests.exec.helpers")

describe("exec-typescript", function()
    before_each(function()
        helpers.clear_buffer()
        helpers.set_filetype("typescript")
    end)

    it("should show code execution result in window", function()
        local code = {
            "// multiply(1, 2)",
            "function multiply(x: number, y: number): number {",
            " return x * y;",
            "}",
        }

        vim.api.nvim_buf_set_lines(0, 0, 0, false, code)

        vim.api.nvim_win_set_cursor(0, { 1, 0 })

        helpers.execute_code(4000, function()
            require("nvim-exec").setup({ output_mode = "window" }).run()
        end)

        local result_window = vim.api.nvim_get_current_win()
        local result_buffer = vim.api.nvim_win_get_buf(result_window)

        local result = vim.api.nvim_buf_get_lines(result_buffer, 0, 1, false)
        assert.are.same({ "2" }, result)
    end)

    it("should show error result in window", function()
        local code = {
            "// add(1, 2)",
            "function multiply(x: number, y: number): number {",
            " return x * y;",
            "}",
        }

        vim.api.nvim_buf_set_lines(0, 0, 0, false, code)

        vim.api.nvim_win_set_cursor(0, { 1, 0 })

        helpers.execute_code(4000, function()
            require("nvim-exec").setup({ output_mode = "window" }).run()
        end)

        local result_window = vim.api.nvim_get_current_win()
        local result_buffer = vim.api.nvim_win_get_buf(result_window)

        local result = vim.api.nvim_buf_get_lines(result_buffer, 0, 1, false)
        assert.are.same(
            { "[eval].ts(6,3): error TS2304: Cannot find name 'add'." },
            result
        )
    end)
end)
