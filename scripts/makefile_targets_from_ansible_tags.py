#!/usr/bin/python3
# This file when run creates a Makefile.tempate file for me to copy into the Makefile
from typing import List
import yaml

PLAYBOOK_FILE = 'playbook.yml'
OUTPUT_MAKEFILE_TEMPLATE = 'Makefile.template'

EXCLUDED_TAGS = ['never', 'skip-ci']

class MakefileTagTemplator():
    def __init__(self):
        self.tags = self.parse_tags()

    def parse_tags(self) -> List[str]:
        tags = set()
        with open(PLAYBOOK_FILE) as file:
            playbook_yaml = yaml.safe_load(file)
            playbook_dict = playbook_yaml[0]
            roles = playbook_dict['roles']
            tasks = playbook_dict['tasks']

        for role in roles:
            _tags = role['tags']
            tags = tags | set(_tags) # union
            # print(_tags)

        for task in tasks:
            _tags = task['tags']
            tags = tags | set(_tags) # union
            # print(_tags)

        tags = sorted(list(tags))
        tags = [tag for tag in tags if tag not in EXCLUDED_TAGS]

        return tags

    def create_makefile_template(self) -> None:
        output_file = open(OUTPUT_MAKEFILE_TEMPLATE, "w")
        for tag in self.tags:
            MAKEFILE_TEMPLATE = f"""\n{tag}:\n{tag}: ## Runs the {tag} ansible role\n	@$(ANSIBLE) --tags=\"{tag}\"\n"""
            output_file.write(MAKEFILE_TEMPLATE.format(tag=tag))
        output_file.close()

if __name__ == '__main__':
    # Intialization parses tags
    makefile_tag_templator = MakefileTagTemplator()
    # write out Makefile.template
    makefile_tag_templator.create_makefile_template()
    # go open file and copy paste below static Makefile content
    # leaving
