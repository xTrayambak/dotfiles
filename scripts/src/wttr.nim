import std/[os, osproc, options, json, times, httpclient, strutils]

const NimblePkgVersion {.strdefine.} = ""

type
  ReportFormat* = enum
    rfTabular    ## full report
    rfPlain      ## <icon> <temp>
    rfPlainWind  ## <icon> <temp> <windspeed>
    rfNamePlain  ## <name> <icon> <temp>
    rfNamePlainWind ## <name> <icon> <temp> <windspeed>

proc getCache*: Option[JsonNode] =
  if fileExists("/tmp/wttr-cache.json"):
    return readFile("/tmp/wttr-cache.json").parseJson().some()

proc setCache*(data: string, format: string, write: bool = true) =
  echo "Saving cache: [" & format & "]: " & data
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

proc wttr*(format: ReportFormat, location: string, url: string = "https://wttr.in", userAgent: string = "curl/8.2.1"): string =
  let 
    httpClient = newHttpClient(userAgent=userAgent)
    fmt = toInt format
    cached = getCache()

  if cached.isSome:
    if $fmt in cached.unsafeGet():
      let delta = epochTime() - cached.unsafeGet()["date"].getFloat()
      echo "Seconds since last wttr API call: " & $delta
      if delta <= 3600f:
        echo "Using cached data: " & $fmt
        return cached.unsafeGet()[$fmt].getStr()
      else:
        echo "Cache is outdated (more than an hour old); fetching wttr"
    else:
      echo "Cache does not contain data we need; fetching wttr"
  else:
    echo "Cache doesn't exist (most likely we just booted, or the cache was manually removed); fetching wttr"
  
  if fmt != int.high:
    result = httpClient.getContent(url & '/' & location & "?format=" & $fmt)
  else:
    result = httpClient.getContent(url & '/' & location)

  setCache(result, $fmt)

proc waybar*(city: string) =
  var tooltip: string = wttr(rfNamePlainWind, city)
  tooltip.removeSuffix('\n')

  echo $(%* {
      "text": wttr(rfPlain, city).split('\n')[0],
      "tooltip": tooltip
    }
  )

proc hyprlock*(city: string) =
  echo wttr(rfPlain, city).split('\n')[0]

when isMainModule: 
  assert paramCount() > 1
  let city = paramStr(2)

  case paramStr(1):
    of "waybar":
      waybar(city)
    of "lock_screen":
      hyprlock(city)
    else: discard
