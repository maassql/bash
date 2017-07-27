#!/bin/bash


function load_minute_1 (){
  echo "$(sysctl -n vm.loadavg | awk '{print $2}')"
}

function load_minute_5 (){
  echo "$(sysctl -n vm.loadavg | awk '{print $3}')"
}

function load_minute_15 (){
  echo "$(sysctl -n vm.loadavg | awk '{print $4}')"
}


function load_color() {
  local load_N="${1}"
  local gray=0
  local red=1
  local green=2
  local yellow=3
  local blue=4
  local magenta=5
  local cyan=6
  local white=7

  # Colour progression is important ...
  #   bold gray -> bold green -> bold yellow -> bold red -> 
  #   black on red -> bold white on red
  #
  # Then we have to choose the values at which the colours switch, with
  # anything past yellow being pretty important.

  
  local load100=$(echo "${load_N}*100" | bc)
  echo "---${load100}------"

  if [ ${load100} -lt 70 ]
  then
    tput bold ; tput setaf ${gray}
  elif [ ${load100} -ge 70 ] && [ ${load100} -lt 120 ]
  then
    tput bold ; tput setaf ${green}
  elif [ ${load100} -ge 120 ] && [ ${load100} -lt 200 ]
  then
    tput bold ; tput setaf ${yellow}
  elif [ ${load100} -ge 200 ] && [ ${load100} -lt 300 ]
  then
    tput bold ; tput setaf ${red}
  elif [ ${load100} -ge 300 ] && [ ${load100} -lt 500 ]
  then
    tput setaf ${gray} ; tput setab ${red}
  else
    tput bold ; tput setaf ${white} ; tput setab ${red}
  fi
}

function load_colored_for_prompt {
  local load_now="$(load_minute_1)"
  load_color "${load_now}"
  echo"[${load_now}]"
}