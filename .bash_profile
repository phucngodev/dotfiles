stty -ixon
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export EDITOR=nvim
export BASH_SILENCE_DEPRECATION_WARNING=1
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=1
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob=!.git/* --glob=!vendor/* --glob=!node_modules/*'

export PATH=/opt/homebrew/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/go/bin:$PATH
export GOPROXY=https://proxy.golang.org
export GOPATH=/Volumes/Data/Projects/go
export GOCACHE=$GOPATH/go-build
export GOBIN=$GOPATH/bin
export PATH=${PATH}:$GOPATH/bin
export PATH=/Volumes/Data/Projects/npm-global/bin:$PATH
export PATH=/opt/homebrew/opt/postgresql@16/bin:$PATH
export PATH=/opt/homebrew/opt/mariadb@11.4/bin:$PATH

eval "$(starship init bash)"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

alias ss="cd /Volumes/Data/Projects"
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

