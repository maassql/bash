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

get_from_repository "func_get_color_combinations.sh"
get_from_repository "func_get_datetime_iso_8601.sh"
get_from_repository "func_get_prompt_text.sh"
get_from_repository "func_left_justify_padded.sh"
get_from_repository "func_parse_git_dirty.sh"
get_from_repository "func_set_prompt.sh"

set_prompt