import playback

proc init*() =
  discard initAudio(1110.0)

when isMainModule:
  init()
  play()
