# README
My dotfiles

## Usage
Use `dotfiles <git command>` to commit changes. e.g.:

```bash
dotfiles status
dotfiles add .vimrc
dotfiles commit -m "Added vimrc"
dotfiles push
```

### Aliases

Local aliases can be added through `ea` (in .bash_aliases).

These are not committed.

You can also overwrite the default editor used by setting `EDITOR=path/to/editor`.

## Install from Repo
```bash
# clone repo
git clone --bare git@github.com:ocjojo/dotfiles.git $HOME/.dotfiles
# checkout; you might have to delete files that already exist
git checkout --git-dir=$HOME/.dotfiles/ --work-tree=$HOME
# hide untracked files from status
dotfiles config --local status.showUntrackedFiles no

# source the new .bash_profile
source $HOME/.bash_profile
# copy the iterm profile
cp .iterm-profile.json Library/Application\ Support/iTerm2/DynamicProfiles/iterm-profile.json
```


## Starting from scratch

```bash
git init --bare $HOME/.dotfiles
```

add the [dotfiles function](.bash_profile#L21) to your .bash_profile.

```bash
#source the new function
source $HOME/.bash_profile
# hide untracked files from status
dotfiles config --local status.showUntrackedFiles no
```

## List of commands

```bash
fuck # retry last command with sudo

ef <file> # open file in editor
ed <dir> # open dir in editor
eda <dir> # add dir to editor (-a option)

ea # (e)dit .bash_(a)liases
ep # (e)dit .bash_(p)rofile
sb # (s)ource .(b)ash_profile

ll # ls -lah

serve # serve current dir from localhost:8000

s <name> # save the current dir as name in bashmarks
g <name> # go to a bashmark
l # list all bashmarks

dotfiles <command> # alias for git to commit changes in dotfiles repo

# MacOS specific
showFiles # show hidden files in finder
hideFiles # hide hidden files in finder
```
