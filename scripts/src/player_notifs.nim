import std/[os, osproc, strutils, json]
import ./logcore

proc playerctl: string {.inline.} =
  execCmdEx("playerctl -a metadata --format '{\"song\": \"{{markup_escape(title)}}\", \"artist\": \"{{artist}}\", \"player_name\": \"{{playerName}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}'").output

proc getIcon: string {.inline.} =
  let output = 
    execCmdEx("playerctl metadata").output

  debug "playerctl metadata: " & output
  let artUrl = output
    .splitLines()[4]

  debug "artUrl: " & artUrl 

  let iconUrl = try:
    artUrl.split("file://")[1]
  except IndexDefect as exc:
    info "Failed to split \"" & artUrl & "\" by `file://`: " & exc.msg
    ""

  iconUrl

proc notify(data: JsonNode, icon: string) {.inline.} =
  if icon.len > 0 and not fileExists(icon):
    raise newException(Defect, "No such file or directory for art icon: " & icon)

  let 
    name = data["song"].getStr("Song key not defined")
    artist = data["artist"].getStr("Artist key not defined")
  
  discard execCmd(
    "notify-send \"" & name & "\" \"" & artist & "\"" & (if icon.len > 0: " --icon=" & icon else: "")
  )

proc main {.inline.} =
  var prev: JsonNode
  setupLogging "player_notifs"

  while true:
    info "Polling player results..."
    let output = playerctl()
    
    if output == "No players found":
      info "No player is registered as of right now."
      sleep 30
      continue

    let data = parseJson(output)

    if prev != data:
      info "Playing player has changed state. Sending notification."
      prev = deepCopy(data)
      notify(data, getIcon())
    
    sleep 15

when isMainModule:
  main()
