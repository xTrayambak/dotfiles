## Time-based wallpaper script

import std/[os, osproc, times, strutils, random, options]
import ./[logcore, wallpaper_common]

const IMAGE_EXT = [
  ".jpg", ".png", ".jpeg"
]
var
  prevEpoch = epochTime()
  timeRemaining = 0.0

type
  TimeOfDay* = enum
    Morning
    Afternoon
    Evening
    Night
    None

proc getWallpaper*(state: WallpaperState, fromTime: TimeOfDay = None): string {.inline.} =
  var 
    files: seq[string]
    morning, afternoon, evening, night: seq[string]

  for k, p in walkDir(getHomeDir() / "Wallpapers"):
    if k == pcFile and p.splitFile().ext in IMAGE_EXT:
      files.add(p)

  for f in files:
    if "night" in f:
      night.add(f)
      continue

    if "morning" in f:
      morning.add(f)
      continue

    if "afternoon" in f:
      afternoon.add(f)
      continue

    if "evening" in f:
      evening.add(f)
      continue
  
  case fromTime
  of Morning:
    return sample morning
  of Afternoon:
    return sample afternoon
  of Evening:
    return sample evening
  of Night:
    return sample night
  of None: discard
  
  if state.setTimeOfDay.isNone:
    let hour = now().hour()

    case hour
    of {1 .. 5}, {19 .. 24}:
      #echo "Picking a night wallpaper."
      return sample night
    of {6 .. 11}:
      #echo "Picking a morning wallpaper."
      return sample morning
    of {12 .. 15}:
      #echo "Picking an afternoon wallpaper."
      return sample afternoon
    of {16 .. 18}:
      #echo "Picking an evening wallpaper."
      return sample evening
  else:
    case state.setTimeOfDay.get()
    of "night": return sample night
    of "morning": return sample morning
    of "afternoon": return sample afternoon
    of "evening": return sample evening
    else: return getWallpaper(default WallpaperState)

proc swww(wallpaper: string, step: int = 2) {.inline.} =
  echo execCmd(
    "swww img --transition-type random --transition-step " & $step & " --transition-fps 144 " & wallpaper
  )

proc randWallpaperLoop {.inline.} =
  var prev: string
  var prevTime: string

  while true:
    let ostate = readWallpaperState()
    
    if ostate.isNone:
      continue

    let state = ostate.get()
    if state.paused:
      info "We're paused - sleeping for five minutes."
      sleep(60 * 60 * 5)
      continue
    
    if state.setTimeOfDay.isSome: echo "state: " & state.setTimeOfDay.get()
    if timeRemaining <= 0f or (state.useWallpaper.isSome and state.useWallpaper.get() != prev) or (state.setTimeOfDay.isSome and state.setTimeOfDay.get() != prevTime):
      let wallpaper = block:
        var x = if state.useWallpaper.isSome:
          state.useWallpaper.get()
        else:
          getWallpaper(state)

        if state.setTimeOfDay.isSome:
          prevTime = state.setTimeOfDay.get()

        while x == prev and state.useWallpaper.isNone:
          x = getWallpaper(state)
        
        x
      
      prev = wallpaper
      swww(wallpaper)
      echo wallpaper
      timeRemaining = float(rand(30 .. 60) * 60 * 60)
    else:
      let epoch = epochTime()
      timeRemaining -= (epoch - prevEpoch)
      prevEpoch = epoch

    sleep(240)

proc main {.inline.} =
  setupLogging("wallpaper")
  randomize()
  
  if paramCount() < 1:
    randWallpaperLoop()
    return

  let op = paramStr(1)

  case op
  of "loop":
    randWallpaperLoop()
  of "rand":
    if paramCount() < 2:
      echo getWallpaper(readWallpaperState().get())
    else:
      echo getWallpaper(readWallpaperState().get(), parseEnum(paramStr(2), None))
  else:
    discard

when isMainModule:
  main()
