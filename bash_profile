stty -ixon
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export BASH_SILENCE_DEPRECATION_WARNING=1
export EDITOR=nvim
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob=!.git/* --glob=!vendor/* --glob=!node_modules/*'
export PATH=/opt/homebrew/bin:$PATH
export PATH=/usr/local/bin:$PATH
export GOPROXY=https://proxy.golang.org
export GOPATH=/Users/phuc/Projects/go
export GOCACHE=$GOPATH/go-build
export GOBIN=$GOPATH/bin
export PATH=${PATH}:$GOPATH/bin
export PATH=/opt/homebrew/Cellar/postgresql\@16/16.1/bin:$PATH

eval "$(starship init bash)"
source "/opt/homebrew/opt/fzf/shell/key-bindings.bash"

alias vim=nvim
alias w="cd /Users/phuc/Projects"
alias gl="git log --graph"
alias gs="git status"
alias gf="git diff"
alias gb="git branch"
alias ll="ls -al"
alias gad="git add"
alias gcm="git commit"
alias gpp="git push origin"
alias gpu="git pull origin"

