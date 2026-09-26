# kde connect
```bash
sudo pacman -S kdeconnect
# fix hypr-land remote control issue
yay -S hypr-kdeconnect-fix
systemctl --user restart xdg-desktop-portal
```
```bash
n ~/.config/xdg-desktop-portal/portals.conf
systemctl --user daemon-reload
systemctl --user restart xdg-desktop-portal hypr-kdeconnect-portal.service
```
```conf
[preferred]
default=hyprland
org.freedesktop.impl.portal.ScreenCast=hyprland
org.freedesktop.impl.portal.Screenshot=hyprland
org.freedesktop.impl.portal.GlobalShortcuts=hyprland
org.freedesktop.impl.portal.RemoteDesktop=hypr-kdeconnect

```
## if want to auto start
```bash
n ~/.config/hypr/autostart.lua
```
```lua
o.launch_on_start("gio launch /usr/share/applications/org.kde.kdeconnect.daemon.desktop")
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
