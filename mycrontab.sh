#!/bin/bash

while :
do

echo "Please select an option:"
printf "\n"
echo "1. Display Crontab Jobs"
echo "2. Insert a Job"
echo "3. Edit a Job"
echo "4. Remove a Job"
echo "5. Remove all Jobs"
echo "9. Exit"

read -r -n 1 Selection
printf "\n"
case $Selection in
1* )	echo "Option 1 selected"
	crontab -l
	printf "\n";;

2* )	echo "Option 2 selected"
	echo "When would you like your job to run?"
	echo "Choose a day of the week (0-7) (Sunday = 0 or 7):"
	while :; do
		read -r DofW
		printf "\n"

		#this line uses regex to check that a number is entered and asks for a number
		#if an invalid character is entered.
		#the "^" makes sure that the input begins with a number
		#the "+" allows for multiple numbers to be entered
		#the "$" checks that there is nothing entered after the number
		[[ $DofW =~ ^[0-9]+$ ]] || { echo "Please enter a number:"; continue; }

		#this line checks if the entered number is between 0 and 7 inclusive.
		if ((DofW >= 0 && DofW <= 7)); then
			break
		else
			echo "Please enter a valid number (0-7):"
		fi
	done
	
	echo "Choose a month (1-12)"
	while :; do
		read -r Month
		printf "\n"

		[[ $Month =~ ^[0-9]+$ ]] || { echo "Please enter a number:"; continue; }
		if ((Month >= 1 && Month <= 12)); then
			break
		else
			echo "Please enter a valid number (1-12):"
		fi
	done

	echo "Choose a day of the month (1-31):"
	while :; do
		read -r DofM
		printf "\n"

		[[ $DofM =~ ^[0-9]+$ ]] || { echo "Please enter a number:"; continue; }
		if ((DofM >= 1 && DofM <= 31)); then
			break
		else
			echo "Please enter a valid number (1-31):"
		fi
	done

	echo "Choose an hour of the day (0-23):"
	while :; do
		read -r Hour
		printf "\n"

		[[ $Hour =~ ^[0-9]+$ ]] || { echo "Please enter a number:"; continue; }
		if ((Hour >= 0 && Hour <= 23)); then
			break
		else
			echo "Please enter a valid number (0-23):"
		fi
	done

	echo "Choose a minute of the Hour (0-59:)"
	while :; do
		read -r Minute
		printf "\n"

		[[ $Minute =~ ^[0-9]+$ ]] || { echo "Please enter a number:"; continue; }
		if ((Minute >= 0 && Minute <= 59)); then
			break
		else
			echo "Please enter a valid number (0-59):"
		fi
	done

	echo "Please type the name of the script you would like to run. Make sure that the script is saved in your job-scripts folder. For example ./job-scrpits/test1.sh you would type test1.sh"
	read -r Script
	printf "\n"

	Location=`pwd`

	crontab -l > tempcron
	echo "$Minute $Hour $DofM $Month $DofW $Location/job-scripts/$Script" >> tempcron
	crontab tempcron
	rm tempcron
	printf "\n";;

3* )	echo "Option 3 selected";;

4* )	echo "Option 4 selected";;

5* )	echo "Option 5 selected";;
	crontab -ir
	printf "\n"

9* )	exit 0;;

* )	echo "Invalid Option, try again";;
esac
done
