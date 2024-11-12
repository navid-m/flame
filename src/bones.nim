import
  playback,
  sequence

export
  NoteBlock,
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
    wait(1000),
    single("D4"),
    wait(1000),
    single("C4"),
    wait(1000)
  )
  play(song)
