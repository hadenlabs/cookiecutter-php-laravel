#!/usr/bin/env bash
# -*- coding: utf-8 -*-

[ -r "script/bootstrap.sh" ] && source "script/bootstrap.sh"

cd $SOURCE_DIR

echo "execute $1"

# python manage
python manage.py "$1"
