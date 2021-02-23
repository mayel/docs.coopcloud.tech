default: run

dependencies:
	@if [ ! -d ".venv" ]; then python3 -m venv .venv && .venv/bin/pip install -r requirements.txt; fi

run: dependencies
	@.venv/bin/mkdocs serve

.PHONY: dependencies run
