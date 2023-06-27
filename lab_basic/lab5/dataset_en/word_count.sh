#!/bin/bash

word="operating"

files=$(ls *.txt | head -10 | tail -6)
total=0

for file in $files; do
	count=$(grep -o -i -w "$word" "$file" | wc -l)
	total=$((total + count))
done
echo "word '$word' appears $total times"
