#!/bin/bash

# Update variable with appropriate FTP address.
declare -r FTP_ADDRESS="username@server"

declare -r DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${DIR}/statemsg-includes.sh

check_setup
remove_file $INPUT_FILENAME
cleanup

log "INFO: Retrieving message file from AXWAY server."

/usr/bin/sftp -b ${DIR}/statemsg-sftp-commands.txt $FTP_ADDRESS
RETVAL=$?
if [ $RETVAL -ne 0 ] ; then
    log "ERROR: Getting message file from Axway: FAILED (return code: ${RETVAL})."
    remove_file  $DEFAULT_INPUT_FILENAME
    cleanup
    exit $FAILURE
fi

log "INFO: Sucessfully retrieved message file from Axway."
