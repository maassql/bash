#!/bin/bash

function set_prompt_directory(){
	cd
	local PROMPT_HOME=$(pwd)/.jeff_maass_prompt/
	mkdir -p "${PROMPT_HOME}"
	cd "${PROMPT_HOME}"
	echo "${PROMPT_HOME}"
}

function get_from_repository(){
	local to="${HOME_OF_PROMPT_SCRIPTS}/${1}"
	
	if [ -f "${to}" ] then;
		rm "${to}"
	fi

	wget ${WGET_OPTS} "${1}"
	
	source "${to}"
}

WGET_OPTS="--output-file=\"${WGET_LOG}\" --tries=2 --no-verbose --base=\"${REPO}\" --show-progress --dns-timeout=2 --read-timeout=2 --connect-timeout=4 --prefer-family=IPv4 --no-dns-cache --retry-connrefused "
REPO="https://raw.githubusercontent.com/maassql/bash/master/prompt/"
HOME_OF_PROMPT_SCRIPTS=set_prompt_directory
WGET_LOG="${HOME_OF_PROMPT_SCRIPTS}/wget-log.log"

get_from_repository 'jmaass_prompt.sh'

bash "${HOME_OF_PROMPT_SCRIPTS}/${1}"