#!/bin/bash
mail="892677729@qq.com"
let io_limit=80
HOST=139.129.48.65
logfile="io_logfile"

if [ ! -f "$logfile" ];then 
    touch "$logfile"
fi

let flags=0
used=`ssh "$HOST"  "df" | grep "/dev/" | grep -v "/dev/sr0" | awk '{print  $5}' | sed 's/\%//'` 
for used_f in $used 
do
    if [ $used_f -gt $io_limit  ];then 
    
        let flags=1
        break
    fi
done

if [ "$flags" -eq 1 ]
then
    echo "disk is going to full " | mail -s "Disk will full" $mail
    date +'%F %T' >>$logfile
    echo "Disk is going to full " >>$logfile
fi

if [ "$flags" -eq 0 ]
then
   date +'%F %T' >>$logfile 
   echo "Disk is ok " >>$logfile  
fi 


