# autologin 
```bash
sudo n /etc/sddm.conf.d/autologin.conf
```
```ini
[Autologin]
User=your_username
Session=hyprland
```
# autostart.lua
```bash
nvim ~/.config/hypr/autostart.lua
```

```lua
o.launch_on_start("wayvnc --render-cursor")
o.launch_on_start("sunshine")
o.launch_on_start("fcitx5")
o.launch_on_start("steam")
-- o.launch_on_start("spotify")
-- hl.dispatch(hl.dsp.exec_cmd("[workspace 4 silent] spotify"))
-- hl.dispatch(hl.dsp.exec_cmd("[workspace 5 silent] steam"))
hl.window_rule({
  match = { class = "^(spotify|Spotify)$" },
  workspace = "4",
  no_initial_focus = true,
  suppress_event="activate",
})
hl.window_rule({
  match = { class = "^(steam)$" },
  workspace = "5",
  float = false,
  center = true,
  no_initial_focus = true,
  suppress_event="activate",
})


```
# Set personal in menu
```bash
nvim ~/.config/omarchy/extensions/omarchy-menu.jsonc
```

```
  "personal": {
    "icon":"",
    "label":"Personal"
  },
  "personal.volumeControl": {
    "icon":"🔈",
    "label":"VolumeControl",
    "action":"uwsm-app -- pavucontrol"
  },
  "personal.fcitx5": {
    "icon":"🔤",
    "label":"fcitx5",
    "action":"uwsm-app -- fcitx5-config-qt"
  },
  "personal.virtManager": {
    "icon":"💻",
    "label":"VirtManager",
    "action":"uwsm-app -- virt-manager"
  },
  "personal.line": {
    "icon":"🟩",
    "label":"LINE",
    "action":"uwsm-app -- lutris lutris:rungame/line"
  },
  "personal.idescriptor": {
    "icon":"📱",
    "label":"iDescriptor",
    "action":"uwsm-app -- idescriptor"
  },
  "personal.kdeConnect": {
    "icon":"🎛️",
    "label":"KDE Connect",
    "action":"uwsm-app -- kdeconnect-app"
  },
  "personal.jdownloader": {
    "icon":"⬇️",
    "label":"Jdownloader",
    "action":"uwsm-app -- jdownloader"
  },


```
# nvim tab size
```bash
n ~/.config/nvim/lua/config/options.lua
```
```lua
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
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

