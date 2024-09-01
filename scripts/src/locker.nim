## small interface over hyprlock

import std/[os, random, options, strutils, osproc]
import ./[wallpaper, wallpaper_common, logcore]

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

  # set wallpaper - using one for the night as it'd save energy
  let wallpaper = getWallpaper(Night)
  info "Chosen wallpaper: " & wallpaper

  copyFile(
    wallpaper, 
    "/tmp/current-wallpaper"
  )
  
  info "Pausing any media players that might be running"
  discard execCmd(
    "playerctl pause"
  )
  
  info "Telling wallpaper script to stop shuffling around in order to save resources"
  setWallpaperState(
    WallpaperState(
      paused: true
    )
  )

  info "Executing lock"
  discard execCmd(
    "hyprlock"
  )

  info "Session has been unlocked."

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
