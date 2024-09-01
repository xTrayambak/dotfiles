import std/[os, osproc, logging, strutils, net]
import colored_logger, logcore

proc notify*(msg, desc: string, urgencyInt: int = 0) {.inline.} =
  let urgency = case urgencyInt
  of 0: "low"
  of 1: "normal"
  of 2: "critical"
  else: "low"

  discard execCmd("notify-send \"" & msg & "\" \"" & desc & "\" --urgency=" & urgency)

proc setPowerSaving(socket: Socket) {.inline.} =
  info "tlp_cli: telling tlp_root to set mode to battery"
  socket.send("0")

  let resp = socket.recv(2)
  if resp != "ok":
    error "tlp_cli: failed to set mode to battery"
    notify("Failed to enable power saving mode", resp & socket.recv(16), 2)
    quit(1)
  else:
    notify("Enabled power saving mode", "Your computer will be slowed down.")

proc setPerformance(socket: Socket) {.inline.} =
  info "tlp_cli: telling tlp_root to set mode to performance"
  socket.send("1")
  
  let resp = socket.recv(2)
  if resp != "ok":
    let msg = resp & socket.recv(16)
    error "tlp_cli: failed to set mode to performance: " & msg
    notify("Failed to enable performance mode", msg, 2)
    quit(1)
  else:
    notify("Enabled performance mode", "Your computer will run at maximum performance.")

proc ringUpDaemon: Socket {.inline.} =
  let socket = newSocket(AF_INET, SOCK_STREAM)

  try:
    socket.connect("0.0.0.0", Port(65529))
  except OSError as exc:
    notify("Failed to connect to tlp_root daemon", exc.msg, 2)
    quit(1)

  socket

proc main {.inline.} =
  setupLogging("tlp_cli")
  assert paramCount() > 0

  case paramStr(1)
  of "power_saving":
    ringUpDaemon().setPowerSaving()
  of "perf":
    ringUpDaemon().setPerformance()
  else:
    quit "Invalid mode"

when isMainModule: main()
