#!/usr/bin/python3
import yaml
PLAYBOOK_FILE = 'playbook.yml'
OUTPUT_MAKEFILE_TEMPLATE = 'Makefile.template'

TAGS = set()
EXCLUDED_TAGS = ['never', 'skip-ci']

with open(PLAYBOOK_FILE) as file:
    lines = file.readlines()
    lines = [line.rstrip() for line in lines]
    tag_lines = [line for line in lines if "tags: " in line]
    for tag_line in tag_lines:
        pass

with open(PLAYBOOK_FILE) as file:
    playbook_yaml = yaml.safe_load(file)
    playbook_dict = playbook_yaml[0]
    roles = playbook_dict['roles']
    tasks = playbook_dict['tasks']

for role in roles:
    _tags = role['tags']
    TAGS = TAGS | set(_tags) # union
    print(_tags)

for task in tasks:
    _tags = task['tags']
    TAGS = TAGS | set(_tags) # union
    print(_tags)

TAGS = sorted(list(TAGS))
TAGS = [tag for tag in TAGS if tag not in EXCLUDED_TAGS]

if __name__ == '__main__':
    print(TAGS)

    output_file = open(OUTPUT_MAKEFILE_TEMPLATE, "w")
    for tag in TAGS:
        MAKEFILE_TEMPLATE = f"""\n{tag}:\n{tag}: ## Runs the {tag} ansible role\n	@$(ANSIBLE) --tags=\"{tag}\"\n"""
        output_file.write(MAKEFILE_TEMPLATE.format(tag=tag))
    output_file.close()
