repo_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "BEGIN - Deploying scripts from repo directory, [${repo_dir}]."

# https://ss64.com/bash/rsync.html

what_to_copy="--exclude-from=${repo_dir}/rsync_exclude_patterns.txt --recursive"
how_to_copy="--links --times"
destination_options="--progress"
rsync  $what_to_copy $how_to_copy $destination_options "${repo_dir}/" "$HOME/" 

echo "DONE - Deploying scripts from repo directory, [${repo_dir}]."