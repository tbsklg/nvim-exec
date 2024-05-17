const fibs = (n) => {
  const go = (n) => {
    if (n < 2) return 1;
    return go(n - 1) + go(n - 2);
  }

  return Array.from({ length: n }).reduce((acc, _, i) => [...acc, go(i)], []);
}
