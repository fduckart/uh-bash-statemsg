#!/bin/bash

clear

echo ".........................."
echo "Directory layout should be: "
echo "  statemsg      "
echo "    archive  "
echo "    control  "
echo "    logs     "
echo "    scripts  "
echo "    work     "

echo ".........................."
echo "Make sure the ORACLE system environment variables are set:"
echo "    ORACLE_SID     [current setting '${ORACLE_SID}']"
echo "    ORACLE_HOME    [current setting '${ORACLE_HOME}'"

echo ".........................."
echo "Make sure to update the SFTP command text file: "
echo "    [Commands set in 'statemsg-sftp-commands.txt'] "

echo ".........................."
echo "Make sure to update constants at the top of the scripts: "
echo "    FTP_ADDRESS    [set in 'statemsg-sftp.sh'] "

echo ".........................."
echo "Make sure to update the email constant at the top of this script: "
echo "    EMAIL_ADDRESS  [set in 'statemsg-email.sh'] "

echo ".........................."
echo "For more information"
echo "    UH Paystub wiki: https://www.hawaii.edu/bwiki/x/1owaDg "
echo "    UH ETL wiki    : https://www.hawaii.edu/bwiki/x/0YwaDg "
echo