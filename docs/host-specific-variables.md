# Per Machine Setup

The [inventory](https://github.com/iancleary/ansible-desktop/blob/main/inventory) file uses the `localhost` and `{hostname}` groups to ensure
the IPv4 address used is `127.0.0.1`.

```bash
[hostname]
127.0.0.1
```

## Host specific variables

If you want per machine variables, run the `make setup_inventory_and_group_vars` command.

This creates two files:

* a `group_vars/{hostname}/all.yml`
* a `.inventory` file

> both are in the `.gitignore` file!

---

```yml
# ./group_vars/{hostname}/all.yml
---
# You can copy and modify variables over from group_vars/all/*.yml
```

and

```bash
# .inventory
[{hostname}]
127.0.0.1
```

### Order of precedence for variables

* Any content in the `group_vars/{hostname}/all.yml` has the highest precedence (not version controlled; sensitive)
* The version controlled [group_vars/all/*.yml](https://github.com/iancleary/ansible-desktop/tree/main/group_vars/all/) folder local to the repo (version controlled; not sensitive)

> This allows hostnames to remain private outside of version control, for say secret operations 🕵️

## Example Using This Repo As Is

For example, a `./group_vars/my-awesome-hostname/all.yml` could be:

```yaml
---
nodejs_yarn_global_packages:
  - name: "@vue/cli"
  - name: "@gridsome/cli"
```

## Example Forking This Repo

For example, a `./group_vars/all/node_yarn.yml` could be:

```yaml
---
nodejs_yarn_global_packages:
  - name: "@vue/cli"
```
