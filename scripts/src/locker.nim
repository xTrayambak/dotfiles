# small interface over swaylock

import std/[os, random, strutils, osproc]

proc lockUp {.inline.} =
  randomize()

  echo "~> we're gonna lock up"

  let wasPreviouslyPlaying = execCmdEx("playerctl status").output == "Playing\n"

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

  if wasPreviouslyPlaying:
    echo "~> restarting player"
    discard execCmd(
      "playerctl play"
    ) 

  echo "~> unlocked."

  discard execCmd(
    "notify-send \"Welcome back, " & getEnv("USER").split('\n')[0] & " !\" " &
    "\"It's nice to see you back!\" " &
    "-t 4000"
  )

when isMainModule:
  lockUp()
