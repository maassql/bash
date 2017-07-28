
repo_dir="$HOME/bash"

if [ -d "${repo_dir}" ];
    then
        echo "Pulling from remote git repository to local directory, [${repo_dir}]."
        cd "${repo_dir}"
        git pull
    else
        echo "Cloning from remote git repository to local directory, [${repo_dir}]."
        cd $HOME
        git clone https://github.com/maassql/bash
fi

echo "Deploying scripts from repository."
bash "${repo_dir}"/prompt_2017/repo_to_home.sh

echo "Sourcing prompt scripts."
source $HOME/jmaass_prompt.sh