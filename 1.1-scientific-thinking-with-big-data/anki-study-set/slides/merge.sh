rm merged.csv

find . -type f -name "*.csv" ! -name "merged.csv" -print0 |
while IFS= read -r -d '' f; do
    cat "$f"
    printf '\n'
done >> merged.csv
