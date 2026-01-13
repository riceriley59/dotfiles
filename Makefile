.PHONY: install install-dev test clean

install:
	pip install -e .

install-dev:
	pip install -e ".[dev]"

test:
	pytest

test-v:
	pytest -v

clean:
	rm -rf build/ dist/ *.egg-info src/*.egg-info .pytest_cache
	find . -type d -name __pycache__ -exec rm -rf {} +
