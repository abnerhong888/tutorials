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
# kitty
## lazyvim scrollback setting
```bash
nvim ~/.config/nvim/lua/plugins/kitty.lua
```
[kitty vim](https://github.com/mikesmithgh/kitty-scrollback.nvim)
```lua
return {
...
}
```
## set kitty config by the link
```bash
nvim …/.config/kitty/kitty.conf
```
