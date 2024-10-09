#!/bin/bash

## /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brew install tmux neovim fd ripgrep btop starship fzf bat rig jq tree glow git-delta go node@22 mariadb@11.4 postgresql@16 protobuf colima docker docker-compose kubectl ansible ffmpeg graphviz hey redis rabbitmq yt-dlp

npm i -g typescript @tailwindcss/language-server svelte-language-server

# GO tools
go install golang.org/x/tools/gopls@latest
go install golang.org/x/tools/cmd/goimports@latest
go install github.com/go-delve/delve/cmd/dlv@latest
go install github.com/fatih/gomodifytags@latest

go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
go install github.com/google/gnostic/cmd/protoc-gen-openapi@latest
