# wayvnc
```bash
nvim ~/.config/systemd/user/wayvnc.service
```
```ini
[Unit]
Description=WayVNC Headless VNC Server
Documentation=man:wayvnc(1)
# Ensures it starts after the graphical session is active
After=graphical-session.target
PartOf=graphical-session.target

[Service]
Type=simple
ExecStart=/usr/bin/wayvnc --render-cursor
# Auto restart configuration
Restart=on-failure
RestartSec=3s

# Environment settings to ensure Wayland connection works
Environment=WAYLAND_DISPLAY=wayland-0

[Install]
WantedBy=graphical-session.target
```

# sunshine
```bash
nvim ~/.config/systemd/user/sunshine.service
```

```ini
[Unit]
Description=Sunshine Game Streaming Server
Documentation=https://docs.lizardbyte.dev/projects/sunshine/
After=graphical-session.target sound.target
PartOf=graphical-session.target

[Service]
Type=simple
ExecStart=/usr/bin/sunshine
# Auto restart configuration
Restart=on-failure
RestartSec=3s

[Install]
WantedBy=graphical-session.target
```
