#!/usr/bin/python3
# This file when run creates a Makefile.tempate file for me to copy into the Makefile
from typing import List
import yaml
import os

PLAYBOOK_FILE_DICT = {
    'playbook_terminal.yml': {
        "make_target": "ANSIBLE_PLAYBOOK_TERMINAL",
        "tags": []
    },
    'playbook_desktop.yml': {
        "make_target": "ANSIBLE_PLAYBOOK_DESKTOP",
        "tags": []
    },
}


OUTPUT_MAKEFILE_TEMPLATE = 'Makefile.template'

EXCLUDED_TAGS = ['never', 'skip-ci']

class MakefileTagTemplator():
    def __init__(self, playbook_dict):

        self.playbook_dict = playbook_dict

        for playbook in self.playbook_dict.keys():
            self.playbook_dict[playbook]["tags"] = self.parse_tags(playbook_file=playbook)

    def parse_tags(self, playbook_file) -> List[str]:
        _tags = None
        tags = set()
        with open(playbook_file) as file:
            playbook_yaml = yaml.safe_load(file)
            playbook_dict = playbook_yaml[0]
            if 'roles' in playbook_dict.keys():
                roles = playbook_dict['roles']
                for role in roles:
                    if 'tags' in role.keys():
                        _tags = role['tags']
                        tags = tags | set(_tags) # union
            if 'tasks' in playbook_dict.keys():
                tasks = playbook_dict['tasks']
                for task in tasks:
                    if 'tags' in task.keys():
                        _tags = task['tags']
                        tags = tags | set(_tags) # union
                    # print(_tags)

        tags = sorted(list(tags))
        tags = [tag for tag in tags if tag not in EXCLUDED_TAGS]

        return tags

    def create_makefile_template(self) -> None:
        os.remove(OUTPUT_MAKEFILE_TEMPLATE)
        output_file = open(OUTPUT_MAKEFILE_TEMPLATE, "w")
        for playbook, playbook_info in self.playbook_dict.items():
            for tag in playbook_info["tags"]:
                MAKEFILE_TEMPLATE = f"""\n{tag}:\n{tag}: ## Runs the {tag} ansible role\n	@$({playbook_info['make_target']}) --tags=\"{tag}\" --ask-become-pass\n"""
                output_file.write(MAKEFILE_TEMPLATE.format(tag=tag))
        output_file.close()

if __name__ == '__main__':
    # Intialization parses tags
    makefile_tag_templator = MakefileTagTemplator(playbook_dict=PLAYBOOK_FILE_DICT)
    # write out Makefile.template
    makefile_tag_templator.create_makefile_template()
    # go open file and copy paste below static Makefile content
    # leaving
