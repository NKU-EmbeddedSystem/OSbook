if [ -e ./input/A_1024.csv ]
then
echo "Dataset already exists"
else
python3 gendata.py
fi
if [ -e ./output/time/time.txt ]
then
rm ./output/time/time.txt
fi
touch ./output/time/time.txt
printf "time\n" > ./output/time/time.txt

gcc -O0 -S mm.c -o ./output/S/mm_O0.s
gcc -O1 -S mm.c -o ./output/S/mm_O1.s
gcc -O2 -S mm.c -o ./output/S/mm_O2.s
gcc -O3 -funroll-loops -S mm.c -o ./output/S/mm_O3.s
gcc -O0 -o ./output/executable/mm0 mm.c
gcc -O1 -o ./output/executable/mm1 mm.c
gcc -O2 -o ./output/executable/mm2 mm.c
gcc -O3 -funroll-loops -o ./output/executable/mm3 mm.c
printf "O0: " >> ./output/time/time.txt
./output/executable/mm0
printf "O1: " >> ./output/time/time.txt
./output/executable/mm1
printf "O2: " >> ./output/time/time.txt
./output/executable/mm2
printf "O3: " >> ./output/time/time.txt
./output/executable/mm3
python3 draw.py

