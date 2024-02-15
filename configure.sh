#!/bin/bash

# Check if a command is available
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install Neovim Nightly build
install_neovim_nightly() {
    if ! command_exists nvim; then
        sudo apt-get update
        sudo apt-get install -y software-properties-common
        sudo add-apt-repository ppa:neovim-ppa/unstable
        sudo apt-get update
        sudo apt-get install -y neovim
    else
        echo "Neovim is already installed."
    fi
}

# Install other tools
install_tools() {
    tools=("fpp" "tmux" "lazygit" "cronie")
    for tool in "${tools[@]}"; do
        if ! command_exists "$tool"; then
            sudo apt-get update
            sudo apt-get install -y "$tool"
        else
            echo "$tool is already installed."
        fi
    done
}

# Install tmux plugin manager (tpm)
install_tmux_plugins() {
    tmux_plugins_dir="$HOME/.tmux/plugins/tpm"
    if [ ! -d "$tmux_plugins_dir" ]; then
        git clone https://github.com/tmux-plugins/tpm "$tmux_plugins_dir"
    else
        echo "tmux plugin manager (tpm) is already installed."
    fi
}

# Install tmuxifier
install_tmuxifier() {
    tmuxifier_dir="$HOME/.tmuxifier"
    if [ ! -d "$tmuxifier_dir" ]; then
        git clone https://github.com/jimeh/tmuxifier.git "$tmuxifier_dir"
    else
        echo "tmuxifier is already installed."
    fi
}

# Setup cron job
setup_cron_job() {
    cronjob="@daily $HOME/automation_scripts/update.sh"
    (crontab -l 2>/dev/null; echo "$cronjob") | crontab -
}

# Enable cron in systemd
enable_cron_systemd() {
    sudo systemctl enable cron
    sudo systemctl start cron
}

# Main script
install_neovim_nightly
install_tools
install_tmux_plugins
install_tmuxifier
setup_cron_job
enable_cron_systemd

echo "Setup completed."
