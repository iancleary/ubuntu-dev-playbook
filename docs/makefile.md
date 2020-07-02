# Makefile and Use on Existing Machine

On an existing machine, I run the following bash command,
to ensure I am consistent with my playbook

## Make All

```bash
make all
```

This target runs four other targets in series:

* `bootstrap`
* `bootstrap-check`
* `install`
* `non-ansible`

Let's go through each.

### Make bootstrap

This installs several packages with `apt` and
python packages per the [requirements-ansible.txt](https://github.com/iancleary/ansible-desktop/blob/main/requirements-ansible.txt) file.

> This includes Ansible, using Python3.

This also moves the [home-local-bin.sh](https://github.com/iancleary/ansible-desktop/blob/main/home-local-bin.sh)
file to the `/etc/profile.d/` folder as described above.

> The `yarn` roles does a similar operation,
> except with Ansible instead of bash.

### Make bootstrap-check

This is to confirm both the `ansible` and `psutil`
Python3 packages are installed and on the `$PATH`.

If the pip installation falls back to using the `--user` flag,
packages will be located in the following directory under `$HOME`:

> Goal: `export PATH="$HOME/.local/bin:$PATH"` without duplication!

```bash
#/etc/profile.d/home-local-bin.sh

addToPATH() {
  case ":$PATH:" in
    *":$1:"*) :;; # already there
    *) PATH="$1:$PATH";; # or PATH="$PATH:$1"
  esac
}

# Important for python pip packages installed with --user
addToPATH "$HOME/.local/bin"
```

> `make bootstrap` will set this up for you!

*Source: [duplicate-entries-in-path-a-problem](https://unix.stackexchange.com/questions/14895/duplicate-entries-in-path-a-problem)*

### Make install

This runs the `personal_computer.yml` Ansible playbook.

The following two commands yield the same bash command:

```bash
make install
```

```bash
ansible-playbook personal_computer.yml \
-i inventory \
--ask-become-pass \
-e '{"users": [{"username": "$(shell whoami)"}]}'
```

> Note: `$(shell whoami)` in a Makefile translates to `$(whoami)` in bash.

The "-e" is for extra variable and is from my Ansible Galaxy role [iancleary/ansible-role-zsh_antibody#example-playbook](https://github.com/iancleary/ansible-role-zsh_antibody#example-playbook)

### Make non-ansible

This the targets that I found easier to maintain with bash or Makefile scripts.

```bash
# configure Flameshot with gsettings to bind to PrtScr
make flameshot-keybindings

# Ubuntu 20.04 defaults
make python-three-eight-install
make python-three-eight-supporting

...

```

## Naming Convention for Make Targets

> `make check` and `make install` are two of the standard
> [Makefile targets](https://www.gnu.org/prep/standards/html_node/Standard-Targets.html)
> for this repo.
