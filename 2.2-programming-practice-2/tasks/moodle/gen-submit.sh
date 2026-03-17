cat case1.input
cat case1.input | ./a.out
cat case1.input | ./a.out > case1.output && diff case1.ans case1.output > case1.diff

cat case2.input
cat case2.input | ./a.out
cat case2.input | ./a.out > case2.output && diff case2.ans case2.output > case2.diff
