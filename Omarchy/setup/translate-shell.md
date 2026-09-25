# Omarchy Translation & Text-to-Speech (TTS) Setup Guide

This guide details how to set up an instant translation workflow with spoken audio and desktop notifications on Omarchy (Arch Linux + Hyprland / Wayland).

---

## 1. Overview & Architecture

* **Translation Engine Backend:** `translate-shell` (Uses **Google Translate** by default; supports **DeepL**, **Bing**, **Yandex**, etc.).
* **TTS Audio Backend:** `mpv` streaming spoken translation audio from Google TTS.
* **Clipboard Interface:** `wl-clipboard` (Native Wayland clipboard manager).
* **Desktop Notification:** `libnotify` (`notify-send`).
* **Hotkey Handler:** Hyprland window manager keybindings.

---

## 2. Prerequisites & Installation

Install the required packages using `pacman`:

```bash
sudo pacman -S translate-shell libnotify mpv wl-clipboard
```

---

## 3. Creating the Translation Script

1. Create the local binaries directory if it does not exist:

```bash
mkdir -p ~/.local/bin
```

2. Create and edit the script file:

```bash
n ~/.local/bin/trans-clip
chmod +x ~/.local/bin/trans-clip
```

3. Paste the following script:

```bash
#!/bin/bash

TARGET_LANG=":zh-TW"
PLAY_SOUND_LANG=":en"
ENGINE="-e google"

TEXT=$(wl-paste --primary 2>/dev/null)
[ -z "$TEXT" ] && TEXT=$(wl-paste 2>/dev/null)

wait_for_enter_key(){
    _TEXT=$1
    _PLAY_SOUND_LANG=$2
    _ENGINE=$3
    _TARGET_LANG=":zh-TW+en"

    translate(){
        RESULT=$(trans $_ENGINE "$_TARGET_LANG" "$_TEXT")
        echo "$RESULT"
        echo -e '\n'
        echo "[[[ Press "
        echo "    's' to play sound, 'i' to input, 'l' to chang language"
        echo "    Enter or 'q' to quit ]]]"
    }

    translate;


    while true; do
        read -r -s -n 1 key

        if [[ "$key" == "s" || "$key" == "S" ]]; then
            echo -e -n "\r[ Play Sound 🔈 ] "
            trans -b -p $_ENGINE "$_PLAY_SOUND_LANG" "$_TEXT" >/dev/null 2>&1 &
        elif [[ "$key" == "i" ]]; then
            echo -e -n "\rEnter your text: "
            read -r -p "" _var

            if [[ $_var ]]; then
                _TEXT=$_var
                clear
                translate;
            fi
        elif [[ "$key" == "l" ]]; then
            echo -e -n "\rEnter your language command(ex. en:zh-TW): "
            read -r -p "" _var
            if [[ $_var ]]; then
                _TARGET_LANG="$_var"
            fi
        elif [[ "$key" == "" || "$key" == "q" ]]; then
            break
        fi
    done
}

if [ -n "$TEXT" ]; then
    case "$1" in
        play)
            trans -b -p $ENGINE "$PLAY_SOUND_LANG" "$TEXT" >/dev/null 2>&1 &
        ;;
        pop)
            # reference to /usr/share/omarchy/bin/omarchy-launch-floating-terminal-with-presentation
            export -f wait_for_enter_key
            cmd="wait_for_enter_key '$TEXT' '$PLAY_SOUND_LANG' '$ENGINE'; "
            exec setsid uwsm-app -- xdg-terminal-exec --app-id=org.omarchy.terminal --title=Omarchy -e bash -c "$cmd"
        ;;
        *)
            RESULT=$(trans -brief $ENGINE "$TARGET_LANG" "$TEXT")
            notify-send -a "Translate" "Translation ($TARGET_LANG)" "$TEXT\n$RESULT"
        ;;
    esac
fi


```

---

## 4. Hyprland Keybinding Configuration

Add a keybinding to trigger the script on keypress.

1. Open your Hyprland configuration file:

```bash
n ~/.config/hypr/bindings.lua
```

2. Add the following keybinding rule (binds `SUPER + SHIFT + T`):

```ini
# Translation shortcut
o.bind("CTRL + ALT + E", "translate-clip", "trans-clip")
o.bind("CTRL + ALT + S", "translate-clip play sound", "trans-clip play")
o.bind("CTRL + ALT + T", "translate-clip pop window", "trans-clip pop")

```

3. Reload Hyprland or save the file to apply changes.

---

## 5. Usage

1. **Highlight or copy** any text anywhere on your screen (web browser, text editor, terminal, PDF viewer).
2. Press **`SUPER + SHIFT + T`**.
3. A notification banner will appear with the translated text while the audio plays through your sound output.

-
