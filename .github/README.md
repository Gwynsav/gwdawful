> **Warning**
It is not uncommon for me to commit broken code. Also I don't guarantee this setup to be stable
or the slightest bit safe for use. You have been warned.

## TODO:
- Massive refactor of how numbers are handled. As things currently are, I made a pretty
big mistake where I performed a **shit ton** of arithmetic/logical operations through out
the config, which in turn causes it to be extremely unstable and prone to crashing. I am
currently working on fixing this, and so the configuration is currently undergoing pretty
fundamental changes. If you were here considering to try it out, I would like to ask you
not to, at least not for the time being.

# Welcome, stranger!
<img align="right" width="50%" src="./laptop_screenshot.png">
<img align="right" width="50%" src="./desktop_screenshot.png">

This is my awful configuration for the almighty **AwesomeWM**, featuring a 
user configuration file, repositionable bar and titles, dashboard,
notifications, screenshooting tools, multiple colorschemes, and more to
come, all done with Awesome's widget API!

Both results shown on the pictures are achievable through changing just
a few variables in the `userconf.lua` file.

## Dependencies
### Mandatory
- [Awesome-git](https://github.com/awesomeWM/awesome) (duh)
- [mpd](https://github.com/MusicPlayerDaemon/MPD), 
[mpDris2](https://github.com/eonpatapon/mpDris2) and 
[playerctl](https://github.com/altdesktop/playerctl) (music player and actions)
- [Network Manager](https://github.com/NetworkManager/NetworkManager) (network signals)
- [Pipewire](https://github.com/PipeWire/pipewire) and
[Wireplumber](https://github.com/PipeWire/wireplumber) (audio signals)
- [shotgun](https://github.com/neXromancers/shotgun),
[hacksaw](https://github.com/neXromancers/hacksaw),
[xclip](https://github.com/astrand/xclip) (screenshots)
- [IBM Plex](https://github.com/IBM/plex) and
[Material Icons](https://github.com/google/material-design-icons)

### Optional (toggleable)
- [brightnessctl](https://github.com/Hummer12007/brightnessctl) (brightness signals)
- [bluez](https://github.com/bluez/bluez) (bluetooth signals)
- [upower](https://github.com/freedesktop/upower) (battery signals)

----------------------
This configuration also uses [tym](https://github.com/endaaman/tym),
emacs, 
[firefox](https://www.mozilla.org/en-US/firefox/), 
[htop](https://github.com/htop-dev/htop), 
[lf](https://github.com/gokcehan/lf), 
and [nemo](https://github.com/linuxmint/nemo), 
by default, but none of these are hard requirements and you can 
easily change them in `userconf.lua`, although I still recommend **at 
least installing tym**.

## Installation

Install the dependencies listed above for your own distro. After that is
done, back your own configuration up, and you need only run:
```sh
$ git clone https://github.com/Gwynsav/gwdawful.git ~/.config/awesome --recursive
```

And that is basically it, note that I do not provide configuration files 
for the programs used by default, this is because those are written in Nix
for my [NixOS rice](https://github.com/Gwynsav/nix-dots/tree/master/users/common/config). 
You may still use them as reference but they don't exactly work as is if you're
not using Nix with Home Manager.

## Usage
### Keybinds
<details>

| Keybind                | Description                                                |
| ---------------------- | ---------------------------------------------------------- |
| AwesomeWM              | -                                                          |
| `mod + Control + r`    | Reload AwesomeWM.                                          |
| `mod + w`              | Opens the AwesomeWM menu.                                  |
| `mod + N`              | Switch to Nth tag.                                         |
| `mod + Control + N`    | Show Nth tag on current tag.                               |
| `mod + Shift + N`      | Send focused client to Nth tag.                            |
| `mod + Control + Shift + N` | Show focused client on Nth tag.                       |
| Applications           | -                                                          |
| `mod + Return`         | Opens a terminal.                                          |
| `mod + Shift + Return` | Opens a text editor.                                       |
| `mod + e`              | Opens a TUI file manager.                                  |
| `mod + Shift + e`      | Opens a GUI file manager.                                  |
| `mod + Escape`         | Opens a task manager/top application.                      |
| `mod + p`              | Opens an application launcher.                             |
| Window Management      | -                                                          |
| `mod + q`              | Close focused client.                                      |
| `mod + Mouse1`         | Move client by dragging mouse.                             |
| `mod + Mouse3`         | Resize client by dragging mouse.                           |
| `mod + j`              | Focus next client by index.                                |
| `mod + k`              | Focus previous client by index.                            |
| `mod + Shift + j`      | Switch client with next by index.                          |
| `mod + Shift + k`      | Switch client with previous by index.                      |
| `mod + period`         | Focus next screen by index.                                |
| `mod + comma`          | Focus previous screen by index.                            |
| `mod + m`              | Maximize focused client.                                   |
| `mod + f`              | Fullscreen focused client.                                 |
| `mod + s`              | Float focused client.                                      |
| `mod + Shift + s`      | Make focused client sticky.                                |
| `mod + Tab`            | Switch focused slave client with master.                   |
| Layout Management      | -                                                          |
| `mod + l`              | Grow master client.                                        |
| `mod + h`              | Shrink master client.                                      |
| `mod + equal`          | Increase amount of master clients.                         |
| `mod + minus`          | Decrease amount of master clients.                         |
| `mod + Shift + l`      | Grow tiled client.                                         |
| `mod + Shift + h`      | Shrink tiled client.                                       |
| `mod + Shift + equal`  | Increase amount of slave columns.                          |
| `mod + Shift + minus`  | Decrease amount of slave columns.                          |
| `mod + space`          | Cycle to next layout.                                      |
| `mod + Shift + space`  | Cycle to previous layout.                                  |
| Media Management       | -                                                          |
| `XF86AudioRaiseVolume` | Increase system audio volume.                              |
| `XF86AudioLowerVolume` | Decrease system audio volume.                              |
| `XF86AudioMute`        | Mute system audio.                                         |
| `XF86AudioPlay`        | Play/pause media playback.                                 |
| `XF86AudioNext`        | Skip to next song/video.                                   |
| `XF86AudioPrev`        | Rewind to previous song/video.                             |
| `XF86MonBrightnessUp`  | Increase screen backlight brightness.                      |
| `XF86MonBrightnessDown`| Decrease screen backlight brightness.                      |
| `mod + u`              | Cycle keyboard layouts.                                    |
| `Print`                | Take cursor selection screenshot.                          |
| `mod + Print`          | Take fullscreen screenshot.                                |
| UI                     | -                                                          |
| `mod + b`              | Toggle bar visibility.                                     |
| `mod + d`              | Toggle dashboard visibility.                               |

</details>

### Simple Configuration
You can edit some basic stuff by using the included variables inside of
`userconf.lua`. This configuration includes, border size, gaps, titles,
bar positions, and much more, as well as toggling features.

<details>
  
| Variable       | Type      | Description                                                                        |
| -------------- | --------- | ---------------------------------------------------------------------------------- |
| Applications   | -         | -                                                                                  |
| `terminal`     | `string`  | Terminal emulator to use. **Must be set**.                                         |
| `editor`       | `string`  | Text editor to use. **Must be set**.                                               |
| `browser`      | `string`  | Internet browser to use. **Must be set**.                                          |
| `top`          | `string`  | top application (like htop) to use. **Must be set**.                               |
| `files_cli`    | `string`  | CLI file explorer to use. **Must be set**.                                         |
| `files_gui`    | `string`  | GUI file explorer to use. **Must be set**.                                         |
| Settings       | -         | -                                                                                  |
| `modkey`       | `string`  | Mod1 is Alt, Mod4 is Super. Defaults to **"Mod4"**.                                |
| `caps_super`   | `boolean` | Makes CapsLock an additional Super key. Defaults to **false**.                     |
| `hover_focus`  | `boolean` | Should windows be focused on hover. Defaults to **false**.                         |
| `kb_layout1`   | `string`  | Keyboard layout to use. Entirely **optional**.                                     |
| `kb_layout2`   | `string`  | Alternate keyboard layout. Also entirely **optional**.                             |
| Features       | -         | -                                                                                  |
| `battery`      | `boolean` | Enable/disable battery metrics. Defaults to **false**.                             |
| `battery_name` | `boolean` | Specify battery name from Upower's interface. Defaults to **"battery_BAT0"**.      |
| `brightness`   | `boolean` | Enable/disable brightness metrics. Defaults to **false**.                          |
| `brightness_name` | `boolean` | Specify video adapter name from '/sys/class/backlight'. Defaults to **"intel_backlight"** |
| `bluetoothctl` | `boolean` | Enable/disable bluetooth metrics. Defaults to **false**.                           |
| UI             | -         | -                                                                                  |
| `resolution`   | `number`  | Your vertical resolution, eg 1080p. Defaults to **1080**.                          |
| `aspect_ratio` | `number`  | Your aspect ratio, eg 16/9 or 4/3. Defaults to **16/9**.                           |
| `dpi`          | `number`  | Your dpi. Defaults to **auto**. Dots built on 96, for reference.                   |
| `inner_gaps`   | `number`  | Regular gap size (screen%). Defaults to **0.4**.                                   |
| `outer_gaps`   | `number`  | Screen padding size (screen%). Defaults to **3 * inner_gaps**.                     |
| `border_size`  | `number`  | Size of client and widget borders (screen%). Defaults to **0**.                    |
| `border_rad`   | `number`  | Border rounding (screen%), 0 to disable. Defaults to **0.8**.                      |
| `bar_enabled`  | `boolean` | Change default bar state. Defaults to **true**.                                    |
| `bar_size`     | `number`  | Change bar thickness (screen%). Defaults to **4.5**.                               |
| `bar_pos`      | `string`  | May be: "left", "top", "right", "bottom". Defaults to **"left"**.                  |
| `bar_gap`      | `boolean` | Apply outer_gaps to bar. Defaults to **false**.                                    |
| `title_enable` | `boolean` | Enable/disable client titlebars. Defaults to **true**.                             |
| `titles_size`  | `number`  | Change titlebar thickness (screen%). Defaults to **3**.                            |
| `titles_pos`   | `string`  | May be: "left", "top", "right", "bottom". Defaults to **"top"**.                   |
| `dash_size`    | `number`  | Change dashboard size (screen%). Defaults to **75**.                               |
| `notif_size`   | `number`  | Change notification size (screen%). Defaults to **9**.                             |
| `notif_pos`    | `string`  | May be: "top_left", "top_right", "bottom_left", "bottom_right". Defaults to **auto** |
| Theming        | -         | -                                                      |
| `clr_palette`  | `string`  | "catppuccin", "everblush", "everforest", "tokyonight", "gruvbox", "solarized". Does **NOT** have a default. |
| `icon_pack`    | `string`  | GTK icon pack name. Defaults to **"Papirus"**.                                     |
| `ui_font`      | `string`  | Name of main UI font. Does **NOT** take size. Defaults to **"IBM Plex Sans"**.     |
| `ic_font`      | `string`  | Name of text icon font. Does **NOT** take size. Defaults to **"Material Icons"**.  |
| `mn_font`      | `string`  | Name of monospace font. Does **NOT** take size. Defaults to **"IBM Plex Mono"**.   |
| `user_avatar`  | `string`  | Path to user profile picture. Defaults to **$AWM/themes/assets/user.png"**.        |
| `user_wall`    | `string`  | Path to user wallpaper. Defaults to **colorscheme default**.                       |
| `player_bg`    | `string`  | Path to music player background image. Defaults to **colorscheme default**.        |
| `awm_icon`     | `string`  | "arch", "debian", "fedora", "nix", "ubuntu", "void" or path. Defaults to **AWM icon**. |
| Misc           | -         | -                                                                                  |
| `scrnshot_dir` | `string`  | Directory to save screenshots to. Defaults to **$HOME/Pictures/**.                 |
| `scratch_wide` | `number`  | Scratchpad terminal width (screen%). Defaults to **40**.                           |
| `scratch_high` | `number`  | Scratchpad terminal height (screen%). Defaults to **66**.                          |
  
</details>

# References
These people's dotfiles (and in some cases they themselves) have massively
helped me create this configuration.

[Blyaticon's cropping helper](https://git.gemia.net/paul.s/homedots). 
Finally some good fucking image usage.

[Alpha.'s NixOS Awesome setup](https://github.com/AlphaTechnolog/nixdots). 
General reference and stole his helpers :)

[Stardust-kyun's dotfiles](https://github.com/Stardust-kyun/dotfiles). 
Basically the first thing I started reading when I got into Awesome.

[Aproxia's dotfiles](https://github.com/Aproxia-dev/.dotfiles). 
Funny animation ghost.

Also got a few ideas from [elenapan's dotfiles](https://github.com/elenapan/dotfiles) 
and [rxyhn's Yoru](https://github.com/rxyhn/yoru).
