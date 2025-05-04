![Status](https://github.com/github/docs/actions/workflows/test.yml/badge.svg)

# nvim-exec

[![Lua](https://img.shields.io/badge/Lua-blue.svg?style=for-the-badge&logo=lua)](http://www.lua.org)
[![Neovim](https://img.shields.io/badge/Neovim%200.9.5+-green.svg?style=for-the-badge&logo=neovim)](https://neovim.io)

> Execute JavaScript/TypeScript code directly from your Neovim buffer and see the results instantly

[![asciicast](https://asciinema.org/a/99Pz6BItqkZWEuo6AyoSgHrJE.svg)](https://asciinema.org/a/99Pz6BItqkZWEuo6AyoSgHrJE)

## Features

- ✅ Execute JavaScript/TypeScript code directly from your buffer
- ✅ View results as comments or in a separate window
- ✅ Built-in timeout protection for long-running code
- ✅ Seamless integration with your Neovim workflow

## Installation

### Requirements

- **Neovim 0.9.5** or later
- Node.js installation
- nvim-treesitter with appropriate parser installation
  - Install language parsers using `:TSInstall javascript` or `:TSInstall typescript`

### For TypeScript Support

- Typescript installation
- ts-node

### Using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
return {
    "tbsklg/nvim-exec",
    branch = "main",
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
        local nvim_exec = require("nvim-exec").setup({
            timeout = 10000,
            output_mode = "window",
        })
    
        vim.keymap.set({ "n", "v" }, "<leader>r", function()
            nvim_exec.run()
        end, { desc = "Execute code" })
    end,
    ft = { "javascript", "typescript" },
}
```

## Usage

1. Write your JavaScript/TypeScript code in a buffer
2. Add a comment with code to execute (e.g. `// fibs(10)`)
3. Place your cursor on the comment line
4. Execute `:ExecCode` or use your configured keybinding (e.g. `<leader>r`)
5. See results appear below as comments or in a window

### Example

```javascript
// fibs(10)
// [
//   1,  1,  2,  3,  5,
//   8, 13, 21, 34, 55
// ]
// 
const fibs = (n) => {
  const go = (n) => {
    if (n < 2) return 1;
    return go(n - 1) + go(n - 2);
  }

  return Array.from({ length: n }).reduce((acc, _, i) => [...acc, go(i)], []);
}
```

### Timeout Protection

The plugin automatically terminates code execution that takes longer than the configured timeout (default: 10 seconds).

```javascript
// fibs(100)  // Using the inefficient implementation
// Job timed out
//
```

## Configuration

```lua
require("nvim-exec").setup({
    timeout = 10000,       -- Timeout in milliseconds (default: 10000)
    output_mode = "window" -- "comment" or "window" (default: "window")
})
```

| Option | Description | Default |
|--------|-------------|---------|
| `timeout` | Maximum execution time in milliseconds | `10000` |
| `output_mode` | Where to display results (`"comment"` or `"window"`) | `"window"` |

## Development

### Prerequisites

- Lua and Neovim development environment
- Make

### Available Commands

```bash
make lint  # Run linting
make fmt   # Run formatting
make test  # Run tests
```

## License

[MIT](LICENSE)
