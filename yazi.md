# install yazi
```
# from its release
https://github.com/sxyazi/yazi
```

# add default setting
```bash
mkdir ~/.config/yazi
touch ~/.config/yazi/yazi.toml
```

```bash
# add to ~/.bashrc
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	command rm -f -- "$tmp"
}
```

```~/.config/yazi/yazi.toml
# yazi.toml
[mgr]
show_hidden = true
```
