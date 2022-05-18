#!/bin/bash -
##############################################################
# Author      : Christo Deale
# Date	      : 2022-05-18 
# rhelXupdate : does an full errata / security update or a 
#               full update on all but kernel.
##############################################################
echo "Current Status:"
yum updateinfo
echo " >>>> RedHat Enterprise Linux Updater >>>>
      Please choose from the following options:
      1. Errata / Security & Bugfix Updates only
      2. Update all but kernel"

choice="1 2"

select option in $choice; do
        if [ $REPLY = 1 ];
        then
                yum -y update --security --bugfix --exclude=kernel*
                yum clean all
                exit 1
        else
                yum -y update --exclude=kernel*
                yum clean all
                exit 1
        fi
done