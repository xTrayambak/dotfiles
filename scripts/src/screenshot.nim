import std/[os, osproc, strutils, times]

proc getFilename: string {.inline.} =
  getHomeDir() / "Screenshots" / "ss-" & $now() & ".jpg"

proc main {.inline.} =
  discard existsOrCreateDir(getHomeDir() / "Screenshots")
  var 
    ssType: string
    silent: bool

  if paramCount() > 0:
    ssType = paramStr(1)
  else:
    quit "ssType?"

  if paramCount() > 1:
    case paramStr(2):
      of "true", "yes":
        silent = true
      else:
        silent = false
  else:
    silent = false

  let path = getFilename()
  if ssType == "full":
    if execCmd("grim " & path) != 0:
      if not silent:
        discard execCmd(
          "notify-send " &
          "\"Region Screenshot Cancelled\" "
        )
        quit(0)
    
    if not silent:
      discard execCmd(
        "notify-send " &
        "\"Screenshot Taken\" " &
        "\"Saved as " & path & " and saved to clipboard\" " &
        "--icon=" & path
      )
       
  elif ssType == "select":
    let dims = execCmdEx("slurp").output.split('\n')[0]
    sleep 240 # wait for the layer to disappear

    if execCmd(
      "grim -g " & 
      '"' & dims & '"' & 
      ' ' & '"' & path & '"'
    ) != 0:
      if not silent:
        discard execCmd(
          "notify-send " &
          "\"Region Screenshot Cancelled\" "
        )
        quit(0)

    if not silent:
      discard execCmd(
        "notify-send " &
        "\"Region Screenshot Taken\" " &
        "\"Saved as " & path & " and saved to clipboard\" " &
        "--icon=" & path
      )

  discard execCmd("wl-copy -t image/png < " & path)

when isMainModule: main()
