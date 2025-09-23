# commands
```bash
ip route add <ip>/24 via <ip> dev <dev_name>
ip route get <ip>/24 via <ip> dev <dev_name>
# this will show the ip path by your setting
ip route get <ip>
```

# enable ip forwarding
```bash
sudo sysctl -w net.ipv4.ip_forward=1
sudo iptables -P FORWARD ACCEPT
sudo iptables -t nat -A POSTROUTING -o vmnet2-interface -j MASQUERADE
```
