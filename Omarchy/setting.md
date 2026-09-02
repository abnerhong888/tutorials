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
# How to Mount a Windows Drive (NTFS)

### 1. Identify Your Windows Partition
Run the following command to locate your Windows NTFS partition and note its **UUID**:

```bash
lsblk -f
lsblk
```

---

### 2. Temporary Mount
Create a mount directory and mount your partition:

```bash
sudo mkdir -p /mnt/windows
sudo mount -t ntfs3 /dev/sdXn /mnt/windows
```
> **Note:** Replace `/dev/sdXn` with your actual partition name (e.g., `/dev/nvme0n1p3`).

---

### 3. Auto-Mount on Boot (Recommended)

1. Open `/etc/fstab` in a text editor:
   ```bash
   sudo nano /etc/fstab
   ```

2. Add this line at the bottom of the file (replace `YOUR-WINDOWS-UUID` with your actual UUID):
   ```text
   UUID=YOUR-WINDOWS-UUID /mnt/windows ntfs3 defaults,uid=1000,gid=1000,exec,nofail 0 0
   ```

3. Test and apply the configuration without rebooting:
   ```bash
   sudo mount -a
   ```
