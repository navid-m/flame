import
  playback,
  sequences

export
  SoundBlock,
  DelayBlock,
  SequenceItem,
  addAll,
  single,
  chord,
  wait,
  play

when isMainModule:
  var song: seq[SequenceItem]
  song = song.addAll(
    chord("C#4", "D#5"),
    wait(1),
    chord("C4", "D5"),
    wait(1)
  )
  play(song)
