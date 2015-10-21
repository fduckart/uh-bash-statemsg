#!/bin/bash

# The top-level home variable for these scripts and files.
declare -r SHOME="$(dirname $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ) )"

declare -r ARCHIVE_DIR="${SHOME}/archive"
declare -r SCRIPT_DIR="${SHOME}/scripts"
declare -r WORK_DIR="${SHOME}/work"
declare -r LOGGING_DIR="${SHOME}/logs"
declare -r LOGGING_FILENAME="log.out"
declare -r LOGGING_PATH="${LOGGING_DIR}/${LOGGING_FILENAME}"
declare -r DEFAULT_INPUT_FILENAME="STATE-UH-MSG.TXT"
declare -r WORK_FILENAME="STATE-UH-MSG-MODIFIED.TXT"
declare -r SPECIAL_MAP_FILENAME="/home/username/uh/smf"

declare -r -i SUCCESS=0
declare -r -i FAILURE=1
declare -r -i TRUE=0
declare -r -i FALSE=1

#
# FUNCTIONS
#

log() {
    local msg=$1
    local timestamp=$(date +"%Y-%m-%d.%H:%M:%S")
    local scriptname="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
    printf "[${timestamp}] [${scriptname}] ${msg}\n" 2>&1 | tee -a $LOGGING_PATH
}

remove_file() {
    local filename=$1
    if [ -e $filename ] ; then
        /bin/rm -f $filename
    fi
}

write_output_file() {
    local filename=$1
    local output_filename=$2

    remove_file ${output_filename}

    # Put all the lines of the file into an array.
    # Note, IFS stands for 'internal field separator'.
    IFS=$'\r\n' ; lines=($(cat $filename))
    local num_lines=${#lines[@]}

    if [ $num_lines -lt 1 ] ; then
        log "INFO: Empty file, already done."
        return $SUCCESS
    fi

    while read line ; do
        printf '%s<br>' "${line}" >> ${output_filename}
    done < $filename

    printf "\n" >> ${output_filename}

    log "INFO: Finished writing output file '${output_filename}'."

    return $SUCCESS
}

file_exists() {
    local filename=$1

    if [ ! -e $filename ] ; then
        return $FALSE
    fi

    return $TRUE
}

archive_file() {
    local filename=$1
    local archivedir=${2:-${ARCHIVE_DIR}}
    local timestamp=$(date +"%Y%m%d.%H%M%S")
    /bin/chmod ug+rw "${filename}"
    /bin/mv -f "${filename}" "${archivedir}/$(basename ${filename}).${timestamp}"
    log "INFO: Archived '${filename}'."
    if file_exists "${filename}" ; then
        log "WARN: '${filename}' file not archived."
    fi
}

directory_exists() {
    local dir_name=$1

    if [ ! -d "$dir_name" ] ; then
        return $FALSE
    fi

    return $TRUE
}

check_setup() {
    if ! directory_exists $SHOME ; then
        printf "ERROR: The \$SHOME variable is not set to a real directory.\n"
        exit $FAILURE
    fi

    if ! directory_exists $LOGGING_DIR ; then
        printf "ERROR: Logging directory '$LOGGING_DIR' does not exist.\n"
        exit $FAILURE
    fi

    if ! directory_exists $ARCHIVE_DIR ; then
        log "ERROR: Archive directory '$ARCHIVE_DIR' does not exist."
        exit $FAILURE
    fi
}

cleanup() {
    if file_exists $WORK_FILENAME ; then
        remove_file $WORK_FILENAME
    fi
    if file_exists $DEFAULT_INPUT_FILENAME ; then
        remove_file $DEFAULT_INPUT_FILENAME
    fi
}

check_input_file() {
    local input_filename=$1

    if ! file_exists $input_filename ; then
        log "ERROR: Input file '$input_filename' does not exist."
        exit $FAILURE
    fi

    if [ ! -r "$input_filename" ] ; then
        log "ERROR: Input file '$input_filename' does not have read permission."
        exit $FAILURE
    fi
}
