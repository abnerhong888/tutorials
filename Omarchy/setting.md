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
### auto start
```bash
~/.config/hypr/autostart.lua
```
```lua
o.launch_on_start("wayvnc --render-cursor &")
```
# kitty
### lazyvim scrollback setting
```bash
nvim ~/.config/nvim/lua/plugins/kitty.lua
```
[kitty vim](https://github.com/mikesmithgh/kitty-scrollback.nvim)
```lua
return {
...
}
```
### set kitty config by the link
```bash
nvim ~/.config/kitty/kitty.conf
```
# sunshine
```bash
omarchy install service sunshine
```
# audio control with graphical
```bash
sudo pacman -S pavucontrol qpwgraph
```

# fcitx5
```bash
omarchy pkg add fcitx5 fcitx5-configtool fcitx5-chinese-addons fcitx5-chewing
```
# How to Mount a Windows Drive (NTFS)

```bash
# Run the following command to locate your Windows NTFS partition and note its **UUID**:
lsblk -f
lsblk

# Create a mount directory and mount your partition:
# Replace `/dev/sdXn` with your actual partition name (e.g., `/dev/nvme0n1p3`).
sudo mkdir -p /mnt/windows
sudo mount -t ntfs3 /dev/sdXn /mnt/windows

# Auto-Mount on Boot
sudo nano /etc/fstab

# windows ntfs disk
UUID=YOUR-WINDOWS-UUID /mnt/<disk name> ntfs3 defaults,uid=1000,gid=1000,exec,nofail,x-gvfs-show,x-gvfs-name=<disk name> 0 0

sudo mount -a
```

