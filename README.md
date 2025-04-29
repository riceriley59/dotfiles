# dotfiles
My dotfiles for different tools I use including Neovim, Tmux, Zsh, and Kitty and also includes custom local scripts that go in `$HOME/.local/scripts` which is added to the path by the `.zshrc`. There is also an install script for easily installation of the tools and their configs including commands and a list of dependencies to install everything that is needed. This is meant to streamline the installation of these configs and increase productivity.

# install script
The install script sets up all the required configurations for the tools listed below. To use the script, simply clone this repository and run the `install.sh` script.

To automatically setup and install the dotfiles you can run the following commands in your shell:

```
git clone https://github.com/riceriley59/dotfiles.git
cd dotfiles
chmod +x install.sh
./install.sh all
```

**Note:** You can choose which dotfiles to install by passing the name of the tool in lowercase to the script (e.g `tmux`, `scripts`, or `nvim`) or pass `all` to install all of the dotfiles as seen above. All of the supported options are listed below. There is a also an `all-mac` option which installs everything except for i3 and polybar since macs don't support them.

# tmux
My Tmux configuration includes custom key bindings, status bar settings, and various plugins to improve the terminal workflow. It is designed to increase productivity and provide a comfortable, efficient terminal environment.

### dependencies
* tmux
* tpm (tmux plugin manager): `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`

# neovim
My Neovim setup is optimized for efficient editing, with plugins like Lazy for plugin management, enhanced key mappings, and a powerful set of configurations to boost productivity.

### dependencies
* neovim or nvim
* ripgrep (rg)

# zsh
My `zsh` configuration provides a smooth terminal experience, including syntax highlighting, auto-suggestions, and efficient prompts. It improves navigation and command execution within the terminal.

### dependencies
* zsh
* oh-my-zsh: `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`

# kitty
My `Kitty` terminal configuration includes settings that enhance the visual experience, such as themes, font styles, and behavior customizations.

### dependencies
* kitty: `curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin`

# ghostty
My `Ghostty` terminal configuration includes settings that enhance the visual experience, such as themes, font styles, and behavior customizations. There is also a kitty configuration in here although I'm currently using this.

### dependencies
* ghostty

# scripts

### tmux-sessionizer
This script can be run with a name as a command which will then create a tmux session with name and attach to it. Or you can run the script with no commands in which it will bring up a fuzzyfinder with all the directories that you have put in to choose from. Then once you choose a directory it will open that directory in a new tmux session thats named after the directory.

#### dependencies
* fzf

# i3
This sets up the i3 configuration if your on linux and will also install Polybar. This is a minimal, light, and poweful window manager and my personal favorite to use on any linux distro. This configuration is for i3-gaps which is a little different than base i3 but the config should still be backwards compatible.

The Polybar setup is a collection of themes which I altered and adjusted myself, and I use the minimalist theme. You can see the original themes here: [polybar-collection](https://github.com/Murzchnvok/polybar-collection)

### dependencies
* i3
* polybar
