## Used by the lock screen to get the battery information

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
  if paramCount() < 1:
    quit "batinfo [format]\nformats:\n- lock_screen\n- bool"

  let 
    path = getBatteryPath()
    maximum = readInt(path / "energy_full")
    current = readInt(path / "energy_now")
    percentage = int((current / maximum) * 100f)
    status = readStr(path / "status")
    charging = status == "Charging"
  
  case paramStr(1)
  of "lock_screen":
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
      else: "" # never happens

    icon & ' '
  of "bool":
    if paramCount() < 2:
      quit "batinfo bool [param]\nparams:\n- charging\n- full \n- mostly_charged"
    
    case paramStr(2):
      of "charging":
        return $charging
      of "full":
        return $(percentage == 100)
      of "mostly_charged":
        return $(percentage > 80)
      else:
        quit "invalid param: " & paramStr(2)
  else:
    quit "invalid format: " & paramStr(1)

when isMainModule:
  echo getBatteryString()
