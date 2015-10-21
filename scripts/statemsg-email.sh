#!/bin/bash

declare -r EMAIL_ADDRESS="username-or-list@hawaii.edu"
declare -r SUBJECT="State Message Successfully Processed"
declare -r TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

# Send out email stating success.
/usr/mailx -s "$SUBJECT" "$EMAIL_ADDRESS" <<MESSAGE
1. State Message file was successfully SFTP-ed from State Axway Server.
2. Message was successfully reformatted for loading.
3. Message was successfully loaded into the database.

${TIMESTAMP}
MESSAGE
