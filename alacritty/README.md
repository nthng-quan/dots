# alacritty

- [Themes](https://github.com/alacritty/alacritty-theme)

```bash
mkdir -p ~/.config/alacritty/themes
git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes
```

- add to `alacritty.toml`

```toml
[general]
import = [
    "~/.config/alacritty/themes/themes/{theme}.toml"
]
```
