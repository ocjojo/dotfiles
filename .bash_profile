# use source .bash_profile to reload after changes

RED(){
	echo -e "\033[0;31m$@\033[00m"
}

for editor in subl sublime code nano vim vi; do
	if [ -n "$(${editor} --version 2>/dev/null)"  ]; then
		EDITOR=$editor
		break
	fi
done

### general aliases
# retry last command with sudo
alias fuck='sudo $(history -p \!\!)'
# dotfiles mgmt
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
# shortcut to open current dir in editor
alias ef="$EDITOR"
alias ed="$EDITOR ."
alias eda="$EDITOR . -a"
# shortcut to edit bash_profile
alias ep="$EDITOR ~/.bash_profile"
# shortcut to edit bash aliases
alias ea="$EDITOR ~/.bash_aliases"
# shortcut to source bash_aliases/bash_profile
alias sb="source ~/.bash_profile"
alias ll="ls -lah"
#shortcut to serve current dir as localhost
alias serve="python -m SimpleHTTPServer 8000"

# allows inclusion of local aliases.
# e.g. shortcuts for directories or ssh
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Bashmarks from https://github.com/huyng/bashmarks (see copyright there)
# USAGE: 
# s bookmarkname - saves the curr dir as bookmarkname
# g bookmarkname - jumps to the that bookmark
# g b[TAB] - tab completion is available
# l - list all bookmarks

# setup file to store bookmarks
touch ~/.sdirs

# save current directory to bookmarks
function s {
    check_help $1
    _bookmark_name_valid "$@"
    if [ -z "$exit_message" ]; then
        _purge_line "~/.sdirs" "export DIR_$1="
        CURDIR=$(echo $PWD| sed "s#^$HOME#\$HOME#g")
        echo "export DIR_$1=\"$CURDIR\"" >> ~/.sdirs
    fi
}

# jump to bookmark
function g {
    check_help $1
    source ~/.sdirs
    target="$(eval $(echo echo $(echo \$DIR_$1)))"
    if [ -d "$target" ]; then
        cd "$target"
    elif [ ! -n "$target" ]; then
        RED "WARNING: '${1}' bashmark does not exist"
    else
        RED "WARNING: '${target}' does not exist"
    fi
}

# print out help for the forgetful
function check_help {
    if [ "$1" = "-h" ] || [ "$1" = "-help" ] || [ "$1" = "--help" ] ; then
        echo ''
        echo 's <bookmark_name> - Saves the current directory as "bookmark_name"'
        echo 'g <bookmark_name> - Goes (cd) to the directory associated with "bookmark_name"'
        echo 'l                 - Lists all available bookmarks'
        kill -SIGINT $$
    fi
}

# list bookmarks with dirnam
function l {
    check_help $1
    source ~/.sdirs
        
    # if color output is not working for you, comment out the line below '\033[1;32m' == "red"
    env | sort | awk '/^DIR_.+/{split(substr($0,5),parts,"="); printf("\033[0;33m%-20s\033[0m %s\n", parts[1], parts[2]);}'
    
    # uncomment this line if color output is not working with the line above
    # env | grep "^DIR_" | cut -c5- | sort |grep "^.*=" 
}
# list bookmarks without dirname
function _l {
    source ~/.sdirs
    env | grep "^DIR_" | cut -c5- | sort | grep "^.*=" | cut -f1 -d "=" 
}

# validate bookmark name
function _bookmark_name_valid {
    exit_message=""
    if [ -z $1 ]; then
        exit_message="bookmark name required"
        echo $exit_message
    elif [ "$1" != "$(echo $1 | sed 's/[^A-Za-z0-9_]//g')" ]; then
        exit_message="bookmark name is not valid"
        echo $exit_message
    fi
}

# completion command
function _comp {
    local curw
    COMPREPLY=()
    curw=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=($(compgen -W '`_l`' -- $curw))
    return 0
}

# safe delete line from sdirs
function _purge_line {
    if [ -s "$1" ]; then
        # safely create a temp file
        t=$(mktemp -t bashmarks.XXXXXX) || exit 1
        trap "/bin/rm -f -- '$t'" EXIT

        # purge line
        sed "/$2/d" "$1" > "$t"
        /bin/mv "$t" "$1"

        # cleanup temp file
        /bin/rm -f -- "$t"
        trap - EXIT
    fi
}

# bind completion command for g,p,d to _comp
shopt -s progcomp
complete -F _comp g

# MacOS specific
if [ $(uname) == "Darwin" ]; then
	alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
	alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
    # shotcut for macdown
    alias md="/Applications/MacDown.app/Contents/SharedSupport/bin/macdown $1 > /dev/null 2>/dev/null"
fi
