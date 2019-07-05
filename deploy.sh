
# ----------------------------------------------------------------------
# ------ Get latest code from remote repository ------------------------
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
# ------ Get latest code from remote repository ------------------------
# ----------------------------------------------------------------------


# ----------------------------------------------------------------------
# ---- Install prompt to your home directory ---------------------------
bash "${repo_dir}"/prompt_2017/repo_to_home.sh
# ---- Install prompt to your home directory ---------------------------
# ----------------------------------------------------------------------


# ----------------------------------------------------------------------
# ----- show the user their prompt has changed -------------------------
echo "BEGIN - Sourcing prompt scripts."
source $HOME/jmaass_prompt.sh
echo "DONE YOU SEXY SEXY MAN - Sourcing prompt scripts."
# ----- show the user their prompt has changed -------------------------
# ----------------------------------------------------------------------
