# kde connect
```bash
sudo pacman -S kdeconnect
# fix hypr-land remote control issue
yay -S hypr-kdeconnect-fix
systemctl --user restart xdg-desktop-portal
```

## kde command for iphone
Plugin Settings -> Execute remote command  
reference path : /usr/share/omarchy/default/hypr/bindings/media.lua  
| Name | Command |
| --- | --- |
| Play/Pause | omarchy-shell media playPause |
| Volume+ | omarchy-audio-output-volume +1 |
| Volume- | omarchy-audio-output-volume -1 |
| Mute | omarchy-audio-output-volume mute-toggle |
| Prev | omarchy-shell media previous|
| Next | omarchy-shell media next |
| Launch Spotify | uwsm-app spotify |
| Kill Spotify | pkill spotify |
