# ssh command
```bash
ssh -X <user>@<dir_ip>
```

# vscode ssh setting
```
# add into ssh config in vscode
ForwardAgent yes
ForwardX11 yes
ForwardX11Trusted yes

```

# also can add config in .ssh
```bash
vi ~/.ssh/config
Host <ip>
  HostName <ip>
  User <user>
  ForwardAgent yes
  ForwardX11 yes
  ForwardX11Trusted yes

```
# sshd setting config
```bash
vi /etc/ssh/sshd_config
```
