# autologin 
```bash
sudo n /etc/sddm.conf.d/autologin.conf
```
```ini
[Autologin]
User=your_username
Session=hyprland
```
# wayvnc
```bash
sudo pacman -Sy wayvnc
```
## auto start
```bash
~/.config/hypr/autostart.lua
```
```lua
o.launch_on_start("wayvnc")
```
