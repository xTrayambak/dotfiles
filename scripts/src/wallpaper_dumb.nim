## Dumb wallpaper script - it doesn't care about the time; just displays things
import std/[os, osproc, random, posix]
import ./batinfo

proc getWallpaper(prev: string): string {.inline.} =
  var photos: seq[string]

  for kind, path in walkDir("/home" / $getpwuid(geteuid()).pwName / "Wallpapers"):
    if kind != pcFile: continue

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
  while true:
    let
      path = getBatteryPath()
      maximum = readInt(path / "energy_full")
      current = readInt(path / "energy_now")
      percentage = int((current / maximum) * 100f) 
    
    if percentage < 40:
      echo "Not changing wallpaper to conserve battery"
      sleep rand(30..60) * 60 * 60
    
    swww(getWallpaper(prev), dontAnimate = percentage < 70)
    sleep rand(30..60) * 60 * 60

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
