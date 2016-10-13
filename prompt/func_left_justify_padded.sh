function left_justify_padded(){
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