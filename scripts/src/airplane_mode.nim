import std/[os, osproc, json]
import ./logcore

proc notify(title, msg: string, urgencyVal: int = 1) {.inline.} =
  let urgency =
    case urgencyVal
    of 0: "low"
    of 1: "normal"
    of 2: "critical"
    else: ""

  assert execCmd("notify-send \"" & title & "\" \"" & msg & "\" --urgency=" & urgency & " --expire-time=3600") == 0

proc enableAirplaneMode {.inline.} =
  discard execCmd("nmcli radio all off")
  notify("Network", "Enabled Airplane Mode")

proc disableAirplaneMode {.inline.} =
  discard execCmd("nmcli radio all on")
  notify("Network", "Disabled Airplane Mode")

proc radiosEnabled: bool {.inline.} =
  execCmdEx("nmcli radio wifi").output == "enabled" and
  execCmdEx("bluetoothctl show | grep \"Powered\" | awk '{print $2}'").output == "yes"

proc toggleAirplaneMode {.inline.} =
  if radiosEnabled(): 
    enableAirplaneMode()
  else:
    disableAirplaneMode()

proc main {.inline.} =
  setupLogging "airplane_mode" 
  
  assert paramCount() > 0

  case paramStr(1)
  of "enable":
    enableAirplaneMode()
  of "disable":
    disableAirplaneMode()
  of "toggle":
    toggleAirplaneMode()
  of "waybar":
    if not radiosEnabled():
      echo $(
        %* {
          "text": "",
          "tooltip": "Airplane Mode Disabled"
        }
      )
    else:
      echo $(
        %* {
          "text": ":3",
          "tooltip": "Airplane Mode Disabled"
        }
      )

when isMainModule: main()
