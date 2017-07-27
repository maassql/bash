deploy_prompt(){
    scp $HOME/jmaass_prompt.sh ubuntu@34.228.223.194:~
    ssh ubuntu@34.228.223.194
}