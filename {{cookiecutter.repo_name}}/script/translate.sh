#!/usr/bin/env bash
# -*- coding: utf-8 -*-

[ -r "script/bootstrap.sh" ] && source "script/bootstrap.sh"

cd $SOURCE_DIR

if [ "$1" = "all" ]; then
    python manage.py makemessages -all
    python manage.py compilemessages
    exit
fi
python manage.py compilemessages
