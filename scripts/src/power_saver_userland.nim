## Userland measures to save battery
import std/[os, osproc]
import ./[batinfo, wallpaper_common, logcore]

type
  PowerSaverMode = enum
    None
    Saving
    Conservative
    Performance

proc getPowerSaverMode(charging: bool, percentage: int): PowerSaverMode {.inline.} =
  if charging: return None

  if percentage < 60:
    Conservative
  else:
    Saving

proc setDisplayBrightness*(percentage: int) {.inline.} =
  discard execCmd("lightctl " & $percentage & '%')

proc setAnimations(flag: bool) {.inline.} =
  discard execCmd("hyprctl keyword animations:enabled " & $flag)

proc notify(title, msg: string, urgencyVal: int = 0) {.inline.} =
  let urgency =
    case urgencyVal
    of 0: "low"
    of 1: "normal"
    of 2: "critical"
    else: "low"

  assert execCmd("notify-send \"" & title & "\" \"" & msg & "\" --urgency=" & urgency & " --expire-time=3600") == 0

proc setDisplayRefreshRate*(
  display: string,
  resolution: array[2, int],
  hz: int
) {.inline.} =
  # TODO: replace this with hyprland-nim
  let cmd = "hyprctl keyword monitor \"" & display & ',' & $resolution[0] & 'x' & $resolution[1] & '@' & $hz & ",0x0,1\""
  assert execCmd(cmd) == 0, $cmd & ": failed!"

let path = getBatteryPath()
var prevMode = getPowerSaverMode(
  readStr(path / "status") in ["Charging", "Full"], int((readInt(path / "energy_now") / readInt(path / "energy_full")) * 100f) 
)

proc setPPDMode*(mode: string) {.inline.} =
  discard execCmd(findExe("powerprofilesctl") & " set " & mode)

proc modeBehaviour(mode: PowerSaverMode): int =
  case mode
    of Saving:
      info "Entered power saving mode"
      notify("Power Saving", "Performance has been reduced to save on battery life alongside the brightness.", 1)
      setDisplayRefreshRate("eDP-1", [1920, 1080], 60) # hz
      setDisplayBrightness(60)
      setPPDMode("power-saver")
      setWallpaperState(WallpaperState(paused: false))
      return 4000
    of Conservative:
      info "Entered critical/conservative power saving mode"
      notify("Power Saving", "Your battery is very low. Please charge it as soon as you can.", 2)
      setDisplayRefreshRate("eDP-1", [1920, 1080], 60) # hz
      setDisplayBrightness(30)
      setAnimations(false)
      setPPDMode("power-saver")
      setWallpaperState(
        WallpaperState(paused: false)
      )
      return 8000 # Slow down polling to save on battery
    of Performance:
      info "Entering performance mode"
      notify("Power Saving", "Entering high-performance mode")
      setDisplayBrightness(100)
      setAnimations(true)
      setPPDMode("performance")
      setWallpaperState(WallpaperState(paused: false))
      return 40
    of None:
      info "Entered AC mode - restoring defaults"
      notify("Power Saving", "Your battery is now charging, restoring system settings.")
      setDisplayRefreshRate("eDP-1", [1920, 1080], 144) # hz
      setDisplayBrightness(100)
      setPPDMode("balanced")
      setAnimations(true)
      setWallpaperState(WallpaperState(paused: false))
      return 40

proc heartbeat: int {.inline.} =
  let
    maximum = readInt(path / "energy_full")
    current = readInt(path / "energy_now")
    percentage = int((current / maximum) * 100f)
    status = readStr(path / "status")

  let mode = 
    getPowerSaverMode(status == "Charging" or status == "Full" or status == "Not Charging", percentage) 
  
  if mode != prevMode:
    if prevMode == Conservative and mode == Saving:
      prevMode = mode
      return

    prevMode = mode
    modeBehaviour(mode) 
  else:
    40

proc writePowerState*(state: PowerSaverMode) =
  writeFile(
    getHomeDir() / ".cache" / ".power_force_state",
    case state
    of Performance: "performance"
    of Saving: "power_saving"
    of Conservative: "conservative"
    of None: "ac"
  )

proc main {.inline.} =
  setupLogging "power_saver_userland"

  if paramCount() > 0:
    writeFile(getHomeDir() / ".cache" / ".power_force_state", paramStr(1))
    quit(0)
  
  discard modeBehaviour(prevMode)
  while true:
    sleep(heartbeat())

when isMainModule: main()
