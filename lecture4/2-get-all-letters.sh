#!/usr/bin/env bash

for y in {a..z}
do
    for x in {a..z}
    do 
        echo "$y$x" >> 1-all-letters.txt
    done
done
