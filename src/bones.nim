import
  playback,
  sequence

export
  SoundBlock,
  DelayBlock,
  SequenceItem,
  addAll,
  single,
  wait,
  play

when isMainModule:
  var song: seq[SequenceItem]
  song = song.addAll(
    single("A4"),
    wait(1),
    chord("D4", "A4"),
    wait(1),
    chord("C4", "D5"),
    wait(1)
  )
  play(song)
