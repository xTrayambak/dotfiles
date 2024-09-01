import std/[os, osproc, options, json, times, httpclient, strutils]

{.passL: "-lcrypto -lssl".}

const NimblePkgVersion {.strdefine.} = ""

type
  ReportFormat* = enum
    rfTabular = 0    ## full report
    rfPlain = 1     ## <icon> <temp>
    rfPlainWind = 2  ## <icon> <temp> <windspeed>
    rfNamePlain = 3  ## <name> <icon> <temp>
    rfNamePlainWind = 4 ## <name> <icon> <temp> <windspeed>

proc getCache*: Option[JsonNode] =
  if fileExists("/tmp/wttr-cache.json"):
    return readFile("/tmp/wttr-cache.json").parseJson().some()

proc setCache*(data: string, format: string) =
  echo "> cache \"" & format & "\": " & data
  let preExisting = getCache()
  let jsonData = if preExisting.isSome: preExisting.unsafeGet() else: %* {
    "date": epochTime()
  }
  
  jsonData["date"] = newJFloat(epochTime())
  jsonData[format] = newJString(data)
  
  var final: string
  toUgly(final, jsonData)

  writeFile("/tmp/wttr-cache.json", final)

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

proc nerdify*(s: string): string {.inline.} =
  s.multiReplace(
    {
      "🌫": "󰖑",
      "🌦": "",
      "☀️": "󰖨",
      "🌤": "",
      "☁️": "",
      "🌩": "",
      "⚡": "",
      "☔": "",
      "🌈": "",
      "💨": "",
      "🌡️": "󱃂",
      "🌬️": " "
    }
  )

proc wttr*(format: ReportFormat, location: string, url: string = "https://wttr.in", userAgent: string = "curl/8.2.1", ignoreCache: bool = false): string =
  let 
    httpClient = newHttpClient(userAgent=userAgent)
    fmt = toInt format
    cached = getCache()

  if cached.isSome and not ignoreCache:
    if $fmt in cached.unsafeGet():
      let delta = epochTime() - cached.unsafeGet()["date"].getFloat()
      if delta <= 3600f: # 1 hour
        return cached.unsafeGet()[$fmt].getStr()
  
  if fmt != int.high:
    result = httpClient.getContent(url & '/' & location & "?format=" & $fmt)
  else:
    result = httpClient.getContent(url & '/' & location)
  
  setCache(result, $fmt)

proc waybar*(city: string) =
  var tooltip: string = wttr(rfNamePlainWind, city)
  tooltip.removeSuffix('\n')

  echo $(%* {
      "text": wttr(rfPlain, city).split('\n')[0].nerdify(),
      "tooltip": tooltip.nerdify()
    }
  )

proc hyprlock*(city: string) =
  echo wttr(rfPlain, city).split('\n')[0].nerdify()

proc refresh*(city: string) =
  let shout = paramCount() > 2
  if shout:
    discard execCmd("notify-send -t 30000 \"Refreshing weather data for " & city & "\" \"This may take a minute.\"")

  for field in 0 .. 4:
    echo "> refresh " & $field
    echo wttr(ReportFormat(field), city, ignoreCache = true)

  discard execCmd("notify-send -t 60000 \"Weather in " & city & "\" \"" & wttr(rfNamePlainWind, city).nerdify() & '"')

proc notify*(city: string) {.inline.} =
  discard execCmd("notify-send -t 60000 \"Weather in " & city & "\" \"" & wttr(rfNamePlainWind, city).nerdify() & '"')

when isMainModule: 
  assert paramCount() > 1
  let city = paramStr(2)

  case paramStr(1):
    of "waybar":
      waybar(city)
    of "lock_screen":
      hyprlock(city)
    of "refresh":
      refresh(city)
    of "notify":
      notify(city)
    else:
      quit "Unrecognized operation: " & paramStr(1)
