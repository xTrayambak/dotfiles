import std/[os, osproc, logging, strutils, net]
import colored_logger, tray

proc setPowerSaving(socket: Socket) {.inline.} =
  info "tlp_tray: telling tlp_root to set mode to battery"
  socket.send("0")

proc setPerformance(socket: Socket) {.inline.} =
  info "tlp_tray: telling tlp_root to set mode to performance"
  socket.send("1")

proc ringUpDaemon: Socket {.inline.} =
  let socket = newSocket(AF_INET, SOCK_STREAM)

  try:
    socket.connect("0.0.0.0", Port(65529))
  except OSError as exc:
    discard execCmd("notify-send --expire-time=99999 \"Failed to initialize performance profiles tray icon\" \"" & exc.msg & '"')
    quit(1)

  socket

proc main {.inline.} =
  addHandler newColoredLogger()
  
  var tray = newTrayIcon(
    "idea.png"
  )

  tray &=
    trayMenu(
      "Performance",
      proc(item: TrayMenu) =
        ringUpDaemon().setPerformance()
    )

  tray &=
    trayMenu(
      "Battery",
      proc(item: TrayMenu) =
        ringUpDaemon().setPowerSaving()
    )
  
  tray.run()

  while tray.update():
    discard

#[
import tray/lowlevel

var tray: tray
tray.icon = "./idea.png"
var menu = tray_menu(
  text: "Menu 1"
)
tray.menu = addr menu

proc main {.inline.} =
  if tray_init(addr tray) < 0:
    quit "failed to create tray"

  while tray_loop(1) == 0:
    echo "iteration"
]#

when isMainModule: main()
