import std/[os, random, osproc, options]
import ./[wallpaper_common, wallpaper]

proc notify(title, msg: string, urgencyVal: int = 0) {.inline.} =
  let urgency =
    case urgencyVal
    of 0: "low"
    of 1: "normal"
    of 2: "critical"
    else: "low"

  assert execCmd("notify-send \"" & title & "\" \"" & msg & "\" --urgency=" & urgency & " --expire-time=3600") == 0

proc main {.inline.} =
  assert paramCount() > 0, "expected command"

  case paramStr(1)
  of "toggle":
    template disable =
      setWallpaperState(
        WallpaperState(
          paused: true,
          useWallpaper: none(string)
        )
      )

      if paramCount() > 1 and paramStr(2) == "quiet":
        return
      else:
        notify("Wallpaper", "Your wallpaper slideshow has been paused.")

    template enable =
      setWallpaperState(
        WallpaperState(
          paused: false,
          useWallpaper: none(string)
        )
      )

      if paramCount() > 1 and paramStr(2) == "quiet":
        return
      else:
        notify("Wallpaper", "Your wallpaper slideshow has been unpaused.")

    let currState = readWallpaperState()

    if currState.isNone: disable
    if currState.get().paused:
      enable 
    else:
      disable
  of "set-wallpaper":
    assert paramCount() > 1, "expected path to wallpaper image"
    setWallpaperState(
      WallpaperState(
        paused: false,
        useWallpaper: some(paramStr(2))
      )
    )
  of "change-wallpaper":
    randomize()
    setWallpaperState(
      WallpaperState(
        paused: false,
        useWallpaper: some(getWallpaper())
      )
    )

    if paramCount() > 1 and paramStr(2) == "quiet":
      return
    else:
      notify("Wallpaper", "Your wallpaper has been changed.")
  else:
    quit "invalid command: " & paramStr(1)

when isMainModule:
  main()
