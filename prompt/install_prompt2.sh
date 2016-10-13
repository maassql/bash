#!/bin/bash

function set_prompt_directory(){
	cd
	local PROMPT_HOME=$(pwd)/.jeff_maass_prompt/
	mkdir -p "${PROMPT_HOME}"
	cd "${PROMPT_HOME}"
	echo "${PROMPT_HOME}"
}

function get_from_repository(){
	wget "https://raw.githubusercontent.com/maassql/bash/master/prompt/${1}"
	source "${HOME_OF_PROMPT_SCRIPTS}/${1}"
}

HOME_OF_PROMPT_SCRIPTS=set_prompt_directory

get_from_repository 'jmaass_prompt.sh'

bash "${HOME_OF_PROMPT_SCRIPTS}/${1}"