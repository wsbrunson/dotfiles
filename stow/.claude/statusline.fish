#!/usr/bin/env fish

# Read JSON input from stdin
set input (cat)

# Extract information from the JSON
set model_name (echo $input | jq -r '.model.display_name')
set current_dir (echo $input | jq -r '.workspace.current_dir')
set project_dir (echo $input | jq -r '.workspace.project_dir')
set output_style (echo $input | jq -r '.output_style.name')
set context_percent (echo $input | jq -r '.context_usage.percentage // 0')

# Get current user and hostname
set username (whoami)
set hostname (hostname -s)

# Get current working directory relative to home
set home_dir $HOME
set display_dir (string replace $home_dir "~" $current_dir)

# Check if we're in a git repository and get branch info
set git_info ""
if test -d "$current_dir/.git"
    set git_branch (git -C $current_dir branch --show-current 2>/dev/null)
    if test -n "$git_branch"
        set git_info " ($git_branch)"
    end
end

# Build the status line with colors (dimmed in terminal)
printf "\033[36m%s@%s\033[0m:\033[34m%s\033[0m\033[32m%s\033[0m | \033[35m%s\033[0m | \033[33m%s%%\033[0m" $username $hostname $display_dir $git_info $model_name $context_percent