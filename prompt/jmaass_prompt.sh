# https://www.kirsle.net/wizards/ps1.html
# http://www.copypastecharacter.com/all-characters
# http://www.cyberciti.biz/faq/linux-unix-formatting-dates-for-display/
# http://ezprompt.net/
# https://en.wikipedia.org/wiki/ANSI_escape_code#Colors
# http://unix.stackexchange.com/questions/124407/what-color-codes-can-i-use-in-my-ps1-prompt
# PS1="\[\033[01;32m\]MyPrompt: \[\033[0m\]"


# get current branch in git repo
function parse_git_branch() {
    BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
    if [ ! "${BRANCH}" == "" ]
    then
        STAT=`parse_git_dirty`
        echo "[${BRANCH}${STAT}]"
    else
        echo ""
    fi
}

# get current status of git repo
function parse_git_dirty {
    status=`git status 2>&1 | tee`
    dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
    untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
    ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
    newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
    renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
    deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
    bits=''
    if [ "${renamed}" == "0" ]; then
        bits=">${bits}"
    fi
    if [ "${ahead}" == "0" ]; then
        bits="*${bits}"
    fi
    if [ "${newfile}" == "0" ]; then
        bits="+${bits}"
    fi
    if [ "${untracked}" == "0" ]; then
        bits="?${bits}"
    fi
    if [ "${deleted}" == "0" ]; then
        bits="x${bits}"
    fi
    if [ "${dirty}" == "0" ]; then
        bits="!${bits}"
    fi
    if [ ! "${bits}" == "" ]; then
        echo " ${bits}"
    else
        echo ""
    fi
}

get_datetime_iso_8601(){
    # http://www.cyberciti.biz/faq/linux-unix-formatting-dates-for-display/
    date +%Y-%m-%dT%H:%M:%S%:z
}

left_justify_padded(){
    local string_to_pad="${1}"
    local total_length="${2}"
    local char_to_repeat="${3}"

    if [ -z "${char_to_repeat}" ]; then
        local char_to_repeat='='
    fi

    #echo "total_length=[$total_length]"

    local length_of_string_to_pad=${#string_to_pad}
    #echo "length_of_string_to_pad=[$length_of_string_to_pad]"


    local pad_right_length=$(( $total_length - $length_of_string_to_pad ))
    #echo "pad_right_length=[$pad_right_length]"

    if [ $pad_right_length -gt 0 ]; then
        local pad_cmd="printf '${char_to_repeat}%.0s' {1.."${pad_right_length}"}"
        local right_padding=$(eval $pad_cmd)
        #echo "right_padding=[$right_padding]"
    fi

    echo "${string_to_pad}${right_padding}"
}

get_color_combinations(){
color=16;

while [ $color -lt 245 ]; do
    echo -e "$color: \\033[38;5;${color}mhello\\033[48;5;${color}mworld\\033[0m"
    ((color++));
done 


}


get_prompt_text(){
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

# preexec () { :; }
# preexec_invoke_exec () {
#     [ -n "$COMP_LINE" ] && return  # do nothing if completing
#     [ "$BASH_COMMAND" = "$PROMPT_COMMAND" ] && return # don't cause a preexec for $PROMPT_COMMAND
#     local this_command=`HISTTIMEFORMAT= history 1 | sed -e "s/^[ ]*[0-9]*[ ]*//"`;
#     preexec "$this_command"
# }
# trap 'preexec_invoke_exec' DEBUG

#
# get_prompt_text(){
#    echo "
#=====================================
#2015-10-02.15:38:50==================
#/home/jmaass=========================
#[jmaass@devops-ple-s01-bnat4stack-01]
#=====================================
#\$ --->"
# }
#

set_prompt(){

    echo "Setting Prompt from file=[${BASH_SOURCE[0]}]"

    local cont_seq_init="\033["
    local cont_seq_term="0m"
    local color_reset="\[${cont_seq_init}00${cont_seq_term}\]"
    local bold_black_on_orange="\[${cont_seq_init}01;43${cont_seq_term}\]"

    export PS1="${bold_black_on_orange}\`get_prompt_text\`${color_reset}"

    echo "DONE Setting Prompt from file=[${BASH_SOURCE[0]}]"
}

set_prompt