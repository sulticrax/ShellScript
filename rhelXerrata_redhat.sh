#!/bin/bash -
##############################################################
# Author             : Christo Deale
# Date	             : 2022-05-31
# rhelXerrata_redhat : Inspect & Mitigate Errata Advisories
##############################################################
function menuprincipal () {
    clear
    echo " "
    echo " :: RHEL Errata Inspect & Mitigate :: "
    echo " "
    echo " Choose an option to get started 
        1 - (RHSA) RedHat Security Advisory
        2 - (RHBA) RedHat Bug Advisory 
        3 - (CVE)  Redhat Security CVE "
    echo " "
    read -r option
case $option in
	1) 
        function RHSA () {
            yum updateinfo list | grep "RHSA-*"                        # expect something like:
            echo " Enter RHSA-NUM to Inspect Advisory "                # RHSA-2022:176   Important/Sec. bpftool-4.18.0-348.12.2.el8_5.x86_64
            read -r NUM 
            yum updateinfo info RHSA-$NUM                              
            echo ">>> Mitigate Advisory >>>                                  
                 1. YES
                 2. NO"
            choice="1 2"
            select option in $choice; do
                if [ $REPLY = 1 ]
                then 
                    yum update --advisory=RHSA-$NUM
                else
                    exit 1
                fi
        done
	    }
        RHSA 
    ;;
	2)  
        function RHBA () {
            yum updateinfo list | grep "RHBA-*"                       # expect something like:
            echo "Enter RHBA-NUM to Inspect Advisory "                # RHBA-2021:2578  bugfix  unzip-6.0-45.el8_4.x86_64
            read -r NUM                      
            yum updateinfo info RHBA-$NUM
            echo ">>> Mitigate Bug Advisory >>>
                 1. YES
                 2. NO"
            choice="1 2"
            select option in $choice; do
                if [ "$REPLY" = 1 ] 
                then 
                    yum update --advisory=RHBA-$NUM
                else
                    exit 1
                fi
                done
		}
        RHBA
    ;;
    3)  
        function CVE (){
            yum updateinfo list cves                                  # expect somthing like:
            echo "Enter CVE-NUM to Inspect CVE"                       # CVE-2021-43527 Critical/Sec.  nss-3.67.0-7.el8_5.x86_64
            read -r NUM                      
            yum updateinfo info --cve CVE-$NUM
            echo ">>> Mitigate CVE >>>
                 1. YES
                 2. NO"
            choice="1 2"
            select option in $choice; do
                if [ "$REPLY" = 1 ] 
                then
                    yum update --cve CVE-$NUM
                else
                    exit 1
                fi
                done
        }
        CVE 
    ;;
esac
}
menuprincipal
