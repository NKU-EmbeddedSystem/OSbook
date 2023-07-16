if [ -e ./input/shape_1/A_1.csv ]
then
echo "Dataset already exists"
else
python3 gendata.py
fi

if [ "$1" == "test" ]
then
gcc -O0 -S mm.c -o ./output/S/mm_O0.s
gcc -O1 -S mm.c -o ./output/S/mm_O1.s
gcc -O2 -S mm.c -o ./output/S/mm_O2.s
gcc -O0 -o ./output/executable/mm0 mm.c
gcc -O1 -o ./output/executable/mm1 mm.c
gcc -O2 -o ./output/executable/mm2 mm.c
gcc -O3 -funroll-loops -o ./output/executable/mm3 mm.c
./output/executable/mm0
./output/executable/mm1
./output/executable/mm2
./output/executable/mm3
else
echo "wrong usage of lab2.sh"
fi
