version = "0.1.0"
author  = "xTrayambak"
description = "All my scripts"
license = "GPL-2.0-only"
srcDir = "src"
binDir = "bin/"
bin = @[
  "locker", "power_saver",
  "screenshot", "wallpaper",
  "waybar_vpn", "wttr",
  "pretty_date"
]

import std/distros

foreignDep "openssl"

after build:
  echo "Moving stuff to ~/.scripts"
  exec "mv bin/* ~/.scripts"
  exec "rm -rf bin"
