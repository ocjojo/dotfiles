# use source .bash_profile to reload after changes

# allows inclusion of local aliases, variables, etc.
# e.g. shortcuts for ssh
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
else
    echo "depending on your needs export the following variables in your bash_aliases file.
    TRAEFIK_DIR - directory of your traefik docker container
    TRAEFIK_NETWORK - external docker network traefik uses
    EDITOR - your preferred editor
    "
fi

export CLICOLOR=1
RED(){
	echo -e "\033[0;31m$@\033[00m"
}

if [[ $EDITOR == "" ]]; then
    for editor in code subl sublime nano vim vi; do
        if [ -n "$(${editor} --version 2>/dev/null)"  ]; then
            EDITOR=$editor
            break
        fi
    done
fi;

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

### general aliases
# retry last command with sudo
alias fuck='sudo $(history -p \!\!)'
# shortcut to open current dir in editor
alias ef="$EDITOR"
alias ed="$EDITOR ."
alias eda="$EDITOR . -a"
# shortcut to edit bash_profile
alias ep="$EDITOR $HOME/.bash_profile"
# shortcut to edit bash aliases
alias ea="$EDITOR $HOME/.bash_aliases"
# shortcut to source bash_aliases/bash_profile
alias sb="source $HOME/.bash_profile"
alias ll="ls -lah"
#shortcut to serve current dir as localhost
alias serve="python -m SimpleHTTPServer 8000"

# MacOS specific
if [ $(uname) == "Darwin" ]; then
	alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
	alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
    # shotcut for macdown
    alias md="/Applications/MacDown.app/Contents/SharedSupport/bin/macdown $1 > /dev/null 2>/dev/null"
    # Always open everything in Finder's list view. This is important.
    defaults write com.apple.Finder FXPreferredViewStyle Nlsv
fi


source $HOME/.bash.d/bashmarks

if [[ -n "$(docker-compose -v | grep 'docker-compose version')" ]]; then
    source $HOME/.bash.d/docker
fi;
