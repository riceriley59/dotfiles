# dotfiles
My dotfiles for different tools I use including Neovim, Tmux, Zsh, and Kitty. There is also an install script for easily installation of the tools and their configs including commands and a list of dependencies to install everything that is needed. This is meant to streamline the installation of these configs and increase productivity.

# install script
The install script sets up all the required configurations for the tools listed below. To use the script, simply clone this repository and run the `install.sh` script.

To automatically setup and install the dotfiles you can run the following commands in your shell:

```
git clone https://github.com/riceriley59/dotfiles.git
cd dotfiles
chmod +x install.sh
./install.sh all
```

**Note:** You can choose which dotfiles to install by passing the name of the tool in lowercase to the script (e.g `tmux` or `nvim`) or pass `all` to install all of the dotfiles as seen above.

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
