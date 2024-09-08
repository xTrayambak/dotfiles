import std/[os, options]
import jsony
import ./logcore

type
  WallpaperState* = object
    paused*: bool
    
    useWallpaper*: Option[string]
    setTimeOfDay*: Option[string]

const
  STATE_PATH* = "/tmp/wallpaper_state"

proc setWallpaperState*(state: WallpaperState) {.inline.} =
  writeFile(STATE_PATH, state.toJson())

proc readWallpaperState*: Option[WallpaperState] {.inline.} =
  if not fileExists(STATE_PATH):
    setWallpaperState(WallpaperState(paused: false))
    return some(WallpaperState(paused: false))
  
  try:
    return readFile(STATE_PATH).fromJson(WallpaperState).some()
  except CatchableError as exc:
    warn "an error occured whilst reading wallpaper state: " & exc.msg
    return
