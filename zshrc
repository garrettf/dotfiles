#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
. $HOME/bin/z.sh

eval "$(rbenv init -)"

PATH=$HOME/bin:$PATH
PATH=$PATH:$HOME/node_modules/.bin

# regular rm
unalias rm

# for cs 164
LIBHOME=$HOME
source ~/.profile

source ~/.aliases

eval "$(nodenv init -)"
