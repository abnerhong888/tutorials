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

# add display var in to server .bashrc
export DISPLAY="localhost:10.0"
```
