#!/bin/sh

# YAML
yamllint .

ansible-lint

# Bash
shellcheck ./*.sh
shellcheck scripts/*.sh
