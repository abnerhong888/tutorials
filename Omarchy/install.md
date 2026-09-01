# Apps to install
## original exist in the os
1. tailscale
2. kitty
3. sshd
4. wayvnc
5. chrome
6. vscode
7. xrdp
8. steam
9. sunshine : gaming remotely server
10. windows VM : dual boot system
11. Lutris

## others
1. crow translate
2. scrcpy : tablet remote control on PC
3. fcitx5 : chweing and pinyin
4. KDE Connect
5. virt-manager : for run virtual machine

# windows install on another SSD, make it both of boot and vm can work
1. Disable Fast Startup:
  - Open the Start Menu, search for cmd, right-click it, and select Run as Administrator.
  - Run the following command:

```dos
powercfg /hibernate off
```
2. make Omarchy limine bootloader can add option for windows
Disable BitLocker (Device Encryption)
- Go to Settings $\rightarrow$ Privacy & Security $\rightarrow$ Device Encryption / BitLocker and toggle it Off.
- Check out the [Omarchy Guide](https://omarchy.org/manual/dual-boot-install/#:~:text=Bitlocker%20%23%20It's%20important%20to%20note%20that,to%20decrypt%20the%20drive.%20%E2%86%90%20Omarchy%20on).

