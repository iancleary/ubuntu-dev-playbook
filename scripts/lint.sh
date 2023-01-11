#!/bin/sh

# YAML
yamllint .

# Bash
shellcheck ./*.sh
shellcheck scripts/*.sh
