function get_prompt_text(){
    local hostname="$(hostname)"


    if [[ "${hostname}" == *"dev-"* ]] || [[ "${hostname}" == *"deploy"* ]];then
        local git_prompt="[$(parse_git_branch)]"
    fi

    local command_prompt_pid=$$



    local dttm="$(date +%Y-%m-%d.%H:%M:%S)"
    local full_path="$(pwd)"
    local username_at_hostname="[${USER}@${hostname}:${command_prompt_pid}]"

    local size_of_dttm=${#dttm}
    local size_of_full_path=${#full_path}
    local size_of_username_at_hostname=${#username_at_hostname}
    local size_of_git_prompt=${#git_prompt}


    local longest=0
    if [ $longest -lt $size_of_dttm ]; then
        #echo "longest is less than size of dttm"
        local longest=$size_of_dttm
    fi
    if [ $longest -lt $size_of_full_path ]; then
        #echo "longest is less than size of full path"
        local longest=$size_of_full_path
    fi
    if [ $longest -lt $size_of_username_at_hostname ]; then
        #echo "longest is less than size of username at hostname"
        local longest=$size_of_username_at_hostname
    fi
    if [ $longest -lt $size_of_git_prompt ]; then
        #echo "longest is less than size of username at hostname"
        local longest=$size_of_git_prompt
    fi

    local diag="

    local size_of_dttm                  =${size_of_dttm}
    local size_of_full_path             =${size_of_full_path}
    local size_of_username_at_hostname  =${size_of_username_at_hostname}
    size_of_git_prompt                  =${size_of_git_prompt}
    =====================================================================
    longest                             =${longest}
    "
    #echo "${diag}"


    if [ "${git_prompt}" ]; then
        local git_prompt="
$(left_justify_padded "${git_prompt}" ${longest})|"
    fi
    # http://www.copypastecharacter.com/all-characters
    local box_top_char="⎺"
    local box_bottom_char="⎽"
    local eol_char="⎹"

    local box_top_char="▔"
    local box_bottom_char="▁"
    local bol_char="▌"
    local eol_char="▐"

    local this_prompt_instance="
${bol_char}$( left_justify_padded "" ${longest} ${box_top_char} )${eol_char}
${bol_char}$( left_justify_padded "${dttm}" ${longest} )${eol_char}
${bol_char}$( left_justify_padded "${full_path}" ${longest} )${eol_char}${git_prompt}
${bol_char}$( left_justify_padded "${username_at_hostname}" ${longest} )${eol_char}
${bol_char}$( left_justify_padded "" ${longest} ${box_bottom_char} )${eol_char}"
    local point=' $ ---> '
    local this_prompt_instance="${this_prompt_instance}${point}"
    
    echo "${this_prompt_instance}"
}