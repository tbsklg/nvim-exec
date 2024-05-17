describe("some basics", function()

  before_each(function()
    vim.api.nvim_command("read ./tests/exec/test.js")
    vim.api.nvim_command("set filetype=javascript")
  end)

  it("should eval a function", function()
    vim.api.nvim_buf_set_lines(0, 0, 0, false, { "//>>> add(1,2)" })
    vim.api.nvim_win_set_cursor(0, { 1, 1 })

    local co = coroutine.running()

    vim.defer_fn(function()
      coroutine.resume(co)
    end, 1000)

    require 'exec'.exec()

    coroutine.yield()

    local result = vim.api.nvim_buf_get_lines(0, 2, 3, false)
    assert.are.same({ "// 3" }, result)
  end)
end)