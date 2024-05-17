![](https://github.com/github/docs/actions/workflows/test.yml/badge.svg)

# nvim-exec
[![Lua](https://img.shields.io/badge/Lua-blue.svg?style=for-the-badge&logo=lua)](http://www.lua.org)
[![Neovim](https://img.shields.io/badge/Neovim%200.8+-green.svg?style=for-the-badge&logo=neovim)](https://neovim.io)

Sometimes you need fast feedback on the code you are writing. This plugin allows you to execute code
from your current buffer. It displays the output as a comment in the same buffer. Currently only node.js
is supported.

You can execute any code within a comment block after the `>>>` symbol. The output will be displayed
as a comment in the next line.

Example:
Suppose you have the following fibonacci function in your buffer (btw, this is a terrible way to calculate
fibonacci numbers). If you place the cursor in the comment block and execute :ExecCode, you will see the
output in the next line(s).

```javascript
//>>> fibs(10)
// 
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

# Quickstart
## Requirements
- **Neovim 0.9.5** or later
- Node.js installation (depends on the code you want to execute)
- Nvim-treesitter with parser installation for javascript (TSInstall javascript)

# Development
## Run linting
```make lint```

## Run formatting
```make fmt```

## Run tests
```make test```
