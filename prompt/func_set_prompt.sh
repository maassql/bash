#!/bin/bash
function set_prompt(){


    local cont_seq_init="\033["
    local cont_seq_term="0m"
    local color_reset="\[${cont_seq_init}00${cont_seq_term}\]"
    local bold_black_on_orange="\[${cont_seq_init}01;43${cont_seq_term}\]"

    export PS1="${bold_black_on_orange}\`get_prompt_text\`${color_reset}"

}

set_prompt