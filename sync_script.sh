#!/bin/bash

command="/opt/jdk/last/bin/java -classpath "ext-bus-remote-ejb-client.jar" ru.lanit.hcs.integration.remote.ejb.client.rao"

show_help() {
        echo "============================================="
        echo "Require place for script:"
        echo -e "/home/jboss/utils\n"
        echo "Directory requires near script file:"
        echo -e "DRSORAO\nDTKO\nDURAO\nRAOANNUL\nRISURAO"
        echo "============================================="
        echo -e "Syntax: ./hcs-sync.sh [PATH_TO_CSV_GUID_FILE]\n"
        echo "============================================="
        echo "Usage example: ./hcs-sync.sh DTKO/HCSINT-12345.csv"
        echo -e "HCSINT-12345.csv should be in DTKO directory\n"
        echo "============================================="
        echo "Available options:"
        echo "-h, --help    Show this help and exit"
}

read task filename <<< $( echo $1 | awk -F "/" '{print $1" "$2}')

expansion=$( echo $filename | awk -F "." '{print $2}')
log=$( echo $filename | awk -F "." '{print $1}')".log"
output=$( echo $filename | awk -F "." '{print $1}')".out."$expansion

if [ -n "$task" ]
then
    case "$task" in
    -h | --help)
	show_help
	;;
    DTKO)
        $command.DocumentsTKOReplicationApp -h 670000 -i ./DTKO/$filename -o ./DTKO/$output 2>&1 | tee -a ./DTKO/$log
        ;;
    DRSORAO)
        $command.DocumentsRSOReplicationApp -i ./DRSORAO/$filename -o ./DRSORAO/$output 2>&1 | tee -a ./DRSORAO/$log
        ;;
    DURAO)
        $command.ManagementReplicationApp -i ./DURAO/$filename -o ./DURAO/$output 2>&1 | tee -a ./DURAO/$log
        ;;
    RAOANNUL)
        $command.AnnulApp -i ./RAOANNUL/$filename -o ./RAOANNUL/$output 2>&1 | tee -a ./RAOANNUL/$log
        ;;
    RISURAO)
        $command.DocumentsReplicationApp -i ./RISURAO/$filename -o ./RISURAO/$output 2>&1 | tee -a ./RISURAO/$log
        ;;
    *)
        echo "Wrong path to *.csv file. Please, try \"./hcs-sync.sh --help\" for input information"
        exit 1
        ;;
    esac
else
    show_help
fi
