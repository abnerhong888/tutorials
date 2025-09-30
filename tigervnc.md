# install server and light desktop
```bash
sudo apt install tigervnc-standalone-server xfce4 xfce4-goodies
```

# create passwd
```bash
# it will automaticall create folder at ~/.vnc
vncpasswd
```
# set xstartup
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
this is for resolution optional, put this before exec startxfce4
```
xrandr --newmode "1920x1040_60.00" 193.25 1920 2056 2256 2592 1040 1203 1209 1245 -hsync +vsync
xrandr --newmode "1920x1200_60.00" 193.25 1920 2056 2256 2592 1200 1203 1209 1245 -hsync +vsync
xrandr --newmode "2560x1440_60.00" 312.25 2560 2752 3024 3488 1440 1443 1448 1493 -hsync +vsync
xrandr --newmode "2560x1600_60.00" 348.50 2560 2760 3032 3504 1600 1603 1609 1658 -hsync +vsync
xrandr --newmode "3840x1080_60.00" 346.75 3840 4080 4488 5136 1080 1083 1093 1120 -hsync +vsync
xrandr --newmode "3840x1040_60.00" 346.75 3840 4080 4488 5136 1040 1083 1093 1120 -hsync +vsync
xrandr --newmode "3840x2160_60.00" 712.75 3840 4160 4576 5312 2160 2163 2168 2237 -hsync +vsync
xrandr --newmode "3840x2400_60.00" 794.25 3840 4160 4584 5328 2400 2403 2409 2486 -hsync +vsync

xrandr --addmode VNC-0 "1920x1040_60.00"
xrandr --addmode VNC-0 "1920x1200_60.00"
xrandr --addmode VNC-0 "2560x1440_60.00"
xrandr --addmode VNC-0 "2560x1600_60.00"
xrandr --addmode VNC-0 "3840x1080_60.00"
xrandr --addmode VNC-0 "3840x1040_60.00"
xrandr --addmode VNC-0 "3840x2160_60.00"
xrandr --addmode VNC-0 "3840x2400_60.00"
```

# set service, this is the templeate

## you got to change  
```bash
<user> to your username
<group> set your group
<port> port you want to set
```

```bash
sudo vi /etc/systemd/system/vncserver_<user>.service
sudo systemctl daemon-reload
sudo systemctl start vncserver_user.service
# then you can use vncviewer to connect <ip:port>

# if error is -> unable to contact settings server Failed to execute child process "dbus-lanuch" (No such file or directory)
sudo apt install dbus-x11

```

```
[Unit]
Description=Start TigerVNC server at startup
After=syslog.target network.target

[Service]
Type=forking
#set your user name
User=<user>
#set your group
Group=<group>
Environment=/home/<user>
HOME=/home/<user>
WorkingDirectory=/home/<user>

PIDFile=/home/<user>/.vnc/%H:<port>.pid
ExecStartPre=-/usr/bin/vncserver -kill :<port> > /dev/null 2>&1 || :
ExecStart=/usr/bin/vncserver -geometry 1920x1080 -depth 24 -localhost no :<port>
ExecStop=/usr/bin/vncserver -kill :<port> > /dev/null 2>&1 || :

[Install]
WantedBy=multi-user.target
```


# create user 
```bash
sudo adduser <username>
sudo su - <username> vncpasswd
# delete user
sudo userdel -r <username>
```
# and then do the same setting from "set xstartup"
