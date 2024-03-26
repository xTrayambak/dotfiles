import std/[os, osproc, json]

proc playerctl: string {.inline.} =
  execCmdEx("playerctl -a metadata --format '{\"song\": \"{{markup_escape(title)}}\", \"artist\": \"{{artist}}\", \"player_name\": \"{{playerName}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}'").output

proc notify(data: JsonNode) {.inline.} =
  let 
    name = data["song"].getStr("Song key not defined")
    artist = data["artist"].getStr("Artist key not defined")
  
  discard execCmd(
    "notify-send \"" & name & "\" \"" & artist & "\""
  )

proc main {.inline.} =
  var prev: JsonNode
  while true:
    let output = playerctl()
    
    if output == "No players found":
      continue

    let data = parseJson(output)

    if prev != data:
      prev = deepCopy(data)
      notify(data)
    
    sleep 130

when isMainModule:
  main()
