#!/bin/bash
cat << "EOF"
  ,   .                        ,    ,-.
o |   |             o         '|   /  /\
. | , |-  ,-. ;-.-. .   . ,    |   | / |
| |<  |   | | | | | |   |/     |   \/  /
' ' ` `-' `-' ' ' ' '   '   o  ' o  `-'
EOF

echo " "

echo "Please choose an option:"

echo " "

echo ' 1) Start Listeners '
echo ' 2) Extract Summary '
echo ' 3) View Current Summary'
echo ' 4) Clean Up '
echo ' 5) Stop Listeners '
echo ' 6) Exit '

echo " "

read opt_value

echo " "

if [ $opt_value -eq 1 ]
then
clear
cd scripts; ./startup.sh
echo "Listeners have been started!"

elif [ $opt_value -eq 2 ]
then
clear
cd scripts; ./extractor.sh
echo "Summary has been extracted!"

elif [ $opt_value -eq 3 ]
then
clear
cp FINAL.log scripts/FINAL-tmp.log
cd scripts; cat FINAL-tmp.log
rm FINAL-tmp.log

elif [ $opt_value -eq 4 ]
then
clear
cd scripts; ./cleaner.sh
echo "Cleanup has finished!"

elif [ $opt_value -eq 5 ]
then
clear
cd scripts; ./shutdown.sh
echo "Listeners have been stopped!"

elif [ $opt_value -eq 6 ]
then
echo "Exiting..."
exit

else
clear
cd scripts;
echo "Wrong answer, please try again."

fi

echo " "

cd ..;  bash iktomi.sh
