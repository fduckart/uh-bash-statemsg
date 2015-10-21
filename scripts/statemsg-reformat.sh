#!/bin/bash

declare -r DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${DIR}/statemsg-includes.sh
declare -r INPUT_FILENAME=${1:-${DEFAULT_INPUT_FILENAME}}

check_setup
remove_file $WORK_FILENAME
check_input_file ${DIR}/${INPUT_FILENAME}
write_output_file ${DIR}/$INPUT_FILENAME ${DIR}/$WORK_FILENAME
archive_file ${DIR}/$INPUT_FILENAME
