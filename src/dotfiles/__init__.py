"""Dotfiles installation tool."""

from dotfiles.config import load_config
from dotfiles.installer import Installer

__all__ = ["Installer", "load_config"]
