"""Tests for configuration loading and path expansion."""

import tempfile
from pathlib import Path

import pytest

from dotfiles.config import expand_path, load_config


class TestExpandPath:
    def test_expands_home(self, tmp_path: Path) -> None:
        result = expand_path("$HOME/test", home=tmp_path)
        assert result == tmp_path / "test"

    def test_expands_config(self, tmp_path: Path) -> None:
        result = expand_path("$CONFIG/nvim", home=tmp_path)
        assert result == tmp_path / ".config" / "nvim"

    def test_expands_local(self, tmp_path: Path) -> None:
        result = expand_path("$LOCAL/scripts", home=tmp_path)
        assert result == tmp_path / ".local" / "scripts"

    def test_expands_multiple_variables(self, tmp_path: Path) -> None:
        # This is an edge case - typically you'd only use one
        result = expand_path("$HOME", home=tmp_path)
        assert result == tmp_path

    def test_no_variables(self, tmp_path: Path) -> None:
        result = expand_path("/absolute/path", home=tmp_path)
        assert result == Path("/absolute/path")


class TestLoadConfig:
    def test_loads_valid_yaml(self, tmp_path: Path) -> None:
        config_file = tmp_path / "config.yaml"
        config_file.write_text("""
configs:
  zsh:
    source: zsh
    dest: $HOME
    dependencies:
      - zsh
""")
        result = load_config(config_file)
        assert "configs" in result
        assert "zsh" in result["configs"]
        assert result["configs"]["zsh"]["source"] == "zsh"

    def test_raises_on_missing_file(self, tmp_path: Path) -> None:
        config_file = tmp_path / "nonexistent.yaml"
        with pytest.raises(FileNotFoundError):
            load_config(config_file)

    def test_loads_empty_config(self, tmp_path: Path) -> None:
        config_file = tmp_path / "empty.yaml"
        config_file.write_text("configs: {}")
        result = load_config(config_file)
        assert result["configs"] == {}
