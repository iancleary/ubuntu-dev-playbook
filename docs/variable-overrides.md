## Overriding Defaults

Not everyone's development environment and preferred software configuration is the same.

You can override any of the defaults configured in `default.config.yml` by creating a `config.yml` file and setting the overrides in that file. For example, you can customize the installed packages and apps with something like:

```yaml
    nodejs_version: "14.x"
    nodejs_yarn_global_packages:
      - name: "@vue/cli"
      - name: "nativefier"
      - name: "markdownlint-cli"
      - name: "carbon-now-cli"

```

Any variable can be overridden in `config.yml`; see the supporting roles' documentation for a complete list of available variables.

### Order of precedence for variables

* Any content in the `config.yml` has the highest precedence (not version controlled; sensitive)
* The version controlled [default.config.yml](https://github.com/iancleary/ansible-desktop/tree/main/default.config.yml) file.

> This allows hostnames to remain private outside of version control, for say secret operations 🕵️

## Example Using This Repo As Is

For example, a `config.yml` could contain:

```yaml
---
nodejs_yarn_global_packages:
  - name: "@vue/cli"
  - name: "@gridsome/cli"
```

## Example Forking This Repo

For example, a `default.config.yml` could contain:

```yaml
---
nodejs_yarn_global_packages:
  - name: "@vue/cli"
```
