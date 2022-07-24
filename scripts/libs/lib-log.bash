#!/usr/bin/env bash
set -e
set -o pipefail
[[ "${KREDUL_DEBUG}" = "true" ]] && set -x || set +x

dateTime=$(date +"%Y-%m-%d %H:%M:%S")

log_info () {
	echo -e "[${dateTime}] [INFO] - $1"
}

log_debug () {
  DebugModeActivated="${DEBUG_MODE_ACTIVATED:-false}"
  if [[ "${DebugModeActivated}" == "true" ]]
  then
	  echo -e "[${dateTime}] [DEBUG] - $1"
  fi
}

log_error () {
	echo -e "[${dateTime}] [ERROR] - $1"
}

log_start_script () {

	titleWeight=180
  entryText=${1:0:${titleWeight} - 4}

  write_inline () {
    for i in `seq 1 $1`; do echo -n "$2"; done
  }

	[[ $((${#entryText} % 2)) -eq 0 ]] && LAST=-1 || LAST=-2
	enptySpaceWeight=$(expr ${titleWeight} - 2)
	spaceBefore=$(expr ${titleWeight} / 2 - ${#entryText} / 2 - 1)
	spaceAfter=$(expr ${titleWeight} / 2 - ${#entryText} / 2 + ${LAST})

	write_inline $titleWeight "#" && echo
	echo -n "#" && write_inline ${enptySpaceWeight} " " && echo "#"
	echo -n "#" && write_inline ${spaceBefore} " " && echo -n "${entryText}" && write_inline ${spaceAfter} " " && echo "#"
	echo -n "#" && write_inline ${enptySpaceWeight} " " && echo "#"
	write_inline $titleWeight "#" && echo
}

log_end_script () {

	titleWeight=120
  entryText=${1:0:${titleWeight} - 4}

  write_inline () {
    for i in `seq 1 $1`; do echo -n "$2"; done
  }

  [[ $((${#entryText} % 2)) -eq 0 ]] && LAST=-1 || LAST=-2
  enptySpaceWeight=$(expr ${titleWeight} - 2)
  spaceBefore=$(expr ${titleWeight} / 2 - ${#entryText} / 2 - 1)
  spaceAfter=$(expr ${titleWeight} / 2 - ${#entryText} / 2 + ${LAST})

  write_inline $titleWeight "#" && echo
  echo -n "#" && write_inline ${spaceBefore} " " && echo -n "${entryText}" && write_inline ${spaceAfter} " " && echo "#"
  write_inline $titleWeight "#" && echo

}

SECTION=1

log_write_section () {


  function write_inline {
    for i in `seq 1 $1`; do echo -n "$2"; done
  }

	titleWeight=60
  echo " "
	echo -n "$SECTION - $1" && echo
	write_inline $titleWeight "-" && echo
	SECTION=$(("$SECTION"+1))
}
