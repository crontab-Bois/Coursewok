#!/bin/bash

while :
do

#this displays all of the options that the user can select from.
echo "Please select an option:"
printf "\n"
echo "1. Display Crontab Jobs"
echo "2. Insert a Job"
echo "3. Edit a Job"
echo "4. Remove a Job"
echo "5. Remove all Jobs"
echo "9. Exit"

#takes in the users keypress and jumps to the requested option.
read -r -n 1 Selection
printf "\n"
case $Selection in

#the crontab -l command is executed to display all of the users crontab jobs.
1* )	echo "Option 1 selected"
	crontab -l
	printf "\n";;

2* )	echo "Option 2 selected"
	echo "When would you like your job to run?"
	echo "Choose a day of the week (0-7) (Sunday = 0 or 7):"
	while :; do
		read -r DofW
		printf "\n"

		#this line uses regex to check that a number is entered and asks for a number-
		#if an invalid character is entered.
		#the "^" makes sure that the input begins with a number
		#the "+" allows for multiple numbers to be entered
		#the "$" checks that there is nothing entered after the number
		[[ $DofW =~ ^[0-9]+$ ]] || { echo "Please enter a number:"; continue; }

		#this line checks if the entered number is between 0 and 7 (inclusive) and prints an error message if not.
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

		#this line uses regex to check that a number is entered and asks for a number-
		#if an invalid character is entered.
		#the "^" makes sure that the input begins with a number
		#the "+" allows for multiple numbers to be entered
		#the "$" checks that there is nothing entered after the number
		[[ $Month =~ ^[0-9]+$ ]] || { echo "Please enter a number:"; continue; }

		#this line checks if the entered number is between 1 and 12 (inclusive) and prints an error message if not.
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

		#this line uses regex to check that a number is entered and asks for a number-
		#if an invalid character is entered.
		#the "^" makes sure that the input begins with a number
		#the "+" allows for multiple numbers to be entered
		#the "$" checks that there is nothing entered after the number
		[[ $DofM =~ ^[0-9]+$ ]] || { echo "Please enter a number:"; continue; }

		#this line checks if the entered number is between 1 and 31 (inclusive) and prints an error message if not.
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

		#this line uses regex to check that a number is entered and asks for a number-
		#if an invalid character is entered.
		#the "^" makes sure that the input begins with a number
		#the "+" allows for multiple numbers to be entered
		#the "$" checks that there is nothing entered after the number
		[[ $Hour =~ ^[0-9]+$ ]] || { echo "Please enter a number:"; continue; }

		#this line checks if the entered number is between 0 and 23 (inclusive) and prints an error message if not.
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

		#this line uses regex to check that a number is entered and asks for a number-
		#if an invalid character is entered.
		#the "^" makes sure that the input begins with a number
		#the "+" allows for multiple numbers to be entered
		#the "$" checks that there is nothing entered after the number
		[[ $Minute =~ ^[0-9]+$ ]] || { echo "Please enter a number:"; continue; }

		#this line checks if the entered number is between 0 and 59 (inclusive) and prints an error message if not.
		if ((Minute >= 0 && Minute <= 59)); then
			break
		else
			echo "Please enter a valid number (0-59):"
		fi
	done

	echo "Please type the name of the script you would like to run. Make sure that the script is saved in your job-scripts folder. For example ./job-scripts/test1.sh you would type test1.sh"
	read -r Script
	printf "\n"

	Location=`pwd`

	#when a cron job is created while no other jobs are active an error message will
   	#be returned '2>/dev/null' removes the message to avoid confusion.
	crontab -l > tempcron 2>/dev/null
	echo "$Minute $Hour $DofM $Month $DofW $Location/job-scripts/$Script" >> tempcron
	crontab tempcron
	rm tempcron
	printf "\n";;

3* )	echo "Option 3 selected";;

4* )	echo "Option 4 selected"
	echo "Please enter the name of the job you would like to remove, this will be the same as the name of the script. For example ./job-scripts/test1.sh you would type test1.sh"
	read -r Job
	
	#this line looks through all of the users cron jobs and compares them to the name of the job that the user chose to delete, and then once it is found it is deleted.
	crontab -l | grep -v $Job | crontab -
	echo " Job successfully removed."
	printf "\n";;

5* )	echo "Option 5 selected"
	echo "This will delete all pre-existing cron jobs, press 'y' to confirm"

	#this line will delete all of the users cron jobs but will ask for conformation before executing.
	crontab -ir
	echo "All jobs removed successfully."
	printf "\n";;

9* )	exit 0;;

#this error message is printed when the user does not select one of the given options. 
* )	echo "Invalid Option, try again";;
esac
done
