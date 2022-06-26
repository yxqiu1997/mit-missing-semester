#!/usr/bin/env bash

count=0
until [[ "$?" -ne 0 ]];
do
    count=$(( count + 1 ))
    sh command.sh &> output.txt
done

echo "After "$count" runs"
cat output.txt
