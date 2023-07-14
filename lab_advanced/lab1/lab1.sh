if [ $1 == "gen_data" ]
then
python3 gendata.py
elif [ $1 == "test" ]
then
python3 mm.py
else
echo "wrong usage of lab1.sh"
fi
