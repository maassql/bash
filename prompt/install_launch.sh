# paste this into your command line
# ---or---
# put it into an iterm2.trigger.Parameter field :
#		Regular Expression		=Last login:
#       Action               	=Send Text
#       Parameters              ={the code below}
if [ -f "install_prompt2.sh" ] 
then
	rm "install_prompt2.sh"
fi
wget "https://raw.githubusercontent.com/maassql/bash/master/prompt/install_prompt2.sh"
bash "install_prompt2.sh"
rm "install_prompt2.sh"