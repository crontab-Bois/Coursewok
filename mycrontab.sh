#!/bin/bash

while :
do

echo "1. Display Crontab Jobs"
echo "2. Insert a Job"
echo "3. Edit a Job"
echo "4. Remove a Job"
echo "5. Remove all Jobs"
echo "9. Exit"
echo "Please select an option."

read -r -n 1 selection
printf "\n"
case $selection in
1* )	echo "Option 1 selected";;
2* )	echo "Option 2 selected";;
3* )	echo "Option 3 selected";;
4* )	echo "Option 4 selected";;
5* )	echo "Option 5 selected";;
9* )	exit 0;;

* )	echo "Invalid Option, try again";;
esac
done
#while true; do
	#read input
	#if ["$input" = "1"]; then
		#echo "1 selected"
	#fi
#done
