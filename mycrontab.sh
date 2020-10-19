#!/bin/bash
echo "1. Display Crontab Jobs"
echo "2. Insert a Job"
echo "3. Edit a Job"
echo "4. Remove a Job"
echo "5. Remove all Jobs"
echo "9. Exit"

while true; do
	read -r input
	if ["$input" = "1"]; then
		echo "1 selected"
	fi
done
