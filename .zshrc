stty -ixon
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export EDITOR=nvim
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob=!.git/* --glob=!vendor/* --glob=!node_modules/*'

export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=1
export PATH=/usr/local/bin:$PATH
export PATH=/opt/homebrew/bin:$PATH
export PATH=/usr/local/go/bin:$PATH
export GOPROXY=https://proxy.golang.org
export GOPATH=/Users/phuc/Documents/Codes/go
export GOCACHE=$GOPATH/go-build
export GOBIN=$GOPATH/bin
export PATH=${PATH}:$GOPATH/bin
export PATH=/Users/phuc/Documents/Codes/npm-global/bin:$PATH
export PATH=/Users/phuc/Documents/Codes/npm-global/bin:$PATH
export PATH=/opt/homebrew/opt/mysql@8.4/bin:$PATH
export PATH=/opt/homebrew/opt/postgresql@17/bin:$PATH

alias w="cd /Users/phuc/Documents/Codes"
alias ss="cd /Volumes/Data/Projects/"
alias ll="ls -al"
alias gl="git log --graph"
alias gs="git status"
alias gf="git diff"
alias gb="git branch"
alias gad="git add"
alias gcm="git commit"
alias gco="git checkout"
alias gpp="git push origin"
alias gpu="git pull origin"
alias theme="~/.config/theme.zsh"

eval "$(starship init zsh)"
[ -f ~/.config/fzf.zsh ] && source ~/.config/fzf.zsh
