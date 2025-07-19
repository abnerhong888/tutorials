# 1. install powershell 7 on windows
```
https://learn.microsoft.com/zh-cn/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.4#msi
```
# 2. install scoop 
```
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```
# 3. use -> scoop install git cmake gcc fd ripgrep mingw
```
optional: lazygit unzip tree-sitter luarocks 

# install lazygit need to do
# scoop bucket add extras
```

https://www.fournoas.com/posts/neovim-on-windows/
https://blog.horonlee.com/posts/PowerShell%E5%BC%80%E5%8F%91%E9%85%8D%E7%BD%AE%E6%8C%87%E5%8C%97

*** if you want to use terminal in neovim, it will use win32 cmd as default
you can just type "powershell"(v5.x.x) or "pwsh"(v7.x.x)