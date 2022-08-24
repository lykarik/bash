#!/bin/bash

NGINX_CONF="/etc/nginx/nginx.conf"
UI_SERVER="ppak-app-ui-srv04"

read task <<< $( echo $1 )

echo $NGINX_CONF

#ilead='^# ext-soap-backend$'
#tail='^# rest-passports-backend$'
#sed -e "/$lead/,/$tail/{ /$lead//$tail/p }"  nginx.conf

#sed -n '/# ext-soap-backend/, /# rest-passports-backend/p' nginx.conf

#sed -i '/# ext-soap-backend/, /# rest-passports-backend/{ s/#server ppak-app-ui-srv04/server ppak-app-ui-srv04/}' nginx.conf
#sed -n '/# ext-soap-backend/, /# rest-passports-backend/p' nginx.conf


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
