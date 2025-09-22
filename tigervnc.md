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
# set service, this is for [vncuser]
```bash
sudo vi /etc/systemd/system/vncserver_vncuser@.service
sudo systemctl daemon-reload

```

```
[Unit]
Description=Start TigerVNC server at startup
After=syslog.target network.target

[Service]
Type=forking
#set your user name
User=vncuser
#set your group
Group=user
Environment=/home/vncuser
HOME=/home/vncuser
WorkingDirectory=/home/vncuser

PIDFile=/home/vncuser/.vnc/%H:%i.pid
ExecStartPre=-/usr/bin/vncserver -kill :%i > /dev/null 2>&1 || :
#ExecStart=/usr/bin/vncserver -fg -geometry 1280x720 -localhost no :%i
ExecStart=/usr/bin/vncserver -geometry 1920x1080 -depth 24 -localhost no :%i
ExecStop=/usr/bin/vncserver -kill :%i > /dev/null 2>&1 || :

[Install]
WantedBy=multi-user.target
```
