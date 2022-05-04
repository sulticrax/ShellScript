#!/bin/bash -
##############################################################
# Author   : Christo Deale
# Date	   : 2022-05-04
# passwdgen: generate secure password
##############################################################

echo "========= passwdgen password generator ========="
echo "Enter the length of the password & press enter"
read PASS_LENGTH

for p in $(seq 1 );
do
	pwgen -cnys $PASS_LENGTH 1
done