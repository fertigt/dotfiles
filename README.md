# fertigt Dotfiles

Dotfiles can be used to personalize your system.
This repository contains all my dotfiles to improve my personal experience of MacOS.

They can easily be installed via [GNU Stow](https://www.gnu.org/software/stow/).

# Installation

## Prerequesites

First you have to install GNU Stow:

```
brew install stow
```

## Install Dotfiles for Tools

Use `stow <DIRECTORY-NAME>` to symlink all dotfiles into `${HOME}` and subdirectories.

# Adding Additional Dotfiles

1. Create a new directory for your required config.
2. `cd <DIRECTORY-NAME>`
3. Now assume you are in your `${HOME}`.
4.
    + If the config file has to be installed directly in your home directory, put the config file in here.
    + If the config file has to be in a subdirectory, create the same hierarchy here. Put the config file in the corresponding subdirectory.
5. Run `stow <DIRECTORY-NAME>` to symlink your new config files.

# Acknowledgments

Some ideas for zshrc: [Christian Chiarulli](https://www.youtube.com/watch?v=bTLYiNvRIVI)

OneDark Vim Colorscheme: [Josh Dick](https://github.com/joshdick/onedark.vim)

Idea for stow: [Brandon Invergo](http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html)

Some ideas for Karabiner Elements: [Steve Losh](https://stevelosh.com/blog/2012/10/a-modern-space-cadet/)

Some ideas for vimrc: [ThePrimeagen](https://github.com/theprimeagen/.dotfiles)
