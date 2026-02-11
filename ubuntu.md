# set default terminal
```bash
gsettings set org.gnome.desktop.default-applications.terminal exec /usr/bin/x-terminal-emulator

trap 'history  -c; echo "" > ~/.bash_history' EXIT
```
