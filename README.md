# Dotfile Repository

This repository serves as an archive and syncing tool for my personal dotfiles.
They are intended for various Linux machines that I'm using. Different hosts
are organized under different branches.

## Applying files

The directory structure is meant to be used with GNU stow. For example to apply
the bash configurations you would place this repository in the home directory
(e.g. `/home/user/dotfiles`) and then execute `stow bash` inside that
directory. It may be necessary to remove already existing files beforehand.
