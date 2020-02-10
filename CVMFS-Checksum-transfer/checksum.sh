#!/bin/bash
#1 The local file that has to be uploaded
#2 The user@server string
#3 The remote path on the server
inputfile=$1
#md5ext=".md5"
#outputfile=$1$md5ext
md5=($(md5sum $inputfile))
echo $md5
gsiscp -P 1975 $inputfile $2:$3 # This might have to be changed to gsi-scp
echo "File transfered"
rem_md5=($(gsissh -p 1975 $2 md5sum $3/$1)) #Change this to gsi-ssh
echo "Logging onto remote"
if [ "$md5" = "$rem_md5" ]; then
    echo "The file has been uploaded successfully"
else
    echo "The uploaded file is corrupted or have not been uploaded correctly"
fi
