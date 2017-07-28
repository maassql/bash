if [ -d $HOME/bash ];
    then
    cd $HOME/bash
    git pull
else
    cd $HOME
    git clone https://github.com/maassql/bash
fi

bash $HOME/bash/prompt_2017/repo_to_home.sh
source $HOME/jmaass_prompt.sh