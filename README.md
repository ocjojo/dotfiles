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

## Install from Repo
```bash
# clone repo
git clone --bare <git-repo-url> $HOME/.dotfiles
# checkout; you might have to delete files that already exist
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME
# source the new .bash_profile
source $HOME/.bash_profile
# hide untracked files from status
dotfiles config --local status.showUntrackedFiles no
```


## Starting from scratch

```bash
git init --bare $HOME/.dotfiles
```
add the following to your .bash_profile:

```bash
# dotfiles mgmt
dotfiles() {
	if [[ "$1" == "add" ]] && [[ "$2" == "." ]]; then
		# git add . only works on files already in the git tree
		/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@ -u
	elif [[ "$1" == "commit" ]] && [[ "$2" == "-m" ]]; then
		/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $1 $2 "$3"
	else
		/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
	fi
}
```


```bash
#source the new function
source $HOME/.bash_profile
# hide untracked files from status
dotfiles config --local status.showUntrackedFiles no
```
