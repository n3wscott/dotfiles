PS1_COLOR=82
PS1_SYM_OK="(╯°□°)╯︵ "
PS1_SYM_ERR="¯\(°_o)/¯"

source ~/dotfiles/.bash_ps1
source ~/dotfiles/.aliases

export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH

export PATH=$HOME/dotfiles/bin:$PATH

export PATH=$HOME/bin:$PATH

export PATH=$HOME/src/n3wscott/git-tools/bin:$PATH

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/snichols/Downloads/google-cloud-sdk/path.bash.inc' ]; then . '/Users/snichols/Downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/snichols/Downloads/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/snichols/Downloads/google-cloud-sdk/completion.bash.inc'; fi

export PATH="$HOME/.cargo/bin:$PATH"

source /usr/local/etc/profile.d/bash_completion.sh
. <(bujo completion)


ulimit -S -n 4096
