
for ((var = 1; $var <=150 ; var++))
do
    echo "thread num:$var"
    time ./lab02 $var
done
