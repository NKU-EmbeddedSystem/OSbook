if [ -e ./input/A_1024.pkl ]
then
echo "Dataset already exists"
else
python3 gendata.py
fi
python3 mm.py

