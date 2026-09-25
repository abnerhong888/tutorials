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

# Target language code (e.g., :es for Spanish, :fr for French, :de for German, :zh for Chinese, :ja for Japanese)
TARGET_LANG=":zh-TW"
PLAY_SOUND_LANG=":en"

# Grab primary selection (highlighted text) or fall back to copied clipboard text
TEXT=$(wl-paste --primary 2>/dev/null)
[ -z "$TEXT" ] && TEXT=$(wl-paste 2>/dev/null)

if [ -n "$TEXT" ]; then
    # Fetch translated text
    RESULT=$(trans -brief "$TARGET_LANG" "$TEXT")
    # Send desktop notification
    notify-send -a "Translate" "Translation ($TARGET_LANG)" "$TEXT\n$RESULT"
    # Play translation audio in background
    trans -b -p "$PLAY_SOUND_LANG" "$TEXT" >/dev/null 2>&1 &
fi

```

---

## 4. Hyprland Keybinding Configuration

Add a keybinding to trigger the script on keypress.

1. Open your Hyprland configuration file:

   ```bash
   nano ~/.config/hypr/hyprland.conf
   ```

2. Add the following keybinding rule (binds `SUPER + SHIFT + T`):

```ini
# Translation shortcut
bind = SUPER SHIFT, T, exec, ~/.local/bin/trans-clip
```

3. Reload Hyprland or save the file to apply changes.

---

## 5. Usage

1. **Highlight or copy** any text anywhere on your screen (web browser, text editor, terminal, PDF viewer).
2. Press **`SUPER + SHIFT + T`**.
3. A notification banner will appear with the translated text while the audio plays through your sound output.

---

## 6. Advanced Customization & Terminal Usage

### Changing Default Translation Engine (e.g., to DeepL or Bing)

You can configure `translate-shell` to default to a different translation engine by creating a configuration file:

1. Create configuration folder and file:

```bash
mkdir -p ~/.config/translate-shell
nano ~/.config/translate-shell/init.trans
```

2. Set default options (e.g., DeepL engine and preferred target language):

```init
{
:engine "deepl"
:hl     "en"
:tl     "es"
}
```

### Quick Terminal Commands

* **Basic translation:**
```bash
trans "Hello world"
```
* **Translate and play audio directly in terminal:**
```bash
trans -p :fr "Good morning"
```
* **Use Bing or DeepL directly:**
```bash
trans -e bing :de "Thank you very much"
trans -e deepl :ja "Good evening"
```
* **Interactive translation session:**
```bash
trans -shell :es
```
