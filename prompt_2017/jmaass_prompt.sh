# source prompt 
# source $HOME/jmaass_prompt.sh
#
# save changes to prompt
# save_prompt_changes

# run this function at any prompt.  
# Changes to this file will be saved to the local repository
# you will still have to manually push the changes to the remote
commit_prompt_changes_to_local_repository(){
    bash "$HOME/Documents/repos/bash/prompt_2017/home_to_repository.sh"
    echo "You still gotta push these changes to the remote"
}

source "${HOME}/.prompt_includes/command_timer.sh"
source "${HOME}/.prompt_includes/load_stuff.sh"
source "${HOME}/.prompt_includes/aws_stuff.sh"
source "${HOME}/.prompt_includes/git_stuff.sh"
source "${HOME}/.prompt_includes/directory_stuff.sh"
source "${HOME}/.prompt_includes/env_switches_stuff.sh"
source "${HOME}/.prompt_includes/formatting_stuff.sh"
source "${HOME}/.prompt_includes/last_command.sh"




















get_prompt_text(){
    local last_command_result=$?
    local save_timer="${TIMER_SHOW}"
 
    # ---------------------------------------------------------------------
    # ------ COLORS -------------------------------------------------------
    # local background
    local PB="$(tput setab 235)"
    # alternating text colors
    local C1="$(tput setaf 3)"
    local C2="$(tput setaf 5)"
    # border text color
    local CB="$(tput setaf 2)"
    # resets
    local RESET_TERMINAL="$(tput sgr0;)$(tput cnorm;)"
    local RESET_PROMPT="${RESET_TERMINAL}${PB}${CB}"

    # ---------------------------------------------------------------------
    # ------ PROMPT POINTER -----------------------------------------------
    local C_POINTER_ROOT="$(tput setaf 1;)$(tput setab 7;)$(tput blink;)"
    local C_POINTER="${RESET_PROMPT}"
    if [ ${UID} -eq 0 ]; then
        C_POINTER="${C_POINTER_ROOT}"
    fi

    # ---------------------------------------------------------------------
    # ------ GIT -----------------------------------------------
    if [ "${PROMPT_SWITCH_GIT_ON}" -eq "1" ];
        then
            local git_branch="$(parse_git_branch)"
            if [ "${git_branch}" ]; then
                local git_status="$(parse_git_status)"
                local git_prompt_line="
${RESET_PROMPT}$( make_line_data "${C1}${git_branch}${C2}${git_status}" ${COLUMNS} )"
            else
                local git_prompt_line="${C1} <not git repo>"
            fi
        else
            local git_prompt_line=''
    fi


    # ---------------------------------------------------------------------
    # ------ Simples ------------------------------------------------------
    local command_prompt_pid=$$
    local os_name=`uname`
    local dttm="$(date +%Y-%m-%d.%H:%M:%S)"
    local full_path="$(pwd)"
    local aws_prompt_line="$(get_aws_prompt_line)"
    local last_command_result="$(format_last_command_result ${last_command_result})"
    local _user="$(id -u -n)"

    # ---------------------------------------------------------------------
    # ------ Combine ------------------------------------------------------
    local this_prompt_instance="
${last_command_result} ran in ${save_timer} ${RESET_PROMPT}$(tput setab 239)
${RESET_PROMPT}$( make_line_top                                                                                                             ${COLUMNS} )
${RESET_PROMPT}$( make_line_data "${C1}${dttm} ${C2}${_user}${CB}@${C1}$(hostname)${CB}:${C2}${command_prompt_pid}${CB}:${C1}${os_name}"    ${COLUMNS} )${aws_prompt_line}
${RESET_PROMPT}$( make_line_data "${C2}'${full_path}'"                                                                                        ${COLUMNS} )${git_prompt_line}
${C_POINTER}$ --->${RESET_TERMINAL}
"


    echo "${this_prompt_instance}"
}

set_prompt(){
    export PS1="\`get_prompt_text\`"
    # export PS1="\u@\h:\w "
}

    







PROMPT_SWITCH_GIT_ON=1
PROMPT_SWITCH_RETURN_CODE_WHEN_GOOD_SHOW_ON=1


if [ "$PROMPT_SWITCH_ENV_SWITCHES_STUFF_SOURCED" == "1" ];
    then
        turn_on_history_timestamps
        turn_on_color_prompt
        turn_on_color_ls
fi
set_prompt






















