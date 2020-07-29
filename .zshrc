ZSH=$HOME/.oh-my-zsh

# don't want coredumps
ulimit -S -c 0

# completion module
autoload -U colors && colors
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit

# include hidden files in completions
_comp_options+=(globdots)

setopt AUTO_CD
setopt CHASE_LINKS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_VERIFY
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt IGNORE_EOF
setopt CLOBBER
setopt EXTENDED_GLOB

# encoding stuff
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

DISABLE_LS_COLORS=true
export LS_COLORS="$(vivid generate jellybeans)"

HISTFILE="$HOME/.zsh_history"
HIST_STAMPS="dd/mm/yyyy"
HISTSIZE=10000
SAVEHIST=10000

alias cp="cp -i"
alias rm="rm -i"
alias mv="mv -i"
alias grep="grep --color=auto"
alias diff="diff --color=auto"
alias tree="tree -a"
alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'
alias pacin="sudo pacman -S"
alias pacout="sudo pacman -R"
alias pacrem="sudo pacman -Rs"
alias 2pac="sudo pacman -Syyuu" 
alias pacache="sudo paccache -ruk0 && sudo pacman -Sc"
alias packill="sudo pacman -Rcns"
alias pacmir="sudo reflector --latest 187 -p https --sort rate --save /etc/pacman.d/mirrorlist"
alias ls="exa"
alias ps="procs"
alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -"

plugins=(colorize extract gpg-agent safe-paste)

export PATH="${PATH:+${PATH}:}$HOME/.fzf/bin"
source "$HOME/.fzf/shell/key-bindings.zsh"

export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

[ ! -s $HOME/.travis/travis.sh ] || source $HOME/.travis/travis.sh

source $ZSH/oh-my-zsh.sh

eval "$(starship init zsh)"
