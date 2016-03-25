#!/bin/bash

while IFS=: read  NAME PASSWD Uid GID MESSAGE Path SHELL
do
    SHELL=${SHELL:-/bin/sh}
    filename="/tmp/`echo $SHELL | sed -e 's;^/;;g' -e 's;/;-;g'`"
    echo "$NAME", >> $filename.mail_list
done </etc/passwd
