lsattr /etc/* | grep -e "-i-" > check_immutables.txt
# lsattr /home/* | grep -e "-i-" >> check_immutables.txt
# lsattr /home/* | grep -e "-i-" >> check_immutables.txt

# need to 
# lsattr -aR 2>/dev/null | grep -e "-i-" >> check_immutables.txt
