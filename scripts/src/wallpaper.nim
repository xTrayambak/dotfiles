import std/[os, osproc, times, strutils, random]

const IMAGE_EXT = [
  ".jpg", ".png", ".jpeg"
]

proc getWallpaper: string {.inline.} =
  var 
    files: seq[string]
    morning, afternoon, evening, night: seq[string]

  for k, p in walkDir(getHomeDir() / "Wallpapers"):
    if k == pcFile and p.splitFile().ext in IMAGE_EXT:
      files.add(p)

  for f in files:
    if "night" in f:
      night.add(f)
      continue

    if "morning" in f:
      morning.add(f)
      continue

    if "afternoon" in f:
      afternoon.add(f)
      continue

    if "evening" in f:
      evening.add(f)
      continue
  
  let hour = now().hour()

  case hour
  of {1..5}, {19..24}:
    echo "Picking a night wallpaper."
    return sample night
  of {6..11}:
    echo "Picking a morning wallpaper."
    return sample morning
  of {12..15}:
    echo "Picking an afternoon wallpaper."
    return sample afternoon
  of {16..18}:
    echo "Picking an evening wallpaper."
    return sample evening

proc swww(wallpaper: string, step: int = 2) {.inline.} =
  discard execCmd(
    "swww img --transition-type random --transition-step " & $step & " --transition-fps 144 " & wallpaper
  )

proc main {.inline.} =
  randomize()

  while true:
    let wallpaper = getWallpaper()
    swww(wallpaper)
    sleep rand(30..60) * 60 * 60 # Sleep anywhere between 30 minutes to an hour 

when isMainModule:
  main()
