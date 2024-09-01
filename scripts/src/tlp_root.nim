import std/[osproc, posix, strutils, logging, net]
import colored_logger

proc setPowerSaving: bool {.inline.} =
  info "tlp_root: set performance mode to power saving (battery)"
  let retval = execCmd("tlp bat")

  if retval != 0:
    error "tlp_root: failed to set performance mode to battery; exit code: " & $retval
    false
  else:
    true

proc setPerformance: bool {.inline.} =
  info "tlp_root: set performance mode to performance (AC)"
  let retval = execCmd("tlp ac")

  if retval != 0:
    error "tlp_root: failed to set performance mode to AC; exit code: " & $retval
    false
  else:
    true

proc main {.inline.} =
  addHandler newColoredLogger()
  
  let uid = geteuid()
  info "tlp_root: starting with uid: " & $uid & " and pid: " & $getpid()
  if uid != 0:
    error "tlp_root: must be run as root!"
    quit(1)
  
  info "tlp_root: initializing socket"
  let socket = newSocket(Domain.AF_INET, SockType.SOCK_STREAM)
  socket.setSockOpt(OptReusePort, true)
  socket.bindAddr(Port(65529))
  socket.listen(1)

  while true:
    var client: Socket
    socket.accept(client)

    info "tlp_root: got connection"
    let buffer = client.recv(1)

    try:
      case buffer.parseUint()
      of 0:
        case setPowerSaving()
        of true: client.send("ok\0")
        of false: client.send("An error occured whilst enabling power sharing mode. Check daemon logs for more details.\0")
      of 1:
        case setPerformance()
        of true: client.send("ok\0")
        of false: client.send("An error occured whilst enabling performance mode. Check daemon logs for more details.\0")
      else:
        client.send("Invalid performance mode.\0")
    except CatchableError as exc:
      error "tlp_root: whilst processing connection: " & exc.msg
      error "tlp_root: buffer: " & buffer.repr()
      client.send("Daemon error: " & exc.msg & '\0')

when isMainModule:
  main()
