## small interface over hyprlock

import std/[os, random, options, strutils, osproc]
import ./[wallpaper_dumb, wallpaper_common, logcore]

proc lockUp {.inline.} =
  setupLogging("locker")
  randomize()

  info "Locking session"

  let wasPreviouslyPlaying = 
    execCmdEx("playerctl status").output == "Playing\n"
  
  discard execCmd(
    "notify-send \"Locking Your Desktop\" " &
    "\"See ya later!\" " &
    "-t 4000"
  )

  let wallpaper = getWallpaper("")
  info "Chosen wallpaper: " & wallpaper

  copyFile(
    wallpaper, 
    "/tmp/current-wallpaper"
  )
  
  info "Pausing any media players that might be running"

  when defined(release):
    discard execCmd(
      "playerctl pause"
    )

  info "Telling wallpaper script to stop shuffling around in order to save resources"
  setWallpaperState(
    WallpaperState(
      paused: true
    )
  )

  info "Forcing volume to 0%"
  discard execCmd("volumectl mute") # for the silly apps that play sounds even after pausing players (like games)

  info "Executing lock"
  discard execCmd(
    "hyprlock"
  )

  info "Session has been unlocked."
  removeFile("/tmp/current-wallpaper")

  info "Unmuting speakers"
  discard execCmd("volumectl unmute")

  if wasPreviouslyPlaying:
    info "Restarting all previously running media players"
    discard execCmd(
      "playerctl play"
    ) 
  
  info "Unpausing wallpaper script"
  setWallpaperState(
    WallpaperState(
      paused: false
    )
  )
  
  info "Greeting user."
  discard execCmd(
    "notify-send \"Welcome back, " & getEnv("USER").split('\n')[0] & "!\" " &
    "\"It's nice to see you back!\" " &
    "-t 4000"
  )

when isMainModule:
  lockUp()
