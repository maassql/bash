

# is slow when LOTS of files
get_current_dir_cnt_of_all_files(){
    echo "$(ls -l -A -1 | wc -l | tr -d '[:space:]')"
}

# is slow when LOTS of files
get_current_dir_cnt_of_visible_files(){
    echo "$(ls -1 | wc -l | tr -d '[:space:]')"
}

# can be very slow
get_current_dir_cnt_of_open_files(){
    echo "$(lsof +d $(pwd)/* | wc -l | tr -d '[:space:]')"
}

# can be very slow
get_current_dir_cnt_of_open_files(){
    echo "$(lsof +d $(pwd) | wc -l | tr -d '[:space:]')"
}

# this is very, very slow....
get_space_taken_by_current_directory(){
    echo "$(du -d=1 -h | tr -d '[:space:]')"
}