# Remote Wake-on-LAN (WoL) Setup Guide
**Hardware Architecture:** NanoPi R3s (Gateway/Exit Node) -> Xiaomi AX3000T (Router Mode) -> Target PC

---

## 1. Network Topology & IP Mapping

| Device | Role | IP / Subnet | Key Port |
| :--- | :--- | :--- | :--- |
| **NanoPi R3s** | Gateway / Tailscale Node | `192.168.X.1` (Subnet: `192.168.X.0/24`) | N/A |
| **Xiaomi AX3000T** | Router (WAN Port connected to NanoPi) | WAN: `192.168.X.X`<br>LAN: `192.168.31.1` | UDP 9 |
| **Target PC** | Destination Server | LAN: `192.168.31.X` (Static) | UDP 9 |

---

## 2. Linux Host Prerequisites (NanoPi R3s)

Before starting the Docker container, enable permanent IP forwarding on the host system:

```bash
echo 'net.ipv4.ip_forward = 1' | tee -a /etc/sysctl.d/99-tailscale.conf
echo 'net.ipv6.conf.all.forwarding = 1' | tee -a /etc/sysctl.d/99-tailscale.conf
sysctl -p /etc/sysctl.d/99-tailscale.conf
```

---

## 3. Tailscale Docker Compose Configuration

Create a `docker-compose.yml` file on your NanoPi R3s to handle Exit Node, Subnet Routing, and SNAT functionality.

```yaml
version: '3.8'

services:
  tailscale:
    image: tailscale/tailscale:latest
    container_name: tailscale
    hostname: nanopi-r3s
    network_mode: host
    cap_add:
      - NET_ADMIN
      - NET_RAW
    devices:
      - /dev/net/tun:/dev/net/tun
    volumes:
      - ./tailscale-state:/var/lib/tailscale
    environment:
      - TS_AUTHKEY=tskey-auth-kXXXXX-XXXXXXXXXXXXXXXXX
      - TS_EXTRA_ARGS=--advertise-exit-node --advertise-routes=192.168.X.0/24 --snat-subnet-routes=true
      - TS_STATE_DIR=/var/lib/tailscale
    restart: unless-stopped
```

### Steps to Apply:
1. Start the service:
   ```bash
   docker compose up -d
   ```
2. Log in to the [Tailscale Admin Console](https://login.tailscale.com/admin/machines).
3. Find the `nanopi-r3s` device, click `...` > **Edit route settings**.
4. Check and approve **both**:
   - `192.168.X.0/24` (Subnet route)
   - `Use as exit node`

---

## 4. Xiaomi AX3000T Configuration

Because the AX3000T remains in **Router Mode**, WoL magic packets must be forwarded across the NAT boundary via Port Forwarding.

1. **Assign Static IP for Target PC:**
   - Go to **Network Settings** > **DHCP Server**.
   - Bind your PC's MAC address to `192.168.31.X`.
2. **Set Up Port Forwarding:**
   - Go to **Advanced Settings** > **Port Forwarding**.
   - Create a new rule:
     - **Name:** `WoL_PC`
     - **Protocol:** `UDP`
     - **External Port:** `9`
     - **Internal IP:** `192.168.31.X`
     - **Internal Port:** `9`
3. Save and apply settings.

---

## 5. Target PC Settings

### BIOS/UEFI Settings
- Enable **Wake-on-LAN**, **PCIe Devices Power On**, or **Power On by PME**.

### OS Settings (Windows Network Adapter)
1. Open **Device Manager** > **Network Adapters**.
2. Right-click your Ethernet Controller > **Properties**.
3. **Advanced Tab:** Set `Wake on Magic Packet` to **Enabled**.
4. **Power Management Tab:**
   - Check `Allow this device to wake the computer`.
   - Check `Only allow a magic packet to wake the computer`.

---

## 6. How to Wake PC from iPhone

### Option A: Via iPhone WoL App (e.g., Mocha WOL / Wake on LAN)
1. Turn **ON** Tailscale on your iPhone.
2. Open your WoL app and configure a host:
   - **MAC Address:** Your PC's MAC address (e.g., `AA:BB:CC:DD:EE:FF`)
   - **IP / Hostname:** The **WAN IP** of the Xiaomi AX3000T (e.g., `192.168.X.X`, assigned by NanoPi)
   - **Subnet Mask:** `255.255.255.255` (Directed Unicast)
   - **Port:** `9`
3. Send packet.

### Option B: Via SSH Command / Shortcuts (Most Reliable)
Run this command from an iPhone SSH app (or iOS Shortcut SSH action) targeting the NanoPi:

```bash
docker exec -it tailscale wakeonlan -i 192.168.X.X -p 9 AA:BB:CC:DD:EE:FF
```
*(Replace `192.168.X.X` with your AX3000T WAN IP and `AA:BB:CC:DD:EE:FF` with your PC MAC address).*
