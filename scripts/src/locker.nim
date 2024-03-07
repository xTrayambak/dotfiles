# small interface over swaylock

import std/[os, random, osproc]

proc getRandWallpaper: string {.inline.} =
  var files: seq[string]

  for x in walkDirRec(getHomeDir() / "Wallpapers"):
    if fileExists(x):
      files.add x

  sample files

proc lockUp {.inline.} =
  randomize()

  echo "~> we're gonna lock up, heheheha."

  discard execCmd(
    "notify-send \"Locking Your Desktop\" " &
    "\"See ya later!\" " &
    "-t 4000"
  )

  discard execCmd(
    "playerctl pause"
  )
  discard execCmd(
    "hyprlock"
  )
  discard execCmd(
    "playerctl play"
  )

  echo "~> unlocked."

  discard execCmd(
    "notify-send \"Welcome back, " & getEnv("USER") & " !\" " &
    "\"It's nice to see you back!\" " &
    "-t 4000"
  )

when isMainModule:
  lockUp()
