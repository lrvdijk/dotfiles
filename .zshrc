# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"
DEFAULT_USER="lucas"

alias zshconfig="vim ~/.zshrc"

# Make sure tmux also uses nice colors
TERM=xterm-256color

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git celery django mercurial pip python virtualenv tmux)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH=$HOME/.gem/ruby/2.2.0/bin:$HOME/bin:/usr/local/bin:$PATH
export PATH=$PATH:$HOME/.cabal/bin
# export MANPATH="/usr/local/man:$MANPATH"

export EDITOR='vim'

# Compilation flags
# Use all 4 cores
export MAKEFLAGS="-j4"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Enable powerline (and use daemon mode)
powerline-daemon --quiet
. /usr/share/zsh/site-contrib/powerline.zsh

# Vi key bindings
bindkey -v
export KEYTIMEOUT=1
