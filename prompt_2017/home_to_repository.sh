repo_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "repository_directory=[${repo_dir}]"

# https://ss64.com/bash/rsync.html

what_to_copy="--exclude-from=${repo_dir}/rsync_exclude_patterns.txt --recursive"
how_to_copy="--links --times"
destination_options="--delete --force --progress"
rsync  $what_to_copy $how_to_copy $destination_options "$HOME/jmaass_prompt.sh" "${repo_dir}/"
rsync  $what_to_copy $how_to_copy $destination_options "$HOME/.prompt_includes" "${repo_dir}/"