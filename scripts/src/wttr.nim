import std/[os, osproc, json, httpclient, strutils]

const NimblePkgVersion {.strdefine.} = ""

type
  ReportFormat* = enum
    rfTabular    ## full report
    rfPlain      ## <icon> <temp>
    rfPlainWind  ## <icon> <temp> <windspeed>
    rfNamePlain  ## <name> <icon> <temp>
    rfNamePlainWind ## <name> <icon> <temp> <windspeed>

proc toInt*(format: ReportFormat): int =
  case format
  of rfPlain:
    return 1
  of rfPlainWind:
    return 2
  of rfNamePlain:
    return 3
  of rfNamePlainWind:
    return 4
  of rfTabular:
    return int.high

proc wttr*(format: ReportFormat, location: string, url: string = "https://wttr.in", userAgent: string = "curl/8.2.1"): string =
  let 
    httpClient = newHttpClient(userAgent=userAgent)
    fmt = toInt format
  
  if fmt != int.high:
    return httpClient.getContent(url & '/' & location & "?format=" & $fmt)
  else:
    return httpClient.getContent(url & '/' & location)

proc waybar*(city: string) =
  assert paramCount() > 1
  var tooltip: string = wttr(rfNamePlainWind, city)
  tooltip.removeSuffix('\n')

  echo $(%* {
      "text": wttr(rfPlain, city).split('\n')[0],
      "tooltip": tooltip
    }
  )

when isMainModule: 
  assert paramCount() > 1
  let
    city = 2.paramStr()
  case paramStr(1):
    of "waybar":
      waybar(paramStr(2))
    of "notifs":
      discard execCmd(
        "notify-send " &
        "\"Weather in " & city & "\" " &
        '"' & wttr(rfTabular, city) & '"'
      )
