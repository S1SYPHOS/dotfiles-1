export PATH="$HOME/Coding/nspire/Ndless/ndless-sdk/toolchain/install/bin:$HOME/Coding/nspire/Ndless/ndless-sdk/toolchain/../bin:${PATH}"
export PATH="$PATH:/usr/local/sbin/:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$HOME/.local/bin"
export LD_LIBRARY_PATH="/usr/local/lib:/usr/lib/"

export GPG_TTY=$(tty)
export TERM="xterm-256color"
export TERMINAL=alacritty
export COLORTERM="truecolor"

export MANPAGER='less -X'
export PAGER=less

export PATH="$PATH:$HOME/.cargo/bin"
export CARGO_TARGET_DIR="$HOME/.cargo/target"

export GOPATH="$HOME/Coding/go"
export GOBIN="$HOME/Coding/go/bin"
export PATH="$PATH:$GOPATH/bin"

source $HOME/.zsecrets
