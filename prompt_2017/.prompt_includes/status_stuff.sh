if tput hs ; then
    tput tsl
    echo -n This is the status line
    tput fsl
else
    echo Sorry, there is no status line
fi


tput sc
tput home
echo "hey................"
tput rc

tput sc;to_col=0;to_row=$LINES;tput cup $to_row to_col ; echo "i am on the bottom line";tput rc;



