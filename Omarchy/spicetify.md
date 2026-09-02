# Installation

```bash
yay -S spicetify-cli
```
Grant write permissions to the Spotify directory so Spicetify can inject its files:

```bash
sudo chmod a+wr /opt/spotify
sudo chmod a+wr /opt/spotify/Apps -R
```

```bash
spicetify backup apply
```
```bash
spicetify update
```
