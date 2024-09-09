# Config

## Necessary Packages

### i3wm

To install i3 with a minimum of utility, you can run the following command:

```bash
sudo dnf install i3 i3status i3lock
```

### Application launcher

I am using ``rofi`` as an aplication launcher.

```bash
sudo dnf install rofi
```

The transparent background of the launcher window is assured by picom, a compositor.

```bash
sudo dnf install picom
```

### Background

The background is set using the ``feh`` library. To change the default wallpaper, just change the associated line in the config with a new image.

```bash
sudo dnf install feh
```

### Audio Player

The audio control is a mixed between the ``playerctl`` package to control player state (`play`, `pause`, `previous`, `next`), and the ``pactl`` to control the output device(s).

```bash
sudo dnf install pactl playerctl
```
