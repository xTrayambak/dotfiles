import std/[os, strutils, osproc]

proc setBrightness(percentage: int) =
  discard execCmd(
    "brightnessctl set " & $percentage
  )
  discard execCmd(
    "notify-send \"Display brightness set to " & $percentage & "%\""
  )

proc getBrightness: int =
  let res = execCmdEx("brightnessctl get").output.splitLines()[0]
  result = parseInt res

  if result > 100:
    result = 100

proc getPrevBrightness: int =
  result = readFile(getHomeDir() / ".power_saver")
    .splitLines()[0]
    .parseInt() 

  if result > 100:
    result = 100

proc increment =
  discard execCmd("brightnessctl set 10%+")

proc decrement =
  discard execCmd("brightnessctl set 10%-")

proc powerSavingMode =
  let enable = not fileExists(getHomeDir() / ".power_saver")

  if enable:
    discard execCmd(
      "notify-send \"Power Saving Mode Enabled\" " &
      "\"Your system's speed will be reduced to conserve battery life.\" " &
      "--urgency=critical"
    )
    writeFile(getHomeDir() / ".power_saver", $getBrightness())
    setBrightness(50)
  else:
    let brightnessBefore = getPrevBrightness()
    discard execCmd(
      "notify-send \"Power Saving Mode Disabled\" " &
      "\"Your system's speed will now be returned to normal.\""
    )

    # TODO: this is a bad way to do this!
    for x in 0..11:
      increment()
      sleep 64

    removeFile(getHomeDir() / ".power_saver")

proc main {.inline.} =
    # it would be cool if this could work with cpufreq
    if paramCount() < 1:
      quit "where operation?"

    let op = paramStr 1

    case op:
      of "power_saving_mode":
        powerSavingMode()
      of "inc":
        increment()
      of "dec":
        decrement()
      else:
        quit "whar? " & op

when isMainModule:
  main()
