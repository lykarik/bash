#!/bin/bash

hosts=(
"172.16.3.37 pg10a"
"172.16.2.72 ppak-app-timer-srv01"
)

look_host(){
IFS=";"
for i in ${hosts[*]}
do
	if [[ -z $(grep /etc/hosts -e '$i') ]]
	then
		echo "$i - was added"
	else
		echo $i | awk -F " " '{print $1" "$2}' >> /etc/hosts
	fi
done
}

look_host
