# Client

```bash
sudo vim /etc/systemd/system/barrier.service
```
```
<user> user name
<gorup> group name
<port> display port "echo $DISPLAY"
<server ip> server ip

<monitor name> I set to "left"
```
```
[Unit]
Description=Barrier Service
After=network.target

[Service]
ExecStart=/usr/bin/barrierc --no-daemon --display :<port> --disable-crypto --name <monitor name> <server ip>
Restart=on-failure
User=<user>
Group=<group>
Environment=DISPLAY=:<port>

[Install]
WantedBy=default.target

```

#Server
```
# !!!!I put this into user space systemd, so no need user and group
# and you can do is
# systemctl --user daemon-reload
# systemctl --user start/stop/status/enable xxx.service

vim /home/user/.config/systemd/user/barrier.service
```
```
<port> display port "echo $DISPLAY"

<monitor name> I set to "main"
<barrier config path> you can create the config first with UI
```
```
[Unit]
Description=Barrier Service
After=network.target

[Service]
ExecStart=/usr/bin/barriers --no-daemon --display :<port> --disable-crypto --name <monitor name>  --config <barrier config path> 
Restart=on-failure
Environment=DISPLAY=:<port>

[Install]
WantedBy=default.target
```
