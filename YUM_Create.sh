#!/bin/bash
CD_PATH=/dev/sr0
YUM_PACKGES=/yum_repodate/X86_64
MOUNT_FILE=/mnt/hgfs

##mount CD 
if [ -e $CD_PATH ];then
    mount $CD_PATH $MOUNT_FILE &> /dev/null
else 
    echo "This is a wrong CD_PATH:$CD_PATH..."
    exit 1
fi

##create YUM repodate 
{
if [ -d $YUM_PACKGES/X86_64 ];then 
    cp -r $MOUNT_FILE/Packages/* $YUM_PACKGES
else
    mkdir -p $YUM_PACKGES
    cp -r $MOUNT_FILE/Packages/* $YUM_PACKGES
fi


    rpm -ivh $MOUNT_FILR/Packages/`ls $MOUNT_FILE/Packages/ | grep createrepo`
    createrepo -o -u -d $YUM_PACKGES/
    createrepo -g $MOUNT_FILE/repodata/6221039e7e3dabf7d538c76571d82aaf42b6292b8f6fe6cf56b8fcf1cff3d3ab-comps-rhel6-Server.xml $YUM_PACKGES/
}&>/dev/null
## write repo file 
#if [ -f "/etc/yum.repos.d/*.repo" ]
#    mv /etc/yum.repos.d/
#fi

if [ ! -f  /etc/yum.repos.d/mylocalyum.repo ];then
cat <<EOF>> /etc/yum.repos.d/mylocalyum.repo
[mylocalyum]
name=mylocalyum
baseurl=file://$YUM_PACKGES
enabled=1
gpgcheck=0
EOF
fi

{
yum clean all
yum makecache
}&>/dev/null
yum repolist 
