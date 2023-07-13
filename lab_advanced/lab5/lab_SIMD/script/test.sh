#!/bin/bash

res_root=cost_time_$(date '+%Y%m%d%H%M%S')
mkdir $res_root

funcs=(sse avx)
scales=(128 256 512 1024 2048)
for i in ${funcs[*]}
do
    echo func:$i
    for j in ${scales[*]}
    do
        echo scale:$j
        path=$(printf ./%s/%s_%d.txt $res_root $i $j)
        touch $path
        for k in $(seq 0 9)
        do
            echo $k
            ./bin/test -m $j -n $j -r $j -u $i >> $path
        done
    done
done

python ./script/draw.py $res_root