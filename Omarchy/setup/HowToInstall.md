# wayvnc
```bash
sudo pacman -Sy wayvnc
n ~/.config/wayvnc/config
```
```config
address=127.0.0.1
port=5900
enable_auth=true
username=user
password=pass
```
# hypr-rdp
```bash
yay -S hypr-rdp
n ~/.config/hypr-rdp/config.toml
```
```toml
username = "user"
password = "pass"
fps = 30
#bind = "0.0.0.0:3389"
# resolution = "1920x1080"
# scale = 2
# output = "DP-1"
# audio_mode = "mirror"
# keyboard_layout_policy = "compositor"
```

# sunshine
```bash
omarchy install service sunshine
```
# pavucontrol
```bash
sudo pacman -S pavucontrol qpwgraph
```
# fcitx5
```bash
omarchy pkg add fcitx5 fcitx5-configtool fcitx5-chinese-addons fcitx5-chewing
```
# virt-manager
```bash
# Step 1: Install virt-manager and QEMU/KVM dependencies
sudo pacman -S --needed virt-manager qemu-desktop libvirt dnsmasq iptables-nft edk2-ovmf

# Step 2: Enable libvirtd service and assign user permissions
sudo systemctl enable --now libvirtd.service
sudo usermod -aG libvirt $USER
newgrp libvirt

# Step 3: Start and autostart default NAT network for guest internet access
sudo virsh net-start default
sudo virsh net-autostart default
```
# idescriptor
```bash
yay -S idescriptor
```
# scrcpy
```bash
sudo pacman -S scrcpy android-toolssudo pacman -S scrcpy android-tools
```
# crow translate
```bash
sudo pacman -S crow-translate
```
# kde connect
```bash
sudo pacman -S kdeconnect
sudo ufw allow 1714:1764/udp
sudo ufw allow 1714:1764/tcp
sudo ufw reload
```
