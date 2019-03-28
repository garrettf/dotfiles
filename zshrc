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
PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.4/bin
PATH=$PATH:$HOME/node_modules/.bin
# CS 164 stuff, unfortunately
PATH=$HOME/local/bin:$PATH

# regular rm
unalias rm

# for cs 164
LIBHOME=$HOME
source ~/.profile

if [[ -d "$HOME/stripe" ]]; then
  autoload -U +X bashcompinit && bashcompinit
  complete -C /Users/$USER/stripe/space-commander/bin/commands/sc-complete sc
  complete -C /Users/$USER/stripe/space-commander/bin/commands/sc-complete _sc

  [ -f ~/.stripe-repos.sh ] && source ~/.stripe-repos.sh

  path+="/Users/$USER/stripe/password-vault/bin"
  path+="/Users/$USER/stripe/space-commander/bin"

  ### BEGIN HENSON
  path+="/Users/$USER/stripe/henson/bin"
  ### END HENSON

  # Useful stripe aliases and functions
  alias stripe-curl='curl -s --unix-socket ~/.stripeproxy'

  export PATH
fi
