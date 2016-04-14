#########################
##used for:
##monitor control
##auther:
##Rong Tang
##program
##
##################
#!/bin/bash

numbers=0
i=0
SHELL_DIR=/root/SHELL_Software
EXIT_CODE=0
declare -A ARRYSHELL

usage(){
    echo "Usage:$1"
    EXIT_CODE=$((EXIT_CODE+1)) 
}

error(){
    usage $1
    exit $EXIT_CODE
}

[ ! -d $SHELL_DIR ] && error "$SHELL_DIR is not a directory or have no this directory..."

for shell_scripts in `ls -I monitor_control.sh "$SHELL_DIR"`
do
    [ -d $shell_scripts ] && shell_scripts=`ls "$shell_scripts"| grep ".sh" `
    [ -z $shell_scripts ] && continue 
    echo -e "\e[1;31m The scripts $i \e[0m -----> ${shell_scripts}"
    ARRYSHELL[$i]="${shell_scripts}" 
   # echo "ARRYSHELL[$i]=${ARRYSHELL[$i]}"
    i=$((i+1)) 
    numbers="$numbers | $i "
done

while true
do
    read -p "please input the numbers (${numbers}| q):" shellnumber
    [ $shellnumber == 'q' ] && exit $EXIT_CODE
    if [[ ! ${shellnumber} =~ ^[0-9]+ || ${shellnumber} -gt $i ]];then
        usage "$shellnumber is wrong number..."
    fi
    /bin/sh ${ARRYSHELL[$shellnumber]}
done

[ $EXIT_CODE -gt 125 ] && EXIT_CODE=125
exit $EXIT_CODE 




