# create a tablet screen 
### **Automate Display Creation on Connection:** Optional Sunshine automation.
To avoid manually running commands every time you connect:
```bash
n ~/.config/sunshine/tablet_screen.sh
chmod +x ~/.config/sunshine/tablet_screen.sh
```
```sh
#!/bin/bash

MONITOR_NAME="virtual_tablet"
RESOLUTION="1920x1080@60"
POSITION="auto-left"
SCALE="1"

case "$1" in
    do|create|start)
        echo "Creating $MONITOR_NAME..."
        hyprctl output create headless "$MONITOR_NAME" && \
        hyprctl keyword monitor "$MONITOR_NAME,$RESOLUTION,$POSITION,$SCALE"
        sleep 1
        ;;
    undo|remove|stop)
        echo "Removing $MONITOR_NAME..."
        hyprctl output remove "$MONITOR_NAME"
        ;;
    *)
        echo "Usage: $0 {do|undo}"
        exit 1
        ;;
esac
```
1. Open Sunshine Web UI and go to the **Applications** tab.
2. Click **Edit** next to **Desktop** (or create a new app profile named "Tablet Display").
3. Add a **Prep Command**:
* **Do Command:** `/home/xxxx/.config/sunshine/tablet_screen.sh do`
* **Undo Command:** `home/xxxx/.config/sunshine/tablet_screen.sh undo`

4. Save the application settings.


### Set Sunshine to Capture ONLY the Extended Display

If Moonlight is showing your main desktop, Sunshine is capturing the wrong monitor.

1. Go to **Configuration** > **Audio/Video**.
2. Set **Output Name** to:
```text
virtual_tablet
```
3. Click **Save** and restart Sunshine.
