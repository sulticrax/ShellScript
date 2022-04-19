#!/bin/bash -
##############################################################
# Author: Christo Deale
# Date	: 2022-04-14 
# RemoteBackup :    Mounts remote Win10 HDD & does incremental 
#                   backup to location, tar.gz folder, move out 
#                   of root partition & unmounts HDD. Repeat on
#                   a weekly crontab.
# 
# sidenote: sudo yum install mailx
#           mfifo /var/spool/postfix/public/pickup
#           service postfix restart
##############################################################
#
# Set Environment variables
###########################

LOG=/bckup/bckup.log
EMAIL=user@email.com     
IP='youriphere'           
HOSTNAME='hostname'            

#
# Verify if Client online
###########################

ping -c 1 $IP 2>/dev/null 1>/dev/null
if [ "$?" = 0 ];
        then
                echo "$(date '+%Y/%m/%d_%H:%M')_$HOSTNAME-$IP is UP" >> $LOG
                mount -t cifs -o username=username,password=password //youriphere/kdlabshare /mnt/kdlabshare
        else
                echo "Subject: $IP is DOWN" | sendmail $EMAIL
                echo "Unable to connect"
fi

#
# Function Start
###########################

function check_dir_loc {
    #check for dir list file
    if [ ! -s "/backupsource.conf" ]
    then
        echo "Enter location of Mounted Directory in backupsource.conf in root, if not exists, create."   
        exit 1
    fi
}
function check_backup_loc {
    if [ ! -s "/backupdest.conf" ]
    then
        echo "Enter location of backup location in backupdest.conf in root"      
        exit 1                                                                                   
    fi
}
function check_schedule {
    #check to see if script exists in weekly cron directory
    if [ ! -s "/etc/cron.weekly/kdbackup" ]
        echo "The backup schedule has been set to run weekly"
        echo "The exact run time is in the /etc/crontab file"
        exit 1
    fi
}
function perform_backup {
    #get backup location
    backup_path=$(cat /backupdest.conf)

    echo ">>> starting backup >>>" > $LOG
    #for each dir, archive & compress to backup location
    while read dir_path
    do
        rsync -av /mnt/kdlabshare/ /bckup/kdlabshare
        tar -czf kd_$(date +%Y%m%d).tar.gz /bckup/
        mv *tar.gz /home/username/2022_bckups/
        umount //youriphere/kdlabshare

        echo "Backup of $dir_name completed" >> $LOG
    done < /backupsource.conf

    echo ">>> backup complete at: >>>" $LOG
    date >> $LOG
}
#
# Function calls
###########################
check_dir_loc
check_backup_loc
check_schedule
perform_backup
