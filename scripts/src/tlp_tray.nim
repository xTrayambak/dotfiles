import std/[os, osproc, logging]
import libtray, colored_logger

proc windowCb(_: ptr Tray) {.cdecl.} =
  info "Create new window, if it exists (guh it doesn't)"

proc main {.inline.} =
  addHandler newColoredLogger()

  let tray = initTray(
    iconFilepath = "",
    tooltip = "Power Settings",
    cb = windowCb,
    menus = [
      initTrayMenuItem(text = "Performance"),
      initTrayMenuItem(text = "Power Saving")
    ]
  )

  if trayInit(addr tray) != 0:
    fatal "Cannot initialize tray using libtray."

  while trayLoop(1) == 0:
    discard
