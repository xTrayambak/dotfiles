## Dumb wallpaper script - it doesn't care about the time; just displays things
import std/[os, times, options, osproc, random, posix]
import ./[wallpaper_common, batinfo]
import pkg/pretty

proc getWallpaper*(prev: string): string {.inline.} =
  var photos: seq[string]

  for kind, path in walkDir("/home" / $getpwuid(geteuid()).pwName / ".wallpapers"):
    if kind != pcFile: continue
    echo path

    if path.splitFile().ext in [".jpg", ".png", ".jpeg", ".gif"]:
      photos.add(path)

  var
    i: int
    pick = sample photos

  while pick == prev:
    if i >= int16.high:
      echo "Failed to pick a wallpaper that is different from the previous within " & $int16.high & " tries."
      break

    inc i
    pick = sample photos

  pick

proc swww(wallpaper: string, step: int = 2, dontAnimate: bool = false) {.inline.} =
  var payload = "swww img "
  if not dontAnimate:
    payload &= "--transition-type random --transition-step " & $step & " --transition-fps 144 "

  discard execCmd(
    payload & wallpaper
  )

proc randWallpaperLoop {.inline.} =
  var prev: string
  var timeRemainingSecs = 0'f64
  var prevEpoch = epochTime()

  while true:
    let
      ostate = readWallpaperState()
      path = getBatteryPath()
      maximum = readInt(path / "energy_full")
      current = readInt(path / "energy_now")
      percentage = int((current / maximum) * 100f) 

    if ostate.isNone:
      continue
    
    let epoch = epochTime()
    timeRemainingSecs -= (epoch - prevEpoch)
    prevEpoch = epoch

    let state = ostate.get()
    if state.paused:
      timeRemainingSecs = 60
      continue
    
    if percentage < 40:
      echo "Not changing wallpaper to conserve battery"
      timeRemainingSecs = 60
      return

    if timeRemainingSecs <= 0 or (state.useWallpaper.isSome and state.useWallpaper.get() != prev):
      echo timeRemainingSecs
      prev = if state.useWallpaper.isSome:
        state.useWallpaper.get()
      else: ""

      let wallpaper = if state.useWallpaper.isSome:
        state.useWallpaper.get()
      else:
        getWallpaper(prev)

      echo wallpaper
      swww(wallpaper, dontAnimate = percentage < 70)
      prev = wallpaper
      timeRemainingSecs = float(rand(10 .. 20) * 60)

proc main {.inline.} =
  randomize()

  if paramCount() < 1:
    randWallpaperLoop()

  let op = paramStr(1)

  case op
  of "loop":
    randWallpaperLoop()
  of "rand":
    var x: string
    echo getWallpaper(x)
  else:
    discard

when isMainModule:
  main()
