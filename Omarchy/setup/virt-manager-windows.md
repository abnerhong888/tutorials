# windows setting
Mandatory Requirements for Dual Boot (Bare-Metal + VM)
Disable Fast Startup: You must disable Windows Fast Startup (powercfg -h off). If Fast Startup is enabled, Windows leaves the filesystem in a hibernated state when shutting down, causing instant NTFS corruption when booted in the opposite mode.

Disable BitLocker: Turn off BitLocker on drive C:. Switching between your physical motherboard's TPM and QEMU's emulated TPM (swtpm) will trigger BitLocker recovery screens every time you switch boot modes.

# Set up windwos on SSD by virt-manager
If "Add Boot Option" displays an empty list in OVMF, QEMU is either unable to access the physical block device due to bus/permission issues, or the drive lacks a FAT32 EFI System Partition.

1. **Set Disk Bus to SATA:** virt-manager GUI.
OVMF includes native SATA drivers by default. If the disk bus is set to VirtIO or SCSI, OVMF cannot scan the disk without explicit driver loading.

1. Shut down the VM.
2. Open VM details (lightbulb icon) and click **Disk 1**.
3. Expand **Advanced options**.
4. Set **Disk bus** to **SATA**.
5. Click **Apply** and start the VM.

*Verification:* Access **Boot Maintenance Manager > Boot Options > Add Boot Option** in OVMF and check if the file system selection volume appears.


2. **Check Drive Path and Fix Permissions:** Terminal.
QEMU running under `libvirt` may lack permission to read raw disk block devices in Omarchy.

1. Confirm you attached the **entire drive** rather than a single partition (path must not end in `-part1` or a partition number like `p1` or `sda1`).
2. Temporarily grant read/write access to the block device to rule out permission errors:

```bash
sudo chmod 666 /dev/disk/by-id/<your-disk-id>

```

3. Ensure no partitions on the disk are mounted on your host:

```bash
lsblk /dev/disk/by-id/<your-disk-id>

```

*Verification:* Start the VM. If the file system appears in OVMF after running `chmod`, add the `qemu` user to the `disk` group (`sudo usermod -aG disk qemu`) to make the permission permanent.


3. **Confirm EFI System Partition (ESP) Exists:** Terminal.
OVMF can **only** recognize drives with a FAT16/FAT32 formatted EFI System Partition.

Run `fdisk` on the host to check the partition table layout:

```bash
sudo fdisk -l /dev/disk/by-id/<your-disk-id>

```

Examine the output:

* **If `Disklabel type` is `dos` (MBR) or no `EFI System` partition is listed:** Your physical Windows drive was installed in Legacy BIOS mode. Change the VM firmware in `virt-manager` from **UEFI** to **BIOS (SeaBIOS)** under the **Overview** section.
* **If `Disklabel type` is `gpt` and an `EFI System` partition is listed:** The partition exists; ensure it is not corrupted.

*Verification:* `fdisk` output explicitly lists a partition with `EFI System` under the `Type` column.

# Fix virt-manager can not find boot UEFI

Your SSD uses a GPT partition table, but it **does not contain an EFI System Partition (ESP)**. When Windows was originally installed on this drive, its EFI bootloader was written to a different physical drive in your system.

Because `virt-manager` only sees this single SSD, OVMF cannot find any `bootmgfw.efi` file to launch Windows.

To fix this safely without risking data loss on your C: drive (`part2`), you can create a tiny 100 MB virtual EFI disk image, attach a Windows ISO to your VM, and use Windows Recovery to write a fresh EFI bootloader onto that virtual disk.

1. **Create a Virtual EFI Boot Disk Image:** Host Terminal.
Create a 100 MB virtual disk image on your Linux host to hold the missing EFI bootloader:

```bash
sudo qemu-img create -f qcow2 /var/lib/libvirt/images/win-esp.qcow2 100M

```

*Verification:* Run `ls -lh /var/lib/libvirt/images/win-esp.qcow2` and confirm the file exists.


2. **Attach Virtual EFI Disk and Windows Installation ISO:** virt-manager GUI.
1. Open your VM settings in `virt-manager` (lightbulb icon).
2. Click **Add Hardware > Storage**, select **Select or create custom storage**, browse to `/var/lib/libvirt/images/win-esp.qcow2`, set Device type to **Disk**, and Disk bus to **SATA**.
3. Click **Add Hardware > Storage**, select **Media type: CDROM**, browse to a Windows 10 or 11 installation `.iso` file, and set Disk bus to **SATA**.
4. Go to **Boot Options**, enable the CD-ROM drive, and move it to the top of the boot order.

*Verification:* Both `win-esp.qcow2` and the Windows ISO appear in the hardware list.


3. **Boot into Windows Repair Command Prompt:** VM Console.
1. Start the VM and press any key when prompted to boot from the CD/DVD.
2. On the Windows Setup screen, click **Next** -> **Repair your computer** (bottom left).
3. Select **Troubleshoot** -> **Command Prompt**.

*Verification:* A black command prompt window opens with `X:\Sources>`.


4. **Initialize Virtual ESP and Generate Boot Files:** VM Command Prompt.
Run `diskpart` inside the Command Prompt:

```cmd
diskpart
list disk

```

Identify the disk numbers:

* **Disk 0** is usually your physical SSD (~223 GB).
* **Disk 1** is the 100 MB virtual disk.

Run the following commands in `diskpart` (replace `1` with your 100 MB disk number if different):

```cmd
select disk 1
convert gpt
create partition efi
format quick fs=fat32 label="System"
assign letter=S
list volume

```

Note the drive letter assigned to your main Windows C: partition in the volume list (e.g., `C:` or `D:`). Then exit `diskpart`:

```cmd
exit

```

Now write the Windows EFI bootloader onto the virtual ESP (replace `C:` with your Windows drive letter if `list volume` showed a different letter):

```cmd
bcdboot C:\Windows /s S: /f UEFI

```

*Verification:* Command Prompt displays `Boot files successfully created.`


5. **Set Boot Order and Boot into Windows:** virt-manager GUI.
1. Turn off the VM.
2. Open VM details, go to **Boot Options**, uncheck the CD-ROM, and check `win-esp.qcow2` as the primary boot target.
3. Start the VM.

*Verification:* OVMF detects the new bootloader on `win-esp.qcow2` and boots directly into Windows.


# Network fix
An IP address starting with `169.254.x.x` (APIPA) confirms that your `e1000e` network card in Windows is working, but it cannot reach libvirt's DHCP server (`dnsmasq`) on the host to get an IP address.

1. **Restart the libvirt Network and DHCP Service:** On Host Linux Terminal.
1. On your Linux host, force-restart the virtual network to restart `dnsmasq`:

```bash
sudo virsh net-destroy default
sudo virsh net-start default

```

2. Verify that the virtual interface `virbr0` is up and has its default IP:

```bash
ip addr show virbr0

```

*Verification:* You should see `virbr0` listed with state `UP` and an IP address of `192.168.122.1/24`.


2. **Force Windows to Request a New IP:** Inside Windows VM Command Prompt.
1. Open Command Prompt (`cmd`) in Windows.
2. Release the old APIPA address and request a new one from the host:

```cmd
ipconfig /release
ipconfig /renew

```

*Verification:* Run `ipconfig`. The IPv4 Address should now show `192.168.122.x` (usually `192.168.122.x`), and Default Gateway should show `192.168.122.1`.


3. **Manually Assign a Static IP in Windows:** Inside Windows VM (Fallback).
If DHCP continues to fail, manually assign an IP in the `192.168.122.x` range:

1. Press `Win + R`, type `ncpa.cpl`, and press **Enter**.
2. Right-click your Ethernet network adapter and select **Properties**.
3. Double-click **Internet Protocol Version 4 (TCP/IPv4)**.
4. Select **Use the following IP address**:
* **IP address:** `192.168.122.50`
* **Subnet mask:** `255.255.255.0`
* **Default gateway:** `192.168.122.1`


5. Select **Use the following DNS server addresses**:
* **Preferred DNS server:** `8.8.8.8`
* **Alternate DNS server:** `1.1.1.1`


6. Click **OK** on both windows.

*Verification:* Open `cmd` and run `ping 192.168.122.1` (ping host gateway). If successful, run `ping 8.8.8.8` (ping internet).


What happens when you run `ipconfig /renew` or ping `192.168.122.1` after setting the static IP?

If `ip link show master virbr0` returns nothing while the VM is running, QEMU has failed to create or attach a TAP interface (`vnetX`) to `virbr0`. This usually means `virbr0` is offline, the VM's network interface configuration is corrupted in libvirt, or host network backend packages are missing.

1. **Verify virbr0 Interface State:** On Host Linux Terminal.
Check if the `virbr0` bridge is active and UP on your host:

```bash
ip link show virbr0

```

* If `virbr0` does not exist: Libvirt's default network is not created. Run `sudo virsh net-define /etc/libvirt/qemu/networks/default.xml` or `sudo virsh net-autostart default`.
* If state is `DOWN`: Force it UP using `sudo ip link set virbr0 up`.

*Verification:* Running `ip link show virbr0` displays `state UP`.


2. **Re-create the VM Network Interface:** Inside virt-manager GUI.
Sometimes virt-manager keeps a broken interface mapping. Re-adding it forces libvirt to recreate the TAP device:

1. Shut down the Windows VM completely.
2. In virt-manager, open the VM window and click the **Details** (lightbulb) icon.
3. Select **NIC** on the left panel, then click **Remove** at the bottom right.
4. Click **Add Hardware** at the bottom left.
5. Select **Network**:
* **Network source:** `Virtual network 'default' : NAT`
* **Device model:** `e1000e`


