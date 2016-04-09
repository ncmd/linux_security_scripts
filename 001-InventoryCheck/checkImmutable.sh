#!/bin/bash
# Find files that are immutable

# With chattr -i
lsattr /etc/* | grep -e "-i-" > check_immutables.txt
# lsattr /home/* | grep -e "-i-" >> check_immutables.txt

# With chattr -a

# Other
# lsattr -aR 2>/dev/null | grep -e "-i-" >> check_immutables.txt
