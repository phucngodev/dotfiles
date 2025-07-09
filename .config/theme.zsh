#!/bin/zsh

CONFIG_LINE=$(sed -n '/theme/p' ~/.config/ghostty/config)
CURR_THEME=$(echo "$CONFIG_LINE" | awk -F '=' '{print $2}')

THEME=''
BTOP_THEME=''
CURR_BTOP_THEME=''
NVIM_THEME=''
CURR_NVIM_THEME=''
if [[ $CURR_THEME = "dark" ]]
then
    THEME="light"
    CURR_NVIM_THEME='everforest'
    NVIM_THEME="modus"
    CURR_BTOP_THEME='everforest-dark-medium'
    BTOP_THEME="flat-remix-light"
else
    THEME="dark"
    CURR_NVIM_THEME='modus'
    NVIM_THEME="everforest"
    CURR_BTOP_THEME='flat-remix-light'
    BTOP_THEME="everforest-dark-medium"
fi

sed -i '' "s/$CURR_THEME/$THEME/" ~/.config/ghostty/config
sed -i '' "s/$CURR_THEME/$THEME/" ~/.config/alacritty/alacritty.toml
sed -i '' "s/vim.cmd.colorscheme('$CURR_NVIM_THEME')/vim.cmd.colorscheme('$NVIM_THEME')/" ~/.config/nvim/init.lua
sed -i '' "s/vim.opt.background='$CURR_THEME'/vim.opt.background='$THEME'/" ~/.config/nvim/init.lua
sed -i '' "s/color_theme = $CURR_BTOP_THEME/color_theme = $BTOP_THEME/" ~/.config/btop/btop.conf
cp ~/.config/tmux/tmux.$THEME ~/.config/tmux/tmux.conf

pkill -SIGUSR2 ghostty
tmux source-file ~/.config/tmux/tmux.conf
