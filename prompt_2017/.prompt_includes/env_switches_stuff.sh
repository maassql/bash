
turn_on_history_timestamps(){

    local turn_on="
export HISTTIMEFORMAT=\"%d/%m/%y %T \""

    if [ -f ~/.bashrc ]; then
        local exists=$( grep "HISTTIMEFORMAT" ~/.bashrc )
        if [ -z "${exists}" ]; then
            echo "${turn_on}" >> ~/.bashrc
            source ~/.bashrc
        fi
    fi
}


turn_on_color_prompt(){
    local turn_on="
force_color_prompt=yes"

    if [ -f ~/.bashrc ]; then
        local exists=$( grep "force_color_prompt=yes" ~/.bashrc )
        if [ -z "${exists}" ]; then
            echo "${turn_on}" >> ~/.bashrc
            source ~/.bashrc
        fi
    fi
}




turn_on_color_ls(){
    unamestr=`uname`
    if [[ "$unamestr" == 'Darwin' ]]; then
       export CLICOLOR=1
       export LSCOLORS=GxFxCxDxBxegedabagaced
    else 
        alias ls="ls --color=always"
    fi
}