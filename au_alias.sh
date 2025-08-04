#!/bin/bash

au.test(){
    echo "autest"
}

au.source(){
    source ~/scripts/au_alias.sh
}

au.fnmode(){
    echo 2 | sudo tee /sys/module/hid_apple/parameters/fnmode
}

au.maxwin(){
    if [ -f ~/scripts/maxwin.sh ]; then
        ~/scripts/maxwin.sh
    else
        echo "maxwin.sh not found"
    fi
}

au.ssh(){
    ssh user@192.168.61.28
}

au.lpxy(){
    if [ -z "$1" ]; then
        echo "Usage: au.lpxy <ip>"
        return
    fi
    nmap -p 3128,8080,8888,1080 $1
}

au.gpxy(){
    if [ -z "$1" ]; then
        echo "Usage: au.gpxy <ip>"
        return
    fi
    nmap -p 3128,8080,8888,1080 $1 | grep -E 'Nmap scan report|open'
}


au.pxy(){
    PROXY_DIR="/home/user/ws/3proxy/bin/"
    CFG_NAME="3proxy.cfg"
    rm $CFG_NAME -f
    touch $CFG_NAME

cat > "$CFG_NAME" << EOL
nscache 65536
timeouts 1 5 30 60 180 1800 15 60

users u:CL:0000user

auth strong
allow u
proxy -p3128
flush
EOL

    sudo true
    # Run proxy in background
    sudo $PROXY_DIR/3proxy $CFG_NAME &
    PROXY_PID=$!
    
    # Wait for proxy and handle interruption
    trap "kill $PROXY_PID 2>/dev/null; rm $CFG_NAME -f; exit" INT TERM
    wait $PROXY_PID
    
    # Cleanup if proxy exits normally
    rm $CFG_NAME -f
}

au.net.static(){
    au.wi.on
    # grep enp2s0 via
    IP=$(ip route | grep enp2s0 | grep -oP 'via \K[0-9.]+')

    sudo ip route del default dev enp2s0
    sudo ip route add 192.168.0.0/16 via $IP
}

au.net.cn.name(){
    nmcli -t -f NAME,DEVICE,TYPE connection show --active | grep ethernet | cut -d ':' -f1
}

au.net.recn(){
    LAN_NAME="$(au.net.cn.name)"
    sudo nmcli connection down "$LAN_NAME" && nmcli connection up "$LAN_NAME"
}

au.net.reset(){
    WIFI_NAME="$(au.wi.cn.name)"
    sudo nmcli connection modify "$WIFI_NAME" ipv4.route-metric 600
    au.wi.off
}

au.wi.on(){
    nmcli radio wifi on
}

au.wi.off(){
    nmcli radio wifi off
}

au.wi.list(){
    nmcli dev wifi list
}

au.wi.cn(){
    nmcli dev wifi connect $@
}

au.wi.recn(){
    WIFI_NAME="$(au.wi.cn.name)"
    sudo nmcli connection down "$WIFI_NAME" && nmcli connection up "$WIFI_NAME"
}

au.wi.cn.name(){
    nmcli -t -f active,ssid dev wifi | grep ^yes | cut -d ':' -f2
}

au.wi.lowp(){
    WIFI_NAME="$(au.wi.cn.name)"
    sudo nmcli connection modify "$WIFI_NAME" ipv4.route-metric 99999
    au.wi.recn
}

au.wi.lowp.reset(){
    WIFI_NAME="$(au.wi.cn.name)"
    sudo nmcli connection modify "$WIFI_NAME" ipv4.route-metric 600
    au.wi.recn
}
