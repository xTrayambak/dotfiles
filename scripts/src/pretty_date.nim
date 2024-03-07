# Used by hyprlock script

import std/[os, times]

proc main* {.inline.} =
  let ntime = now()
  let dayStr = case ntime.weekday()
  of dMon: "Monday"
  of dTue: "Tuesday"
  of dWed: "Wednesday"
  of dThu: "Thursday"
  of dFri: "Friday"
  of dSat: "Saturday"
  of dSun: "Sunday"

  let month = $ntime.month()
  let mday = ntime.monthday

  if paramCount() < 1:
    quit "where style?"

  let style = paramStr(1)

  case style
  of "lock_screen":
    echo dayStr & ", " & month & ' ' & $mday
  else:
    echo "whar? " & style

when isMainModule:
  main()
