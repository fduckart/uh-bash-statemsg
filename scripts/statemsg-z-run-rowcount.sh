#!/bin/bash

declare -r DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${DIR}/statemsg-includes.sh

${ORACLE_HOME}/bin/sqlplus<<COMMANDS
`/usr/bin/awk '/fmisadm/{print $1"/"$2}' ${SPECIAL_MAP_FILENAME}`
SET LINESIZE 200
select * from fmisadm.fmis_state_message;
select count(*) from fmisadm.fmis_state_message;
COMMANDS
