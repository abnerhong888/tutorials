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

# Enable vi key bindings
setw -g mode-keys vi

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

# create tmux new session with name
tmux new -s <session name>

# attach tmux with session
tmux attach -t <session name>

# tmux shortcut
ctrl + b + " horizontally split
ctrl + b + % vertically split
ctrl + b + ? help
ctrl + b + d detach to background
ctrl + b + [ copy mode -> space to select and y to yank (in vi key-mode)
ctrl + b + , rename window
ctrl + b + c create window
ctrl + b + x close window









```
