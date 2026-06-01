# install
```bash
sudo add-apt-repository ppa:lakinduakash/lwh
sudo apt update
sudo apt install linux-wifi-hotspot-cli
```
# How to use
```bash
sudo create_ap -g 192.168.13.1 wlo1 wlo1 HotspotA hotspot000 --freq-band 2.4 --hidden -w 2

sudo create_ap --stop wlo1

```
