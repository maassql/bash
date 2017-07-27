# http://jakemccrary.com/blog/2015/05/03/put-the-last-commands-run-time-in-your-bash-prompt/

function f_timer_now {
    local try_4_millis="$(date +%s%N)"
    if [[ "$try_4_millis" == *"N"* ]]; then
        # best we will get is seconds..
        local empty=""
        local try_4_millis=${try_4_millis/N/$empty}
        local try_4_millis=$((try_4_millis * 1000))
    fi
    echo "${try_4_millis}"
}

function f_timer_start {
    TIMER_START=${TIMER_START:-$(f_timer_now)}
}



function f_timer_stop {
    local delta_us=$((($(f_timer_now) - $TIMER_START) / 1000))
    local us=$((delta_us % 1000))
    local ms=$(((delta_us / 1000) % 1000))
    local s=$(((delta_us / 1000000) % 60))
    local m=$(((delta_us / 60000000) % 60))
    local h=$((delta_us / 3600000000))
    # Goal: always show around 3 digits of accuracy
    if ((h > 0));       then TIMER_SHOW=${h}h${m}m
    elif ((m > 0));     then TIMER_SHOW=${m}m${s}s
    elif ((s >= 10));   then TIMER_SHOW=${s}.$((ms / 100))s
    elif ((s > 0));     then TIMER_SHOW=${s}.$(printf %03d $ms)s
    elif ((ms >= 100)); then TIMER_SHOW=${ms}ms
    elif ((ms > 0));    then TIMER_SHOW=${ms}.$((us / 100))ms
    else                     TIMER_SHOW=${us}us
    fi
    unset TIMER_START
}

# invoke f_timer_start after every simple command
trap 'f_timer_start' DEBUG


# timer_stop is called right before the terminal calls $PS1
if [ "$PROMPT_COMMAND"=="" ];
    then
        PROMPT_COMMAND="f_timer_stop"
    else
        PROMPT_COMMAND="f_timer_stop; $PROMPT_COMMAND"
fi









