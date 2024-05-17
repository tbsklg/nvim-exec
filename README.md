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

The plugin configures a timeout for the code execution. If the code takes longer than the timeout, the
execution will be stopped. The default timeout is 10 seconds.

```javascript
//>>> fibs(100)
//
// Job timed out
//
const fibs = (n) => {
  const go = (n) => {
    if (n < 2) return 1;
    return go(n - 1) + go(n - 2);
  }

  return Array.from({ length: n }).reduce((acc, _, i) => [...acc, go(i)], []);
}
```

Of course you know a better way of calculating fibonacci numbers using memoization. You can use the
following code to calculate the first 100 fibonacci numbers. If you place the cursor in the comment block
and execute :ExecCode, you will see the output in the next line(s).

```javascript
//>>> fibs(100)
// 
// [
//                       1,                     1,                     2,
//                       3,                     5,                     8,
//                      13,                    21,                    34,
//                      55,                    89,                   144,
//                     233,                   377,                   610,
//                     987,                  1597,                  2584,
//                    4181,                  6765,                 10946,
//                   17711,                 28657,                 46368,
//                   75025,                121393,                196418,
//                  317811,                514229,                832040,
//                 1346269,               2178309,               3524578,
//                 5702887,               9227465,              14930352,
//                24157817,              39088169,              63245986,
//               102334155,             165580141,             267914296,
//               433494437,             701408733,            1134903170,
//              1836311903,            2971215073,            4807526976,
//              7778742049,           12586269025,           20365011074,
//             32951280099,           53316291173,           86267571272,
//            139583862445,          225851433717,          365435296162,
//            591286729879,          956722026041,         1548008755920,
//           2504730781961,         4052739537881,         6557470319842,
//          10610209857723,        17167680177565,        27777890035288,
//          44945570212853,        72723460248141,       117669030460994,
//         190392490709135,       308061521170129,       498454011879264,
//         806515533049393,      1304969544928657,      2111485077978050,
//        3416454622906707,      5527939700884757,      8944394323791464,
//       14472334024676220,     23416728348467684,     37889062373143900,
//       61305790721611580,     99194853094755490,    160500643816367070,
//      259695496911122560,    420196140727489660,    679891637638612200,
//     1100087778366101900,   1779979416004714000,   2880067194370816000,
//     4660046610375530000,   7540113804746346000,  12200160415121877000,
//    19740274219868226000,  31940434634990100000,  51680708854858330000,
//    83621143489848430000, 135301852344706760000, 218922995834555200000,
//   354224848179262000000
// ]
// 
const fibs = (n) => {
  const memo = new Map();
  const go = (n) => {
    if (n < 2) return 1;
    if (memo.has(n)) return memo.get(n);
    const result = go(n - 1) + go(n - 2);
    memo.set(n, result);
    return result;
  }

  return Array.from({ length: n }).reduce((acc, _, i) => [...acc, go(i)], []);
}
```

# Quickstart
## Requirements
- **Neovim 0.9.5** or later
- Node.js installation (depends on the code you want to execute)
- Nvim-treesitter with parser installation. This plugin uses the treesitter parser to identify the language
  of the code you want to execute. You can install the parser for the language you are using by running
  `:TSInstall <language>` in neovim.

# Development
## Run linting
```make lint```

## Run formatting
```make fmt```

## Run tests
```make test```
