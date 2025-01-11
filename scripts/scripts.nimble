version = "1.0.0"
author  = "xTrayambak"
description = "All my scripts"
license = "GPL-2.0-only"
srcDir = "src"
binDir = "bin/"
bin = @[
  "locker", "power_saver",
  "screenshot", "wallpaper",
  "waybar_vpn", "wttr",
  "pretty_date", "batinfo",
  "netinfo", "player_notifs",
  "wallpaper_dumb", "tlp_root",
  "tlp_tray", "tlp_cli",
  "power_saver_userland", "airplane_mode",
  "wallpaper_cli", "music"
]

import std/distros

requires "https://github.com/xTrayambak/tray"
requires "colored_logger >= 0.1.0"

foreignDep "openssl"

after build:
  echo "Moving stuff to ~/.scripts"
  exec "mv bin/* ~/.scripts"
  exec "rm -rf bin"

requires "https://github.com/xTrayambak/tray >= 0.1.0"
requires "jsony >= 1.1.5"

requires "pretty >= 0.2.0"