# dotfiles

Personal dotfiles for Neovim, Tmux, Zsh, Ghostty, Kitty, i3, and Polybar.

## Installation

```bash
git clone https://github.com/riceriley59/dotfiles.git
cd dotfiles
pip install -e .

# macOS
dotfiles configs/mac.yaml

# Linux
dotfiles configs/linux.yaml
```

## Structure

```
├── configs/          # YAML configs (mac.yaml, linux.yaml)
├── files/            # Dotfiles to install
│   ├── config/       # ~/.config/* (nvim, ghostty, kitty, i3, polybar)
│   ├── zsh/          # ~/.zshrc, ~/.zsh_profile
│   ├── tmux/         # ~/.tmux.conf
│   └── bin/          # ~/.local/scripts
└── src/dotfiles/     # Installer CLI
```

## What Gets Installed

| Config   | Destination | Notes |
|----------|-------------|-------|
| zsh      | `$HOME` | Requires [oh-my-zsh](https://ohmyz.sh/) |
| tmux     | `$HOME` | Requires [TPM](https://github.com/tmux-plugins/tpm) |
| nvim     | `~/.config/nvim` | Requires ripgrep |
| ghostty  | `~/.config/ghostty` | |
| kitty    | `~/.config/kitty` | |
| scripts  | `~/.local/scripts` | Requires fzf |
| i3       | `~/.config/i3` | Linux only |
| polybar  | `~/.config/polybar` | Linux only |

## Development

```bash
pip install -e ".[dev]"
pytest
```
