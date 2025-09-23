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

# disable
sudo sysctl -w net.ipv4.ip_forward=0
sudo iptables -P FORWARD DROP
sudo iptables -t nat -D POSTROUTING -o <device name> -j MASQUERADE
```
