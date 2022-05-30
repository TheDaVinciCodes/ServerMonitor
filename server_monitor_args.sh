#!/usr/bin/bash

#################################################################
# Script Name  :   Server Monitor               				#
# Description  :   REST API Monitor of server availability		#
#                                                       		#
# Last Update  :   10.02.2022                           		#
# Author:      :   @TheDaVinciCodes         					#
#################################################################
 

# This Bash-Script monitors the server response by getting
# the HTTP Code through a cURL library. The Output Response will be 
# displayed both in console and in an appender file named monitor_log.txt.

# To run give ./server_monitor_v2.sh <url> <seconds to sleep>
# exemple: ./server_monitor_v2.sh https://www.google.com/ 2

get_response=$(curl -k -s -o /dev/null -w "%{http_code}" --location --request GET "$1")

function status() {

	local NOW=$(date +%c)
	
	local RED="\e[31m"
	local GREEN="\e[32m"
	local ENDCOLOR="\e[0m"

	if [ $get_response != "200" ]; then
		echo -e "[$NOW] Server ${RED}offline${ENDCOLOR} | Status: $get_response" 
		echo -e "[$NOW] Server offline | Status: $get_response" >> monitor_log.txt
	else
		echo -e "[$NOW] Server ${GREEN}online${ENDCOLOR}  | Status: $get_response"
		echo -e "[$NOW] Server online | Status: $get_response" >> monitor_log.txt
	fi
}

this_script=$(basename $BASH_SOURCE) 

while true
do
if [[ $# -eq 0 ]] ; then
    echo "Missing arguments"
	echo "To run give: ./$this_script <url> <pouse in seconds>"
	break
fi

status $get_response
sleep $2
done
