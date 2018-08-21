    local C_POINTER_ROOT="$(tput setaf 1;)$(tput setab 7;)$(tput blink;) "
    local C_POINTER="${RESET_PROMPT}"
    if [ ${UID} -eq 0 ]; then
        C_POINTER="${C_POINTER_ROOT}"
    fi