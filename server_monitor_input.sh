#!/usr/bin/bash

#################################################################
# Script Name  :   Server Monitor               		#
# Description  :   REST API monitor of server availability	#
#                                                       	#
# Last Update  :   10.02.2022                           	#
# Author:      :   @TheDaVinciCodes         			#
#################################################################

regex='(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'

echo Insert the URL:
read url_input
	
while ! [[ $url_input =~ $regex ]]
do
	echo Insert a valid URL to continue:
	read url_input
done

echo "Need authorization? (y/n)"
read -rsn1 yn_input
	
while true
do
	if [[ $yn_input = "y" ]]; then
		echo Insert the Authorization:
		read auth_input
		if [[ $auth_input = "" ]]; then
			echo Authorization can not be empty
			continue
		else
			break
		fi
	elif [[ $yn_input = "n" ]]; then
		break
	else
		echo "Insert 'y' for confirm or 'n' to reject"
		read -rsn1 yn_input
	fi
done

echo "Insert pause between response (in seconds)"
read pause_input

re='^[0-9]+$'

while ! [[ $pause_input =~ $re ]]
do
	echo error insert a value in number
	read pause_input
done
	

function status {

	local get_response=$(curl -k -s -o /dev/null -w "%{http_code}" --location --request GET "$url_input" --header "$auth_input")

	local NOW=$(date +%c)
	local RED="\e[31m"
	local GREEN="\e[32m"
	local ENDCOLOR="\e[0m"

	if [[ $get_response == "401" ]]; then
		echo -e "[$NOW] ${RED}Unauthorized!${ENDCOLOR} | Status: $get_response" 
	fi
	
	if [[ $get_response != "200" ]]; then
		echo -e "[$NOW] Server ${RED}offline${ENDCOLOR} | Status: $get_response" 
		echo -e "[$NOW] Server offline | Status: $get_response" >> monitor_log.txt
	else
		echo -e "[$NOW] Server ${GREEN}online${ENDCOLOR} | Status: $get_response"
		echo -e "[$NOW] Server online | Status: $get_response" >> monitor_log.txt
	fi
}

while true
do
status
sleep $pause_input
done

