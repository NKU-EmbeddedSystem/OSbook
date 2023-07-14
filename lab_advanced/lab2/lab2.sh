if [ "$1" == "comp" ]
then
gcc -O0 -S mm.c -o ./output/S/mm_O0.s
gcc -O1 -S mm.c -o ./output/S/mm_O1.s
gcc -O2 -S mm.c -o ./output/S/mm_O2.s
elif [ "$1" == "run" ]
then
gcc -O0 -o ./output/executable/mm0 mm.c
gcc -O1 -o ./output/executable/mm1 mm.c
gcc -O2 -o ./output/executable/mm2 mm.c
gcc -O3 -funroll-loops -o ./output/executable/mm3 mm.c
elif [ "$1" == "test" ]
then
./output/executable/mm0
./output/executable/mm1
./output/executable/mm2
./output/executable/mm3
elif [ "$1" == "draw" ]
then
echo "draw"
elif [ $1 == "gen_data" ]
then
python3 gendata.py
else
echo "wrong usage of lab2.sh"
fi