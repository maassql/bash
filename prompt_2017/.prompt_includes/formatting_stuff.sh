format_last_command_result(){
    local command_result_to_format=$1
    if [ $command_result_to_format -eq 0 ]; 
        then
            if [ $PROMPT_SWITCH_RETURN_CODE_WHEN_GOOD_SHOW_ON -eq 1 ];
                then
                    local lst_cmmd_format="$(tput setab 0)$(tput setaf 2)[${command_result_to_format}]$(tput sgr0;)"
            fi
        else
            local lst_cmmd_format="$(tput setab 3)❗❗ $(tput blink)$(tput setab 1)$(tput setaf 7)  ☠  [${command_result_to_format}] ☠   $(tput sgr0;)$(tput setab 3)❗❗ $(tput sgr0;)"
    fi
    echo "${lst_cmmd_format}"
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









make_line_data(){
    local data="${1}"
    local line_length="${2}"
    local line_length=`expr $line_length - 2`
    # http://www.copypastecharacter.com/all-characters
    local box_top_char="⎺"
    local box_bottom_char="⎽"
    local eol_char="⎹"

    local box_top_char="▔"
    local box_bottom_char="▁"
    local bol_char="▌"
    local eol_char="▐"

    echo "${bol_char}${data}"
}

make_line_top(){
    local line_length="${1}"

    local line_length=`expr $line_length - 2`

    # http://www.copypastecharacter.com/all-characters
    local box_top_char="⎺"
    local box_bottom_char="⎽"
    local eol_char="⎹"

    local box_top_char="▔"
    local box_bottom_char="▁"
    local bol_char="▌"
    local eol_char="▐"

    echo "${bol_char}$( left_justify_padded "" "${line_length}" "${box_top_char}" )${eol_char}"
}

make_line_bottom(){
    local line_length="${1}"
    local line_length=`expr $line_length - 2`
    # http://www.copypastecharacter.com/all-characters
    local box_top_char="⎺"
    local box_bottom_char="⎽"
    local eol_char="⎹"

    local box_top_char="▔"
    local box_bottom_char="▁"
    local bol_char="▌"
    local eol_char="▐"

    echo "${bol_char}$( left_justify_padded "" "${line_length}" "${box_bottom_char}" )${eol_char}"
}