#!/usr/bin/env bash

OPTIONS="zsh tmux kitty scripts nvim all"

CONFIG_PATH="$HOME/.config"
LOCAL_PATH="$HOME/.local"

DEPENDENCIES=()

green() { echo -e "\033[32m$*\033[0m"; }
red() { echo -e "\033[31m$*\033[0m"; }
yellow() { echo -e "\033[33m$*\033[0m"; }

# Function to print the help screen
print_help() {
    echo "Usage: $0 <option> [option...]"
    echo
    echo "Valid options:"
    for option in $OPTIONS; do
        echo "  - $option"
    done
    exit 1
}

# Helper function to add unique dependencies
add_dependency() {
    local dep="$1"
    for existing in "${DEPENDENCIES[@]}"; do
        if [[ "$existing" == "$dep" ]]; then
            return  # Dependency already exists, do nothing
        fi
    done
    DEPENDENCIES+=("$dep")  # Add the dependency
}

# Function to handle backups
backup_file() {
    local file="$1"
    local backup="$file.bak"
    if [ -e "$file" ]; then
        echo "Backing up $file to $backup"
        mv $file $backup
    else
        echo "No existing $file to back up."
    fi
}

# Function to handle each option
handle_option() {
    case "$1" in
        zsh)
            green "Configuring zsh..."
            backup_file $HOME/.zshrc
            backup_file $HOME/.zsh_profile

            cp -r ./zsh/ $HOME

            rm -rf $HOME/.zshrc.bak
            rm -rf $HOME/.zsh_profile.bak

            add_dependency "zsh"
            chsh -s $(which zsh) || red "ERROR: zsh needs to be installed, install zsh and then run 'chsh -s \$\(which zsh\)'"
            ;;
        tmux)
            green "Setting up tmux..."
            backup_file $HOME/.tmux.conf

            cp -r ./tmux/ $HOME

            rm -rf $HOME/.tmux.conf.bak

            echo
            yellow "Note: You may need to install TPM by running command below:"
            echo "git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm"

            add_dependency "tmux"
            ;;
        kitty)
            green "Configuring kitty terminal..."
            backup_file $CONFIG_PATH/kitty

            cp -r ./config/kitty $CONFIG_PATH

            rm -rf $CONFIG_PATH/kitty.bak

            echo
            yellow "Note: You need to be using Kitty terminal emulator"
            ;;
        scripts)
            green "Running scripts setup..."
            backup_file $LOCAL_PATH/scripts

            cp -r ./bin/.local/scripts $LOCAL_PATH/scripts

            rm -rf $LOCAL_PATH/scripts.bak

            add_dependency "tmux"
            add_dependency "fzf"
            ;;
        nvim)
            green "Setting up Neovim..."
            backup_file $CONFIG_PATH/nvim

            cp -r ./config/nvim $CONFIG_PATH

            rm -rf $CONFIG_PATH/nvim.bak

            echo
            yellow "Note: Uses Lazy for plugin manager"

            add_dependency "neovim or nvim"
            add_dependency "rg"
            add_dependency "deno (If you want to use Peek)"
            ;;
        all)
            echo "Running full setup for all options..."
            echo
            handle_option zsh
            echo
            handle_option tmux
            echo
            handle_option kitty
            echo
            handle_option scripts
            echo
            handle_option nvim
            ;;
        *)
            red "ERROR: Invalid option '$1'."
            print_help
            ;;
    esac
}

# Ensure at least one argument is provided
if [ "$#" -lt 1 ]; then
    red "ERROR: At least one argument is required."
    print_help
fi

# Check if "all" is in the arguments
if [[ " $* " == *" all "* ]]; then
    handle_option all

    echo
    green "Fully Configured Everything!"
    echo
    echo "Dependencies (install using package manager):"
    printf " - %s\n" "${DEPENDENCIES[@]}"
    echo
    yellow "Note: You may need to restart your terminal for changes to take effect"

    exit 0
fi

# Loop through all provided arguments and process them
for arg in "$@"; do
    handle_option "$arg"
    echo
done

echo
green "Fully Configured $@"
echo
echo "Dependencies (install using package manager):"
printf " - %s\n" "${DEPENDENCIES[@]}"
echo
yellow "Note: You may need to restart your terminal for changes to take effect"
