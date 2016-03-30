#!/bin/bash
for i in {1..800}; do echo "https://da.gd/template`printf "%03d" $i`" >> GeneratedLinks.csv; done
