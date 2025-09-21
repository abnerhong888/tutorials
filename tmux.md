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
tmux a -t <session name>
tmux attach -t <session name>

# delete session
tmux kill-session -t <session name>

# tmux shortcut
ctrl + b + ? help
ctrl + b + " horizontally split
ctrl + b + % vertically split
ctrl + b + d detach to background

ctrl + b + [ copy mode -> space to select and y to yank (in vi key-mode)
ctrl + b + ] paste copied

ctrl + b + , rename window
ctrl + b + c create window
ctrl + b + x close window
ctrl + b + [0-9] select window by number
ctrl + b + n select next window
ctrl + b + l select previous window

ctrl + b + arrow u d l r select panel
press ctrl + b + arrow u d l r adjust panel size

ctrl + b + s sessions window and select
             kill session with x

ctrl + b + w sessions window and select








```
