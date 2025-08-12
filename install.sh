#!/usr/bin/env bash

OPTIONS="zsh tmux ghostty kitty scripts nvim all all-mac"

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

            cp -r ./zsh/. $HOME

            rm -rf $HOME/.zshrc.bak
            rm -rf $HOME/.zsh_profile.bak

            echo
            yellow "Note: You may need to install oh-my-zsh by running the command below:"
            yellow "sh -c \"\$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\""

            echo
            yellow "Note: You may need to install the oh-my-zsh nord-extended theme as well by running the command below"
            yellow "git clone https://github.com/fxbrit/nord-extended $ZSH/themes/nord-extended"

            echo
            if [[ "$SHELL" == *"zsh"* ]]; then
                echo "Setting Shell to zsh.."
                chsh -s $(which zsh) || (red "ERROR: zsh needs to be installed, install zsh and then run 'chsh -s \$\(which zsh\)'"; exit 1)
            else
                red "Need to install zsh!!"
                add_dependency "zsh"
            fi
            ;;
        tmux)
            green "Setting up tmux..."
            backup_file $HOME/.tmux.conf

            cp -r ./tmux/. $HOME

            rm -rf $HOME/.tmux.conf.bak

            echo
            yellow "Note: You may need to install TPM by running the command below:"
            yellow "git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm"

            echo
            yellow "You also need to remember to press prefix + I on first installation to install plugins"

            add_dependency "tmux"
            ;;
        kitty)
            green "Configuring kitty terminal..."
            backup_file $CONFIG_PATH/kitty

            cp -r ./config/kitty $CONFIG_PATH

            rm -rf $CONFIG_PATH/kitty.bak

            echo
            yellow "Note: You need to be using the Kitty terminal emulator which can be installed using the command below:"
            yellow "curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin"

            add_dependency "kitty"
            ;;
        ghostty)
            green "Configuring ghostty terminal..."
            backup_file $CONFIG_PATH/ghostty

            cp -r ./config/ghostty $CONFIG_PATH

            rm -rf $CONFIG_PATH/ghostty.bak

            echo
            yellow "Note: You need to be using the Ghostty terminal emulator which can be installed using your package manager."

            add_dependency "ghostty"
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

            add_dependency "neovim or nvim"
            add_dependency "rg"
            add_dependency "deno (If you want to use Peek)"
            ;;
        i3)
            green "Setting up i3 with polybar..."
            backup_file $CONFIG_PATH/i3
            backup_file $CONFIG_PATH/polybar

            cp -r ./config/i3 $CONFIG_PATH
            cp -r ./config/polybar $CONFIG_PATH

            rm -rf $CONFIG_PATH/i3.bak
            rm -rf $CONFIG_PATH/polybar.bak

            echo
            yellow "Note: You need to restart i3 in order for the polybar to show \"mod4+Shift+R\""

            add_dependency "i3"
            add_dependency "polybar"
            ;;
        all)
            echo "Running full setup for all options..."
            echo
            handle_option zsh
            echo
            handle_option tmux
            echo
            handle_option ghostty
            echo
            handle_option scripts
            echo
            handle_option nvim
            echo
            handle_option i3
            ;;
        all-mac)
            echo "Running full setup for all options besides i3 since macs don't support it..."
            echo
            handle_option zsh
            echo
            handle_option tmux
            echo
            handle_option ghostty
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

# Prints dependencies for installed configurations and tools
print_dependencies() {
    green "Fully Configured Everything!"
    echo
    echo "Dependencies (install using package manager):"
    printf " - %s\n" "${DEPENDENCIES[@]}"
    echo
    yellow "Note: You may need to restart your terminal for changes to take effect"
}

# Ensure at least one argument is provided
if [ "$#" -lt 1 ]; then
    red "ERROR: At least one argument is required."
    print_help
fi

# Check if "all" is in the arguments
if [[ " $* " == *" all-mac "* ]]; then
    handle_option all-mac

    echo
    print_dependencies

    exit 0
fi

# Check if "all" is in the arguments
if [[ " $* " == *" all "* ]]; then
    handle_option all

    echo
    print_dependencies

    exit 0
fi

# Loop through all provided arguments and process them
for arg in "$@"; do
    handle_option "$arg"
    echo
done

print_dependencies
