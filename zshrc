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

source ~/.dotfiles/aliases
eval "$(rbenv init -)"

PATH=$HOME/bin:$PATH
PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.4/bin
PATH=$PATH:$HOME/node_modules/.bin
# CS 164 stuff, unfortunately
PATH=$HOME/local/bin:$PATH

# regular rm
unalias rm

# for cs 164
LIBHOME=$HOME

# virtualenv
WORKON_HOME=~/envs
source /usr/local/bin/virtualenvwrapper.sh
