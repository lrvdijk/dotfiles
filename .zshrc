export PATH=/opt/homebrew/bin:$PATH

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/dotfiles/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Prezto setup
#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/prezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/prezto/init.zsh"
fi

# Enbable CLOBBER again (disabled by prezto)
setopt CLOBBER

# Nice colourtheme
# BASE16_SHELL="${ZDOTDIR:-$HOME}/base16-shell/"
# [ -n "$PS1" ] && \
#     [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
#         source "$BASE16_SHELL/profile_helper.sh"

export PATH=$PATH:$HOME/bin:/usr/local/bin
export PATH=$PATH:$HOME/.conda/bin/
export PATH=$PATH:$HOME/.cargo/bin/
export PATH=$PATH:$HOME/go/bin/
export PATH="$PATH:$HOME/.local/bin/"
export PATH=$PATH:/opt/homebrew/opt/sqlite/bin
export PATH=$PATH:$HOME/edirect/
export PATH="/usr/local/opt/openjdk/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="/opt/homebrew/opt/gcc/bin:$PATH"

CC=gcc-15
CXX=g++-15

# Vi key bindings
bindkey -v

export KEYTIMEOUT=1
setopt EXTENDED_GLOB

# Home/end keyboard mappings
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line

bindkey -M vicmd "q" push-line

# Search based on what you typed in already
bindkey -M vicmd "//" history-beginning-search-backward
bindkey -M vicmd "??" history-beginning-search-forward

# Incremental search
bindkey -M vicmd "/" history-incremental-search-backward
bindkey -M vicmd "?" history-incremental-search-forward

# To customize prompt, run `p10k configure` or edit ~/dotfiles/.p10k.zsh.
[[ ! -f ~/dotfiles/.p10k.zsh ]] || source ~/dotfiles/.p10k.zsh

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
export MAMBA_EXE='/opt/homebrew/bin/mamba';
export MAMBA_ROOT_PREFIX="$HOME/.mamba/envs";
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias mamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<

if [ -f "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc" ]; then
  source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
fi
if [ -f "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc" ]; then
  source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
