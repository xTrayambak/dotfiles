import std/[logging, osproc, strutils]

type
  PlayerStatus* = object
    playing*: bool
    album*: string
    artist*: string
    title*: string
    source*: string

    artPath*: string
    length*: tuple[minutes, seconds: uint64]

proc output(cmd: string): string {.inline.} =
  execCmdEx(cmd).output.strip(chars = {'\n'})

proc getPlayerStatus*: PlayerStatus =
  var status: PlayerStatus
  status.playing = (output "playerctl metadata mpris:artUrl") != "No players found"
  status.album = output "playerctl metadata xesam:album"
  status.artist = output "playerctl metadata xesam:artist"
  status.artist.removeSuffix(" - Topic")
  status.artist.removeSuffix("Official")
  status.title = output "playerctl metadata xesam:title"
  status.artPath = output "playerctl metadata mpris:artUrl"

  let source = output "playerctl metadata mpris:trackid"

  if "firefox" in source:
    status.source = "Firefox 󰈹"
  elif "chromium" in source:
    status.source = "Chromium "
  elif "spotify" in source:
    status.source = "Spotify "

  let lengthSecs = parseInt(output "playerctl metadata mpris:length") / 1000000
  let mins = uint(lengthSecs / 60)
  let secs = uint(lengthSecs.int mod 60)

  status.length.minutes = mins
  status.length.seconds = secs

  status
