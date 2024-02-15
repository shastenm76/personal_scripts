#!/bin/bash

# List of directories containing dotfiles repositories
dotfile_repos=(
 "~/.config/alacritty"
 "~/.config/clipmenu"
 "~/.config/clipnotify"
 "~/.config/dmenu"
 "~/.config/dwm"
 "~/.config/nvim"
 "~/.config/picom"
 "~/.config/slstatus"
 "~/.config/st"
 "~/.config/zathura"
 "~/.config/zellij"
 "~/local/bin/scripts"
)

# Function to update each dotfiles repository
update_dotfiles() {
    local repo_dir=$1

    # Change to the dotfiles repository directory
    cd "$repo_dir" || exit

    # Check git status
    git_status=$(git status --porcelain)

    # If there are changes, add, commit, and push
    if [ -n "$git_status" ]; then
        git add .
        git commit -am "daily update"
        git push github        # Assuming 'github' is a remote
        git push gitlab        # Assuming 'gitlab' is a remote
    fi
}

# Iterate over each dotfiles repository and update
for repo in "${dotfile_repos[@]}"; do
    update_dotfiles "$repo"
done
