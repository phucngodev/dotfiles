#!/bin/bash
echo "===============Install homebrew and software================="

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brew install tmux neovim fd ripgrep btop starship fzf glow git-delta go nodejs postgresql@16 mariadb@11.4 protobuf colima docker docker-compose kubectl ansible

echo "=====================Copy config files======================="

mkdir -p ~/.config/nvim/
cp alacritty.yml ~/.alacritty.yml
cp bash_profile ~/.bash_profile
cp init.lua ~/.config/nvim/init.lua
cp tmux.conf ~/.tmux.conf
cp starship.toml ~/.config/starship.toml
source ~/.bash_profile

npm i -g typescript @tailwindcss/language-server

# GO tools
echo "===================Install GO tools=========================="
go install golang.org/x/tools/gopls@latest
go install golang.org/x/tools/cmd/goimports@latest
go install github.com/go-delve/delve/cmd/dlv@latest
go install github.com/fatih/gomodifytags@latest

go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
go install github.com/google/gnostic/cmd/protoc-gen-openapi@latest

echo "====================DONE===================================="
