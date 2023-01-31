#!/bin/bash

TARGET_FILE="tmp.txt"
TARGET_PORT=22
TARGET_STATUS_UP=`echo -e "\E[31m[ ADDRESS IS BUSY, PING SUCCESSFUL ]\E[0m"`
TARGET_STATUS_DOWN=`echo -e "\E[32m[ FREE ADDRESS, NO PING INFO ]\E[0m"`
TIME_STAMP=`date +%H:%M:%S`
LOG_FILE="`basename $0`.log"


do_ping() {
cat $TARGET_FILE | while read IP_ADDRESS
do

TARGET_HOST=`echo $IP_ADDRESS`

ping -i 2 -c 2 $TARGET_HOST > /dev/null 2>&1

if [ $? -eq 0 ] ; then
echo "$TIME_STAMP - Host $TARGET_HOST - $TARGET_STATUS_UP"
else
echo "$TIME_STAMP - Host $TARGET_HOST - $TARGET_STATUS_DOWN"
fi

done;
}

do_telnet() {
cat $TARGET_FILE | while read IP_ADDRESS
do

TARGET_HOST=`echo $IP_ADDRESS`

TELNET_RESULT=`sleep 5 | telnet $TARGET_HOST $TARGET_PORT | grep -v "Connection refused" | grep "Connected to" | grep -v grep | wc -l`

if [ $TELNET_RESULT -eq 1 ] ; then
echo -e "$TIME_STAMP - Port $TARGET_PORT of Host $TARGET_HOST is \E[31m[ PORT IS OPEN, ADDRESS IS BUSY ]\E[0m"
else
echo -e "$TIME_STAMP - Port $TARGET_PORT of Host $TARGET_HOST is \E[32m[ PORT IS UNREACHABLE, ADDRESS IS FREE ]\E[0m"
fi

done;
}

main() {
do_ping
do_telnet
}

main | tee -a $LOG_FILE
