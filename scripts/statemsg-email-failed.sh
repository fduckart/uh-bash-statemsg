#!/bin/bash

declare -r EMAIL_ADDRESS="username-or-list@hawaii.edu"
declare -r SUBJECT="State Message Successfully Processed"
declare -r TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

# Send out email stating failure.
/bin/mailx -s "$SUBJECT" "$EMAIL_ADDRESS" <<MESSAGE
State Message processing FAILED. See program log.

${TIMESTAMP}
MESSAGE
