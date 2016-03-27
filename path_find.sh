#!/bin/bash
#
#used for:
#find file under the  one or more file path
#and the find path is decleared by PATH
#
#program:
#pathfind [options] [filename1] [filename2] ....
#filename means what file do you want to find 
#
#github:github.com/whoistr
#

#just set IFS as space,enter and tab.to avoid attack by IFS's problem
IFS='   
'          
#set PATH as IFS
OLDPATH=PATH
PATH=/bin:/usr/bin
export PATH

no_list=
PROGRAM=`basename $0`
VERSION=1.0
all='no'

#consider the error part
error(){
    echo "$@" 1>&2     #printf on the standerr
    usage_and_exit 1 
}
usage(){
    echo "Usage: $PROGRAM [--version] [--help] [-a|--all] filename1 filename2... "
}
usage_and_exit(){
    usage
    exit $1    
}
help_and_exit(){
    cat << EOF
-a,--a    : Find the file followed by recycling the path otherwise only find one.
--version : Show the $PROGRAM's version
--help    : Show help about the $PROGRAM
EOF
exit 0    
}

##the function version
version(){
cat << EOF
$PROGRAM version  $VERSION

This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
    
Written by Rong Tang.
Github address: github.com/whoistr
EOF
}

#used for testing the option

[ $# -eq 0 ] && usage_and_exit 2
while [ $# -gt 0 ]
    do
        case $1 in
            -a | --all | --al | --a )
                all=yes
                ;;      #use ; can know all situation being stoped.
            -v | --version| --vers | --versi |--versio )
                version
                exit 0
                ;;
            -h | --help | --h | --hel )
                 usage
                 help_and_exit
                ;;
            -*)
                error "Unrecognized option : $1"
                exit 0 
                ;;
             *)
                break
                ;;
        esac
        shift 
    done

#test

[ $# -eq 0 ] && error "There is not have file need to be found..."

#filelist is the pathlist 
#num used for checking when all=yes,if the while ran the $num times && haven't find
filelist=`echo $PATH | sed 's/:/ /g'`
num=$(echo $filelist|sed 's/ /\n/g' |wc -l)

# usage situations
[ -z "$filelist" ] && error "Searching path is empty"


while [ $# -gt 0 ]
    do  
        allpath=0
        for filepath in $filelist/$1
            do 
                if [ -f $filepath ];then
                    
                    echo -e  "\e[1;32m`basename $filepath` \e[0m: $filepath"
                    if [ $all == 'no' ];then 
                        break
                    fi 
                else 
                    allpath=$((allpath+1))
                fi
            done
        if [ $allpath == $num ];then 
                echo -e  "\e[1;31m`basename $filepath` \e[0m is not find..."
                
        fi
    shift
    done
     
exit 0
