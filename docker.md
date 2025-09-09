# 1. Remove old Docker versions
```bash
sudo apt-get remove docker docker-engine docker.io containerd runc
```
# 2. Update system and install dependencies
```bash
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg lsb-release
```
# 3. Add Docker’s official GPG key
```bash
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
```
# 4. Set up Docker repository
```bash
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```
# 5. Install Docker Engine
```bash
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```
# 6. Using Docker without sudo
```bash
sudo groupadd docker
sudo usermod -aG docker $USER
```

