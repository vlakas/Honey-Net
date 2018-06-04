#!/bin/bash

cd ../logs

cat log25.log | grep -a "connection from" | cut -d " " -f 3 | cut -d ":" -f 1 | sort | uniq > port25.log
cat log80.log | grep -a "connection from" | cut -d " " -f 3 | cut -d ":" -f 1 | sort | uniq > port80.log
cat log21.log | grep -a "connection from" | cut -d " " -f 3 | cut -d ":" -f 1 | sort | uniq > port21.log
cat log8080.log | grep -a "connection from" | cut -d " " -f 3 | cut -d ":" -f 1 | sort | uniq > port8080.log
cat log443.log | grep -a "connection from" | cut -d " " -f 3 | cut -d ":" -f 1 | sort | uniq > port443.log

rm ../FINAL.log 2>/dev/null

echo "PORT 25: " >> ../FINAL.log
echo " " >> ../FINAL.log
cat port25.log >> ../FINAL.log
echo " " >> ../FINAL.log

echo "PORT 80: " >> ../FINAL.log
echo " " >> ../FINAL.log
cat port80.log >> ../FINAL.log
echo " " >> ../FINAL.log

echo "PORT 21: " >> ../FINAL.log
echo " " >> ../FINAL.log
cat port21.log >> ../FINAL.log
echo " " >> ../FINAL.log

echo "PORT 8080: " >> ../FINAL.log
echo " " >> ../FINAL.log
cat port8080.log >> ../FINAL.log
echo " " >> ../FINAL.log

echo "PORT 443: " >> ../FINAL.log
echo " " >> ../FINAL.log
cat port443.log >> ../FINAL.log
echo " " >> ../FINAL.log

rm port25.log
rm port80.log
rm port21.log
rm port8080.log
rm port443.log
