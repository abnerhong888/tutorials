# Update winetricks
```bash
cd ~/.local/share/lutris/runtime/winetricks/winetricks
./winetricks --self-update
```
# LINE install
### download Kron4ek wine
```
https://github.com/Kron4ek/Wine-Builds/releases?page=1
```
extract wine to lutris 
```bash
mkdir -p ~/.local/share/lutris/runners/wine
mkdir -p ~/Games
tar -xf xxxx.tar.xz -C ~/.local/share/lutris/runners/wine
```
### download LINE
```bash
https://desktop.line-scdn.net/win/new/LineInst.exe
```
### create container
1. Add Game
2. Add Localy installed game
3. GameInfo->Name, set name: line
4. GameInfo->Runner, select Wine
5. GameOptions->Executable, set LineInst.exe
6. GameOptions->Wine prefix, set ~/Games/line
7. GameOptions->Prefix architecture, select 64-bit
8. RunnerOptions->Wine version, select the wine you put in 

### when install done
1. GameOptions->Executable, set ~/Games/line/drive_c/users/xxx/AppData/Local/LINE/bin/LineLauncher.exe

### download font
1. click winetricks
2. Select the default wineprfix
3. install a font
4. search for cjkfonts

### make wine windows signatured
Debian/Ubuntu：`sudo apt install osslsigncode`  
Fedora：`sudo dnf install osslsigncode`  
Arch：`sudo yay -S osslsigncode`  
```bash
mkdir -p ~/ws/wine_cert; cd ~/ws/wine_cert
nvim codesign.conf
openssl req -x509 -new -nodes -sha256 -utf8 -days 3650 -newkey rsa:2048 -keyout codesign.key -out codesign.crt -config codesign.conf
nvim codesign.sh
chmod +x codesign.sh
```
```codesign.conf
[req]
prompt = no
default_md = sha256
default_bits = 2048
distinguished_name = dn
x509_extensions = v3_req

[dn]
C = US
ST = Washington
L = Redmond
O = Microsoft Corporation
CN = Microsoft Windows

[v3_req]
subjectAltName = @alt_names

[alt_names]
DNS.1 = microsoft.com
```
```codesign.sh
#!/bin/bash
#windir="path-to-your/drive_c/windows"
windir="~/Games/line/drive_c/windows"
for file in "${windir}/system32"/*.dll "${windir}/syswow64"/*.dll
do
    echo "Signing ${file}"
    osslsigncode sign -certs codesign.crt -key codesign.key -in "${file}" -out "${file}.signed"
    mv "${file}.signed" "${file}" -f
done
```

### input chinese
System options -> Environment variables  
#### Fcitx
| key | value |
| --- | --- |
| GTK_IM_MODULE | fcitx     |
| QT_IM_MODULE  | fcitx     |
| XMODIFIERS    | @im=fcitx |
| SDL_IM_MODULE | fcitx     |
#### IBus
| key | value |
| --- | --- |
| GTK_IM_MODULE | ibus     |
| QT_IM_MODULE  | ibus     |
| XMODIFIERS    | @im=ibus |

