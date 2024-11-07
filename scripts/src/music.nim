import std/[os, strutils]
import ./player_common

proc main {.inline.} =
  assert paramCount() > 0
  case paramStr(1)
  of "album-cover":
    getPlayerStatus()
      .artPath
      .split("file://")[1]
      .echo()
  of "source":
    getPlayerStatus()
      .source
      .echo()
  of "song-name":
    getPlayerStatus()
      .title
      .echo()
  of "artist-name":
    getPlayerStatus()
      .artist
      .echo()
  of "length":
    let status = getPlayerStatus()
    echo "$1:$2" % [if status.length.minutes < 10: '0' & $status.length.minutes else: $status.length.minutes, if status.length.seconds < 10: '0' & $status.length.seconds else: $status.length.seconds]
  of "album-name":
    getPlayerStatus()
      .album
      .echo()
  of "playing":
    getPlayerStatus()
      .playing
      .echo()
  else:
    quit "invalid command"

when isMainModule: main()
