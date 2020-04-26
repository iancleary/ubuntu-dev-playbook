# Per Machine Setup

The [inventory](https://github.com/iancleary/ansible-desktop/inventory) file uses the `localhost` and `{hostname}` groups to ensure
the IPv4 address used is `127.0.0.1`.

```bash
[hostname]
127.0.0.1
```

## Host specific variables

If you want per machine variables, create a `{hostname}.yml` in either:

* The [group_vars](group_vars) folder local to the repo (version controlled; not sensitive)
* The machine's `/etc/ansible/group_vars/` folder (not version controlled; sensitive)

> This allows hostnames to remain private outside of version control, for say secret operations 🕵️

In either case, the `{hostname}.yml` file will override the `all.yml` file within
the [group_vars](https://github.com/iancleary/ansible-desktop/group_vars) folder.

Please see Ansible's documentation for the order of precedence.

## Example Using This Repo As Is

For example, a `/etc/ansible/group_vars/my-awesome-hostname.yml` could be:

```yaml
---
nodejs_yarn_global_packages:
  - name: "@vue/cli"
  - name: "@gridsome/cli"
  - name: "nativefier"
  - name: "markdownlint-cli"
  - name: "carbon-now-cli"
```

## Example Forking This Repo

For example, a `./group_vars/my-awesome-hostname.yml` could be:

```yaml
---
nodejs_yarn_global_packages:
  - name: "@vue/cli"
  - name: "@gridsome/cli"
  - name: "nativefier"
  - name: "markdownlint-cli"
  - name: "carbon-now-cli"
```

Then add an entry in the [inventory](https://github.com/iancleary/ansible-desktop/inventory) file:

```ini
[localhost]
127.0.0.1

[travis]
127.0.0.1

[my-awesome-hostname]
127.0.0.1
```
