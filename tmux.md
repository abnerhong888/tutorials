# 1. install tmux
```bash
sudo apt-get install tmux
```

# 2. tmux config setting
```bash
# install xclip for clipboard
sudo apt install xclip

vi ~/.tmux.conf

# set mouse on
set -g mouse on

# Use system clipboard when copying
set-option -g set-clipboard on

# For copy-mode
bind -T copy-mode-vi y send -X copy-pipe-and-cancel "xclip -selection clipboard -in"
bind -T copy-mode-vi Enter send -X copy-pipe-and-cancel "xclip -selection clipboard -in"

```
# 3. how to use
```bash
# Reload your config without restarting tmux:
tmux source-file ~/.tmux.conf
```
