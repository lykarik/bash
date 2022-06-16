#!/bin/bash

#SEARCH FREE IP's script

# Why this script created?
# This script was created to automate search free ip (or set of ip's)
# for create new VM's on vSphere, as sample
#
# How it works?
# Script will parse input file (should be hosts file of something like that)
# Expected, input file contains ip addresses in use


grep -rnw hosts -e ansible_host | awk -F "=" '{print $2}' | awk -F " " '{print $1}' | grep -e '172.16.*' | sort | uniq


nodes=()
template=()

for ((i=1; i<=254; i++))
do
        template[i]=$i
done

echo ${template[*]}

nodes=$(grep -rw $1 -e 'ansible_host' | \
                awk -F "=" '{print $2}' | \
                awk -F " " '{print $1}' | \
                grep -e '172.16.233.*' | \
                uniq | \
                awk -F "." '{print $4}')

echo ${#nodes[*]}
printf "%s\n" "${nodes[@]}"
#exist_nodes=$(grep -rw $1 -e 'ansible_host' | \
#               awk -F "=" '{print $2}' | \
#               awk -F " " '{print $1}' | \
#               grep -e '172.16.233.*' | \
#               uniq | \
#               awk -F "." '{print $4}')
#
#echo $exist_nodes
#IFS=' '
#for i in $exist_nodes
#do
#       echo ${exist_nodes[*]}
#       echo ${#exist_nodes[*]}
#done
