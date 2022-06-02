#!/bin/bash -
##############################################################
# Author            : Christo Deale
# Date	            : 2022-06-02
# rhelXerrata_rocky : Inspect & Mitigate Errata Advisories
##############################################################
function menuprincipal () {
    clear
    echo " "
    echo " :: RHEL Errata Inspect & Mitigate :: "
    echo " "
    echo " Choose an option to get started 
        1 - (RLSA) RedHat Security Advisory
        2 - (RLBA) RedHat Bug Advisory 
        3 - (CVE)  Redhat Security CVE "
    echo " "
    read -r option
case $option in
	1) 
        function RLSA () {
            yum updateinfo list | grep "RLSA-*"                        # expect something like:
            echo " Enter RLSA-NUM to Inspect Advisory "                # RLSA-2022:176   Important/Sec. bpftool-4.18.0-348.12.2.el8_5.x86_64
            read -r NUM 
            yum updateinfo info RLSA-$NUM                              
            echo ">>> Mitigate Advisory >>>                                   
                 1. YES
                 2. NO"
            choice="1 2"
            select option in $choice; do
                if [ $REPLY = 1 ]
                then 
                    yum update --advisory=RLSA-$NUM
                else
                    exit 1
                fi
        done
	    }
        RLSA 
    ;;
	2)  
        function RLBA () {
            yum updateinfo list | grep "RLBA-*"                       # expect something like:
            echo "Enter RLBA-NUM to Inspect Advisory "                # RLBA-2021:2578     bugfix  unzip-6.0-45.el8_4.x86_64
            read -r NUM                      
            yum updateinfo info RLBA-$NUM
            echo ">>> Mitigate Bug Advisory >>>
                 1. YES
                 2. NO"
            choice="1 2"
            select option in $choice; do
                if [ "$REPLY" = 1 ] 
                then 
                    yum update --advisory=RLBA-$NUM
                else
                    exit 1
                fi
                done
		}
        RLBA
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