import std/[os, strutils]

const POWER = "/sys/class/power_supply/"

proc getBatteryPath*: string {.inline.} =
  var bat: string
  
  for k, d in walkDir(POWER):
    if k == pcFile: continue

    if d.startsWith(POWER / "BAT"):
      bat = d
      break
  
  bat

proc readStr*(path: string): string {.inline.} =
  var s = readFile(path)
  s.removeSuffix('\n')
  s

proc readInt*(path: string): int {.inline.} =
  readStr(path).parseInt()

proc getBatteryString*: string {.inline.} =
  let 
    path = getBatteryPath()
    maximum = readInt(path / "energy_full")
    current = readInt(path / "energy_now")
    percentage = int((current / maximum) * 100f)
    status = readStr(path / "status")
    charging = status == "Charging"

  var icon: string

  if charging:
    icon = ""
  else:
    icon = if percentage > 90:
      ""
    elif percentage > 65 and percentage < 90:
      ""
    elif percentage > 35 and percentage < 65:
      ""
    elif percentage > 3 and percentage < 35:
      ""
    elif percentage < 3:
      ""
    else:
      "this never happens lol"

  icon & ' '

when isMainModule:
  echo getBatteryString()
