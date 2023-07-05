#!/bin/bash

word="$3"
files=$(ls *.txt | head -"$2" | tail -$(($2 - $1 + 1)))
total=0
for file in $files; do
    count=$(grep -o -i -w "$word" "$file" | wc -l)
    total=$((total + count))
done
echo $total

