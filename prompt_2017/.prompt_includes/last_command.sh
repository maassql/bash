


failed_command_ssh(){
    local cmd="${1}"
    local regex="^ssh "
    if [[ $cmd =~ $regex ]]
        then
            echo "YES starts with ssh"
        else
            echo "NO starts with ssh"
    fi
}




get_prompt_notifications_about_last_command(){
    local history_record="[$(history 2 | tail -n 1)]"
    
    local regex_history_entry_with_datetime="^\[[[:space:]]*[0-9]*  [0-9][0-9]\/[0-9][0-9]\/[0-9][0-9] [0-9][0-9]:[0-9][0-9]:[0-9][0-9] (.*)\]$"
    # cmd_test_regex_history_entry_with_datetime="  537  28/07/17 10:03:33 source $HOME/jmaass_prompt.sh"
    local regex_history_entry_plain="^\[[[:space:]]*[0-9]*  [0-9][0-9]\/[0-9][0-9]\/[0-9][0-9] [0-9][0-9]:[0-9][0-9]:[0-9][0-9] (.*)\]$"
    # cmd_test_regex_history_entry_with_datetime="   41  wget https://raw.githubusercontent.com/maassql/bash/master/deploy.sh"


    if [[ $history_record =~ $regex_history_entry_with_datetime ]]
        then
            local cmd_parsed_from_record="${BASH_REMATCH[1]}"
        else 
            if [[ $history_record =~ $regex_history_entry_plain ]]
                then
                    local cmd_parsed_from_record="${BASH_REMATCH[1]}"
            fi
    fi

    # echo $(failed_command_ssh "${cmd_parsed_from_record}")
}


















