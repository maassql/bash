if [ -f "install_prompt2.sh" ] then rm "install_prompt2.sh" fi
wget --quiet "https://raw.githubusercontent.com/maassql/bash/master/prompt/install_prompt2.sh"
bash "install_prompt2.sh"
rm "install_prompt2.sh"
source "${HOME}/.jeff_maass_prompt/jmaass_prompt.sh"