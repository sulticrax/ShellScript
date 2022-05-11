#!/bin/bash -
##############################################################
# Author        : Christo Deale
# Date	        : 2022-05-11 
# en(de)cryptor : simple file encrypter / decrypter
##############################################################

echo "this is a simple file encrypter/decrypter"
echo "please choose what you want to do:"

choice="encrypt decrypt"

select option in $choice; do
        if [ $REPLY = 1 ];
        then
                echo "enter file name to encrypt"
                read file;
                gpg -c $file
                echo "$file has been encrypted"
        else
                echo "enter file name to decrypt"
                read file2;
                gpg -d $file2
                echo "$file2 has been decrypted"
        fi
done