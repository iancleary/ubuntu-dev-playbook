#!/bin/sh
ansible-playbook --connection=local --inventory=127.0.0.1, personal_computer.yml --check --ask-become-pass -e 'ansible_user='$(whoami)
