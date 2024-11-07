import std/[osproc]
import jsony

type
  Notification* = object

  NotificationHistory* = object
    `type`*: string
    data*: seq[Notification]
