# Quick Note on /etc/profile.d/

Investigate this folder and your
~/.bashrc, ~/.zshrc, etc. files
will become simpler and more maintainable! 🚀

> Let's stuff a few more lines of configuration into that file, it will be fine 😬😬😬😬.

Tl;dr is that most shells source all files in that folder,
similar to `source ~/.bashrc` on a fresh Ubuntu install.
The main advantage for using the `/etc/profile.d/` folder
is that it is modular and maintainable.

Fast forward to your using that folder as it was intended.

> A zen like calm washes over you now that there is
> a single file per application and use case!

Your messy filing cabinet of assorted patches is no more. 🔥

> The `. /etc/profile` command is used to
> manually source the `/etc/profile.d/ folder.
