#!/bin/bash

function set_prompt_directory(){
        cd
        local PROMPT_HOME=$(pwd)/.jeff_maass_prompt
        mkdir -p "${PROMPT_HOME}"
        echo "${PROMPT_HOME}"
}

function get_from_repository(){
        local to="${HOME_OF_PROMPT_SCRIPTS}/${1}"
        echo "get_from_repository=[${1}]"
        echo "to=[${to}]"
        
        cd "${HOME_OF_PROMPT_SCRIPTS}"
        
        if [ -f "${to}" ] 
       	then
       		echo "removing old copy of to=[${to}]."
            rm "${to}"
        fi

        echo "pulling down [${1}]"
        wget ${WGET_OPTS} "https://raw.githubusercontent.com/maassql/bash/master/prompt/${1}"

        echo "sourcing to=[${1}]"
        source "${1}"
}



HOME_OF_PROMPT_SCRIPTS=$(set_prompt_directory)
WGET_LOG="${HOME_OF_PROMPT_SCRIPTS}/wget-log.log"
WGET_OPTS="--tries=2 --no-verbose --show-progress --dns-timeout=2 --read-timeout=2 --connect-timeout=4 --prefer-family=IPv4 --no-dns-cache --retry-connrefused "


get_from_repository 'jmaass_prompt.sh'

source "${HOME_OF_PROMPT_SCRIPTS}/jmaass_prompt.sh"