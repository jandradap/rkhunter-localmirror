#!/bin/bash
# -*- ENCODING: UTF-8 -*-
#
# ------------------------------------------------------------------
# [Jorge Andrada Prieto] [jandradap@gmail.com]
# Title: entrypoint.sh
# Description: script para el inicio del container
# ------------------------------------------------------------------
#

FECHA=$(date +"%Y%m%d%S")
var=${MIRRORS:="http://changeme,"}
IFS=',' read -a MIRRORS <<<"$(echo $MIRRORS)"
echo "Version:$FECHA" > /usr/share/nginx/html/mirrors.dat

for item in ${MIRRORS[*]}
do
    echo "local=$item" >> /usr/share/nginx/html/mirrors.dat
done

nginx -g "daemon off;"
