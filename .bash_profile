# use source .bash_profile to reload after changes

# retry last command with sudo
alias fuck='sudo $(history -p \!\!)'

# dotfiles mgmt
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# allows inclusion of local aliases.
# e.g. shortcuts for directories or ssh
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# MacOS specific
if [ $(uname) == "Darwin" ]; then
	alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
	alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
fi
