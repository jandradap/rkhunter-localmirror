#!/bin/ash
# -*- ENCODING: UTF-8 -*-
#
# ------------------------------------------------------------------
# [Jorge Andrada Prieto] [jandradap@gmail.com]
# Title:
# Description:
# ------------------------------------------------------------------
#

#debug
# set -x
# trap read debug
VERSION=$1
VERSIONCORTA=$2
RUTA="/root/rkhunter-$VERSION/files/i18n/"

for i in $(ls $RUTA); do
    VERSION_ARCHIVO=$(head -n1 $RUTA/$i | awk -F ":" '{print$2}')
    echo "$i:$VERSION_ARCHIVO" >> /root/data/$VERSIONCORTA/i18n/$VERSION/i18n.ver
done
