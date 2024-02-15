#!/bin/bash

# Dotfiles repository URLs
dotfiles_repos=(
    # Add more repositories as needed
)

# Apps repository URLs
apps_repos=(
    # Add more repositories as needed
)

# Function to clone dotfiles repository
clone_dotfiles() {
    local repo_url=$1

    # Extract repository name from URL
    repo_name=$(basename "$repo_url" .git)

    # Clone the repository
    git clone "$repo_url" "$repo_name"

    # Move dotfiles to the appropriate location (e.g., ~/.config)
    rsync -av "$repo_name/" ~/.config/

    echo "Dotfiles from $repo_url installed."
}

# Function to clone apps repository
clone_apps() {
    local repo_url=$1

    # Extract repository name from URL
    repo_name=$(basename "$repo_url" .git)

    # Clone the repository
    git clone "$repo_url" "$repo_name"

    # Move app files to the appropriate location (e.g., ~/.local)
    rsync -av "$repo_name/" ~/.local/bin/

    echo "App from $repo_url installed."
}

# Clone dotfiles repositories
for dotfiles_repo in "${dotfiles_repos[@]}"; do
    clone_dotfiles "$dotfiles_repo"
done

# Clone apps repositories
for apps_repo in "${apps_repos[@]}"; do
    clone_apps "$apps_repo"
done
 
