# 1. Download and install neovim
```bash
sudo apt-get install neovim git

or

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
```

# 2. Set environment variable
```bash
#no need to do

or
    export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
    
    or

    wirte in /.profile
        #set PATH with nvim
        if [ -d "/opt/nvim-linux-x86_64/bin" ] ; then
            PATH="/opt/nvim-linux-x86_64/bin:$PATH"
        fi
    reboot system   

```

# 3. Install nerd font
```
https://www.nerdfonts.com/font-downloads
Hack Nerd Font
download zip file and unzip
mv "your.ttf" "~/.local/share/font"
set your terminal font to Hack Nerd Font
```

# 4. Git clone lazyvim

```bash
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git
run it and wait all setting done
```

# File location
```
---- setting dir 
~/.config/nvim
~/.local/share/nvim
~/.local/state/nvim
```