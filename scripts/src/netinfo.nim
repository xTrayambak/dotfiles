import std/[osproc, strutils]

proc isWiredConnected: bool {.inline.} =
  "ethernet:connected" in execCmdEx("nmcli -t -f TYPE,STATE dev | grep -E '^ethernet:connected$'").output

proc isWifiConnected: bool {.inline.} =
  "wifi:connected" in execCmdEx("nmcli -t -f TYPE,STATE dev | grep -E '^wifi:connected$'").output

proc main* {.inline.} =
  if isWifiConnected():
    echo "󰤨  "
    quit 0

  if isWiredConnected():
    echo "󰈁 "
    quit 0

when isMainModule:
  main()
