# install server and light desktop
```bash
sudo apt install tigervnc-standalone-server xfce4 xfce4-goodies
```
# setting
```bash
mkdir -p ~/.vnc
cd ~/.vnc
# set password
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
