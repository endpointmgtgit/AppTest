#!/bin/bash
#set -x

##############################################
##                                          ##
## Script to download Files to local device ##
##                                          ##
##############################################

# Define variables
fileurl='https://raw.githubusercontent.com/endpointmgtgit/AppTest/main/config_tmp.f5c'
filepath="/Library/Application Support/F5Networks/directory"
file="config_tmp.f5c"

scriptname="CopyFileF5ConfigFile"
logandmetadir="/Library/Logs/Microsoft/Intune/Scripts/$scriptname"
log="$logandmetadir/$scriptname.log"

## Check if the log directory has been created
if [ -d $logandmetadir ]; then
    ## Already created
    echo "# $(date) | Log directory already exists - $logandmetadir"
else
    ## Creating Metadirectory
    echo "# $(date) | creating log directory - $logandmetadir"
    mkdir -p $logandmetadir
fi

# start logging
exec 1>> $log 2>&1

echo ""
echo "##############################################################"
echo "# $(date) | Starting download of File"
echo "############################################################"
echo ""

##
## Checking if directory exists and create it if it's missing
##
if [ -d $filepath ]
then
    echo "$(date) | File dir [$filepath] already exists"
else
    echo "$(date) | Creating [$filepath]"
    sudo mkdir -p $filepath
fi

##
## Attempt to download the file. No point checking if it already exists since we want to overwrite it anyway
##

echo "$(date) | Downloading file from [$fileurl] to [$filepath/$file]"
sudo curl -L -o "$filepath/$file" $fileurl
if [ "$?" = "0" ]; then
   echo "$(date) | File [$fileurl] downloaded to [$filepath/$file]"
   exit 0
else
   echo "$(date) | Failed to download file from [$fileurl]"
   exit 1
fi