#!/bin/bash

hosts=(
"2"
"1"
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
