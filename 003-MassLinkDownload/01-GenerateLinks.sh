#!/bin/bash
# Generate lines 1 - X with the string "https://da.gd/template" and add #'s 1 - x at the end of each line
# to a .csv file
for i in {1..800}; do echo "https://da.gd/template`printf "%03d" $i`" >> GeneratedLinks.csv; done
