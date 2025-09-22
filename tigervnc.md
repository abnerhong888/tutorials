# install server and light desktop
```bash
sudo apt install tigervnc-standalone-server xfce4 xfce4-goodies
```

# create vncuser
```bash
sudo adduser vncuser
sudo su - vncuser vncpasswd
```
# set xstartup in user
```bash
touch ~/.vnc/xstartup
chmod +x ~/.vnc/xstartup
vi ~/.vnc/xstartup
```
```
#!/bin/sh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS

####################################
# For Ubuntu Startup
################################
exec startxfce4
```
# super user to set service
```bash
sudo vi /etc/systemd/system/vncserver@.service
sudo systemctl daemon-reload

```

```
[Unit]
Description=Start TigerVNC server at startup
After=syslog.target network.target

[Service]
Type=forking
User=<user>
#PAMName=login
Group=<group>
Environment=/home/<user>
HOME=/home/<user>
WorkingDirectory=/home/<user>
#PAMName=login

PIDFile=/home/<user>/.vnc/%H:%i.pid
ExecStartPre=-/usr/bin/vncserver -kill :%i > /dev/null 2>&1 || :
#ExecStart=/usr/bin/vncserver -fg -geometry 1280x720 -localhost no :%i
ExecStart=/usr/bin/vncserver -geometry 1920x1080 -depth 24 -localhost no :%i
ExecStop=/usr/bin/vncserver -kill :%i > /dev/null 2>&1 || :

[Install]
WantedBy=multi-user.target
```
