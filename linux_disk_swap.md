# 1. Check if it’s already active
```bash
swapon --show
```

# 2. Turn it off (temporarily)
```bash
sudo swapoff /swapfile
```

# 3. Remove or recreate it
```bash
sudo rm /swapfile

sudo dd if=/dev/zero of=/swapfile bs=1M count=4096
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
```

# 4. Make sure it’s permanent
```bash
# Check /etc/fstab — if you see a line with /swapfile, leave it (so it enables at boot).
# If not, add:
/swapfile none swap sw 0 0
```
