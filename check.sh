#!/bin/sh
ansible-playbook --connection=local --inventory=127.0.0.1, main.yml --check
