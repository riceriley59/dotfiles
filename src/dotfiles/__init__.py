"""Dotfiles installation tool."""

from dotfiles.installer import Installer
from dotfiles.config import load_config

__all__ = ["Installer", "load_config"]
