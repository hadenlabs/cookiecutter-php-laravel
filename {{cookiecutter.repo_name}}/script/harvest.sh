#!/usr/bin/env bash
# -*- coding: utf-8 -*-

[ -r "script/bootstrap.sh" ] && source "script/bootstrap.sh"

cd $SOURCE_DIR

if [[ "$1" == "all" ]]; then
    python manage.py harvest  --settings=$DJANGO_SETTINGS_TEST apps/*/features/u*
    exit
fi
python manage.py harvest  --settings=$DJANGO_SETTINGS_TEST apps/*/features/$1/$1.feature
