#!/usr/bin/env bash
# -*- coding: utf-8 -*-

[ -r "script/bootstrap.sh" ] && source "script/bootstrap.sh"

find $SOURCE_DIR/ -name $NAME_DATABASE_TEST -delete
