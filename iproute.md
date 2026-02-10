# commands
```bash
ip route add <ip>/24 via <ip> dev <device name>
ip route get <ip>/24 via <ip> dev <device name>
# this will show the ip path by your setting
ip route get <ip>
```

# ip forwarding
```bash
# enable
sudo sysctl -w net.ipv4.ip_forward=1
sudo iptables -P FORWARD ACCEPT
sudo iptables -t nat -A POSTROUTING -o <device name> -j MASQUERADE

# only post the ip to device
sudo iptables -t nat -A POSTROUTING -s <ip> -o <wlo1> -j MASQUERADE

# accept all from enp2s0 to wlo1
sudo iptables -A FORWARD -i <enp2s0> -o <wlo1> -j ACCEPT
# allow retrun traffic
sudo iptables -A FORWARD -i <wlo1> -o <enp2s0> -m state --state RELATED,ESTABLISHED -j ACCEPT


# disable
sudo sysctl -w net.ipv4.ip_forward=0
sudo iptables -P FORWARD DROP
sudo iptables -t nat -D POSTROUTING -o <device name> -j MASQUERADE

# only allow <ip> to <dst ip>
sudo iptables -A FORWARD \
  -d <ip> \
  -s <dstip.0/24> \
  -i <wlo1> -o <enp2s0> \
  -m conntrack --ctstate RELATED,ESTABLISHED \
  -j ACCEPT

# list ip tables
sudo iptables -L -v -n
```
