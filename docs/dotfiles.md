# Dotfiles

I use yadm to manage my dotfiles.

> Check out their [Getting Started Documentation](https://yadm.io/docs/getting_started)

The ansible role does more or less the following:

```bash
yadm clone -b main https://github.com/iancleary/dotfiles --bootstrap
```

This clones my dotfiles repo via HTTPS using yadm's [bootstrap](https://yadm.io/docs/bootstrap) standard command.

My Bootstrap script is [iancleary/dotfiles/blob/main/.config/yadm/bootstrap](https://github.com/iancleary/dotfiles/blob/main/.config/yadm/bootstrap). It's purpose is to:

* load my SSH keys,
* decrypt the private key,
* add the key to ssh-agent,
* test the connection,
* and exit.
