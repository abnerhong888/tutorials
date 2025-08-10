
# back conf file
```bash
cp /etc/squid/squid.conf /etc/squid/squid.conf.bak
# remember to clear all content in /etc/squid/squid.conf
```

| VM  | IP addresses                                      | Purpose                                   |
| --- | ------------------------------------------------- | ----------------------------------------- |
| VM1 | 192.168.31.28 (vmnet2)<br>192.168.192.131 (NAT)   | Squid proxy → has Internet access via NAT |
| VM2 | 192.168.31.20 (vmnet2)<br>192.168.32.22 (vmnet3) | Acts as bridge between VM3 and VM1        |
| VM3 | 192.168.32.33 (vmnet3)                            | Client → will reach VM1 through VM2       |


On VM1:
/etc/squid/squid.conf
```conf
http_port 3128
acl localnet src 192.168.31.0/24
http_access allow localnet
http_access deny all
```
sudo systemctl restart squid.service

On VM2:
/etc/squid/squid.conf
```conf
http_port 3128
cache_peer 192.168.31.28 parent 3128 0 no-query default
never_direct allow all
acl localnet src 192.168.32.0/24
http_access allow localnet
http_access deny all
```
sudo systemctl restart squid.service


# Install apache2-utils (for htpasswd)

On VM1:
```bash
sudo apt update
sudo apt install apache2-utils -y
```
Create a password file and user

```bash
sudo htpasswd -c /etc/squid/passwd myuser
```
It will prompt you for a password.
The -c option creates the file — only use -c the "first" time.
To add more users later, omit -c:

```bash
sudo htpasswd /etc/squid/passwd anotheruser
```

Configure Squid to use authentication
Edit /etc/squid/squid.conf on VM1, add above your http_access rules:

/etc/squid/squid.conf
```conf
http_port 3128

# Authentication settings
auth_param basic program /usr/lib/squid/basic_ncsa_auth /etc/squid/passwd
auth_param basic realm Squid Proxy
auth_param basic credentialsttl 2 hours
acl authenticated proxy_auth REQUIRED

# Define your network (optional)
acl localnet src 192.168.31.0/24

# Allow authenticated users from your subnet
http_access allow authenticated localnet

# Deny everything else
http_access deny all
```
sudo systemctl restart squid.service

Step 2 — VM2: Squid with Parent Proxy
On VM2:
/etc/squid/squid.conf
```conf
http_port 3128

# VM3's network
acl localnet src 192.168.32.0/24

# Parent proxy (VM1) with authentication
cache_peer 192.168.31.28 parent 3128 0 no-query default login=myuser:mypassword

# Always send traffic to parent
never_direct allow all

# Allow VM3 to connect
http_access allow localnet
http_access deny all
```

sudo systemctl restart squid.service

