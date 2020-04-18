#!/bin/sh

# YAML
yamllint .

# Bash
shellcheck ./*.sh
shellcheck scripts/*.sh

# Markdown
# Ignore CHANGELOG.md as it has duplicate headings by design
markdownlint README.md AUTHORS.md
markdownlint docs/*.md
