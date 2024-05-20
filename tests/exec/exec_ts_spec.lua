local helpers = require "tests.exec.helpers"

describe("exec-typescript", function()
    before_each(function()
        helpers.clear_buffer()
        helpers.set_filetype("typescript")
    end)

    it("should execute code for function call", function()
        local code = {
            "// add(1, 2)",
            "function add(x: number, y: number): number {",
            " return x + y",
            "}",
        }

        vim.api.nvim_buf_set_lines(0, 0, 0, false, code)

        vim.api.nvim_win_set_cursor(0, { 1, 0 })

        helpers.execute_code(4000, function()
            require("nvim-exec").run()
        end)

        local result = vim.api.nvim_buf_get_lines(0, 2, 3, false)
        assert.are.same({ "// 3" }, result)
    end)
end)
