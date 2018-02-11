# README
My dotfiles

## Starting from scratch
```bash
git init --bare $HOME/.dotfiles
# ignore bare repo dir to avoid recursion problems
echo ".dotfiles" >> .gitignore
# create alias for dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
# hide untracked files from status
dotfiles config --local status.showUntrackedFiles no
echo "alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.bash_profile
```

## Install from Repo
```bash

# clone repo
git clone --bare <git-repo-url> $HOME/.dotfiles
# define alias
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
# hide untracked files from status
dotfiles config --local status.showUntrackedFiles no
# checkout content
dotfiles checkout
# source new file
source $HOME/.bash_profile
```

## Usage
Use `dotfiles <git command>` to commit changes. e.g.:

```bash
dotfiles status
dotfiles add .vimrc
dotfiles commit -m "Add vimrc"
dotfiles push
```
