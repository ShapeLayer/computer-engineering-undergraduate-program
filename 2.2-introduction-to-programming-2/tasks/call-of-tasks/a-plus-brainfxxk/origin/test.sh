for file in tests/*.in; do
    base=$(basename "$file" .in)
    ./a.out < "tests/$base.in" > "tests/$base.out.actual"
    if diff -q "tests/$base.out.actual" "tests/$base.out" > /dev/null; then
        echo "$base: PASS"
    else
        echo "$base: FAIL"
    fi
done
