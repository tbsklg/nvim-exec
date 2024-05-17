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
