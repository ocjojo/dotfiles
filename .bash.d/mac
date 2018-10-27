if [ $(uname) != "Darwin" ]; then return; fi;

alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
# Always open everything in Finder's list view.
defaults write com.apple.Finder FXPreferredViewStyle Nlsv