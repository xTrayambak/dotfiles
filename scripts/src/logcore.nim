import std/[os, logging]

proc setupLogging*(prog: string) {.inline.} =
  discard existsOrCreateDir(getCacheDir() / "rice_scripts")
  addHandler(
    newFileLogger(open(getCacheDir() / "rice_scripts" / prog & ".log", fmWrite))
  )

#   addHandler newColoredLogger()

export logging
