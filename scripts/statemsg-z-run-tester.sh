#!/bin/bash

SCRIPT_NAME="statemsg-z-run-tester.sh"
CONFIG_HOME=`pwd`
if [ ! -e ${CONFIG_HOME}/${SCRIPT_NAME} ]; then
  echo "You must run this script from the directory where it exists."
  exit 1
fi

printf "\n"
./statemsg-sftp.sh
./statemsg-reformat.sh
./statemsg-sql-loader.sh
