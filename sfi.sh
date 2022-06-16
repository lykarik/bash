#!/bin/bash

#SEARCH FREE IP's script

# Why this script created?
# This script was created to automate search free ip from chosen pool (or set of ip's)
# for create new VM's on vSphere, as sample
#
# How it works?
# Script will parse input file (should be hosts file of something like that)
# Expected, input file contains ip addresses in use

show_help() {
        echo -e "\n==============================\n"
        echo "ERROR! Input arguments are empty!"
        echo -e "\n=============================="
        echo -e "Usage is:\n"
        echo "./sfi.sh <filename> <network without host octet>"
        echo -e "\n=============================="
        echo -e "Sample of usage:\n"
        echo "./sfi.sh hosts 172.16.233  <---last octet is absent"
        echo -e "\n\n\n-h, --help - Show this help and exit"
        echo -e "\n==============================\n"
}

if [ -z $1 ] || [ -z $2 ]
then
        case "$1" in
        -h | --help)
                show_help
                exit 1
                ;;
        *)
        echo "Argument are absent. Please, try \"./sfi.sh --help\" for input information"
        exit 1
        ;;
    esac
fi

search_mask=$2".*"

template=()
for ((i=1; i<=254; i++))
do
        template[i]=$i
done

nodes=($(grep -rw $1 -e "ansible_host" | \
                awk -F "=" '{print $2}' | \
                awk -F " " '{print $1}' | \
                grep -e $2".*" | \
                uniq | \
                awk -F "." '{print $4}'))

for x in ${!nodes[*]}
do
        for y in ${template[*]}
        do
        if [[ ${nodes[x]} -eq $y ]]
        then
                template[y]=0
        fi
                continue
        done
done

for i in ${template[*]}
do
        if [[ -n ${template[i]} ]]
        then
                echo $2"."${template[i]}
        fi
done > result.txt
