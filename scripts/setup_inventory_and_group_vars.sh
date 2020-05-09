#!/usr/bin/env bash

set -e

GROUP_VARS_FILE="group_vars/$(hostname)"

# If file doesn't exist, prevents appending to existing file
if [ ! -f "$GROUP_VARS_FILE" ]; then
    mkdir -p "$GROUP_VARS_FILE"
    # -e tells echo to interpret backslash escapes
    echo -e "---\n# You can copy and modify variables over from ../all/*.yml" > "group_vars/$(hostname)/all.yml"
fi

PRIVATE_INVENTORY_FILE=".inventory"

# If file doesn't exist, prevents appending to existing file
if [ ! -f "$PRIVATE_INVENTORY_FILE" ]; then
    # -e tells echo to interpret backslash escapes
    echo -e "[$(hostname)]\n127.0.0.1" > $PRIVATE_INVENTORY_FILE
fi
