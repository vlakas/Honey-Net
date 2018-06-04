#!/bin/bash

perl ../listeners/plist21.pl > ../logs/log21.log &

perl ../listeners/plist25.pl > ../logs/log25.log &

perl ../listeners/plist80.pl > ../logs/log80.log &

perl ../listeners/plist443.pl > ../logs/log443.log &

perl ../listeners/plist8080.pl > ../logs/log8080.log &
