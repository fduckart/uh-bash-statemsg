#!/bin/bash

# Update this variable with the appropriate path.
declare -r ORACLE_SQLLDR=${ORACLE_HOME}/bin/sqlldr

declare -r DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${DIR}/statemsg-includes.sh
declare -r STMSG_CTLFILE="${SHOME}/control/statemsg.ctl"
declare -r STMSG_DATAFILE="${SHOME}/scripts/${WORK_FILENAME}"
declare -r STMSG_LOGFILE="${SHOME}/logs/statemsg.log"

log "INFO: Starting SQL Loader data processing. Database: ${ORACLE_SID}"

if ! file_exists ${STMSG_DATAFILE} ; then
    log "ERROR: modified working file '${STMSG_DATAFILE}' does not exist, exiting."
    exit $FAILURE
fi

check_setup

# Call SQL-Loader, using a 'here document' for the userid values.
${ORACLE_SQLLDR} control="${STMSG_CTLFILE}" data="${STMSG_DATAFILE}" \
bad="${STMSG_DATAFILE}.bad" load="1" log="${STMSG_LOGFILE}" <<LOGIN
`/usr/bin/awk '/fmisadm/{print $1"/"$2}' ${SPECIAL_MAP_FILENAME}`
LOGIN

if file_exists ${STMSG_LOGFILE} ; then
    archive_file ${STMSG_LOGFILE}
fi

if file_exists "${STMSG_DATAFILE}.bad" ; then
    archive_file "${STMSG_DATAFILE}.bad"
fi

log "INFO: Removing working file '${WORK_FILENAME}'."
remove_file "${WORK_FILENAME}"

# Send out email stating success.
log "INFO: Sending out email notification."
${DIR}/statemsg-email.sh

exit ${SUCCESS}
