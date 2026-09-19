# install docker
```bash
apl add docker dockerd docker-compose luci-app-dockerman
```

# tailscale compose
```bash
echo 'net.ipv4.ip_forward = 1' | tee -a /etc/sysctl.d/99-tailscale.conf
echo 'net.ipv6.conf.all.forwarding = 1' | tee -a /etc/sysctl.d/99-tailscale.conf
sysctl -p /etc/sysctl.d/99-tailscale.conf
```
```bash
mkdir /tailscale -p
cd /tailscale
vim docker-compose.yml
docker compose up -d
```
```yml
version: "3.8"

services:
  tailscale:
    image: tailscale/tailscale:latest
    container_name: tailscale-exit-node
    hostname: nanopi-r3s-exit
    environment:
      - TS_AUTHKEY=tskey-auth-kXXXXX-XXXXXXXXXXXXXXXXXX # Generate from Tailscale Admin Console
      - TS_STATE_DIR=/var/lib/tailscale
      - TS_EXTRA_ARGS=--advertise-exit-node 
      - TS_USERSPACE=false
    volumes:
      - /opt/tailscale-data:/var/lib/tailscale
      - /dev/net/tun:/dev/net/tun
    cap_add:
      - NET_ADMIN
      - NET_RAW
    network_mode: host # Allows direct access to physical interfaces on NanoPi
    restart: unless-stopped
```
