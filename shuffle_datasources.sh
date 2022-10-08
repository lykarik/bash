#!/bin/bash

NGINX_CONF="/etc/nginx/nginx.conf"

read task UI_SERVER <<< $( echo $1 | awk '{print $1" "$2}' )

echo $NGINX_CONF


if [ -n "$task" ]
then
    case "$task" in
    -h | --help)
        echo "here will be help info"
        exit 1
        ;;
    -exclude)
        sed -i "/# ext-soap-backend/, /# rest-passports-backend/{ s/server $UI_SERVER/#server $UI_SERVER/}" nginx.conf
        sed -n '/# ext-soap-backend/, /# rest-passports-backend/p' nginx.conf
        ;;
    -include)
        sed -i "/# ext-soap-backend/, /# rest-passports-backend/{ s/#server $UI_SERVER/server $UI_SERVER/}" nginx.conf
        sed -n '/# ext-soap-backend/, /# rest-passports-backend/p' nginx.conf
        ;;
    *)
        echo "temporary plug"
    esac
else
    echo "here will be help info"
fi
