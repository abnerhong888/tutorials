# Client

```bash
sudo vi /etc/systemd/system/barrier.service
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
<user> user name
<gorup> group name
<port> display port "echo $DISPLAY"

<monitor name> I set to "main"
<barrier config path> you can create the config first with UI
```
```
[Unit]
Description=Barrier Service
After=network.targe

[Service]
ExecStart=/usr/bin/barriers --no-daemon --display :<port> --disable-crypto --name <monitor name>  --config <barrier config path> 
Restart=on-failure
User=<user>
Group=<group>
Environment=DISPLAY=:<port>

[Install]
WantedBy=default.target
```
