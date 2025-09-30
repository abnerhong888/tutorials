# Client

```bash
sudo vi /etc/systemd/system/barrier.service
```
```
<user> user name  
<gorup> group name  
<port> display port  
<server ip> server ip  
```
```[Unit]
Description=Barrier Service
After=network.target

[Service]
ExecStart=/usr/bin/barrierc --no-daemon --display :<port> --name left --disable-crypto <server ip>
Restart=on-failure
User=<user>
Group=<group>
Environment=DISPLAY=:<port>

[Install]
WantedBy=default.target

```
