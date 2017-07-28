source "${HOME}/.prompt_includes/command_timer.sh"
source "${HOME}/.prompt_includes/load_stuff.sh"
source "${HOME}/.prompt_includes/aws_stuff.sh"
source "${HOME}/.prompt_includes/git_stuff.sh"
source "${HOME}/.prompt_includes/directory_stuff.sh"
source "${HOME}/.prompt_includes/env_switches_stuff.sh"
source "${HOME}/.prompt_includes/formatting_stuff.sh"

# not sure this works in ubuntu
jobscount() {
  local stopped=$(jobs -sp | wc -l)
  local running=$(jobs -rp | wc -l)
  ((running+stopped)) && echo -n "${running}r/${stopped}s "
}


get_command_entered(){
    local cmd=$(history 2 | head --lines=1)
    echo "you typed=${cmd}"
}













get_prompt_text(){
    local last_command_result=$?
    local save_timer="${TIMER_SHOW}"
    local last_command_result="$(format_last_command_result ${last_command_result})"



 





    # local background
    local PB="$(tput setab 235)"
    # alternating text colors
    local C1="$(tput setaf 3)"
    local C2="$(tput setaf 5)"
    # border text color
    local CB="$(tput setaf 2)"
    
    local RESET_TERMINAL="$(tput sgr0;)$(tput cnorm;)"
    local RESET_PROMPT="${RESET_TERMINAL}${PB}${CB}"

    local C_POINTER_ROOT="$(tput setaf 1;)$(tput setab 7;)$(tput blink;)"
    local C_POINTER="${RESET_PROMPT}"
    if [ ${UID} -eq 0 ]; then
        C_POINTER="${C_POINTER_ROOT}"
    fi
    local command_prompt_pid=$$
    local os_name=`uname`
    local dttm="$(date +%Y-%m-%d.%H:%M:%S)"
    local full_path="$(pwd)"


    if [ "${PROMPT_SWITCH_GIT_ON}" == "1" ];
        then
            local git_prompt="[$(parse_git_branch)]"
            if [ "${git_prompt}" ]; then
                local git_prompt_line="
$( make_line_data "${git_prompt}" ${line_length} )"
            else
                local git_prompt_line=""
            fi
    fi

    if [ "$PROMPT_SWITCH_AWS_STUFF_SOURCED" == "1" ];
        then
            local aws_prompt_line="$(get_aws_prompt_line)"
    fi

    local this_prompt_instance="
${last_command_result} ran in ${save_timer} ${RESET_PROMPT}$(tput setab 239)
${RESET_PROMPT}$( make_line_top                                                                                                             ${COLUMNS} )
${RESET_PROMPT}$( make_line_data "${C1}${dttm} ${C2}${USER}${CB}@${C1}$(hostname)${CB}:${C2}${command_prompt_pid}${CB}:${C1}${os_name}"    ${COLUMNS} )${aws_prompt_line}
${RESET_PROMPT}$( make_line_data "${C2}${full_path}"                                                                                        ${COLUMNS} )${git_prompt_line}
${C_POINTER}$ --->${RESET_TERMINAL}
"
    local this_prompt_instance="${this_prompt_instance}"
    
    echo "${this_prompt_instance}"
}

set_prompt(){
    export PS1="\`get_prompt_text\`"
}





PROMPT_SWITCH_GIT_ON=0
PROMPT_SWITCH_RETURN_CODE_WHEN_GOOD_SHOW_ON=1

if [ "$PROMPT_SWITCH_ENV_SWITCHES_STUFF_SOURCED" == "1" ];
    then
        turn_on_history_timestamps
        turn_on_color_prompt
        turn_on_color_ls
fi
set_prompt






















