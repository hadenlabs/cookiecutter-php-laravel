#!/usr/bin/env bash
# -*- coding: utf-8 -*-

[ -r "script/bootstrap.sh" ] && source "script/bootstrap.sh"

cd $SOURCE_DIR

if [[ "$1" == "all" ]]; then
    python manage.py behave --settings=$DJANGO_SETTINGS_TEST --no-capture --use-existing-database --no-skipped
else
    python manage.py behave --settings=$DJANGO_SETTINGS_TEST --tags $1 --no-capture --use-existing-database --no-skipped
fi
