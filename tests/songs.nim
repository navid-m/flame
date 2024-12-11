import flame

var song: seq[SequenceItem]

song = song.addAll(
  chord("E4", "D4", "A4"),
  wait(10),
  chord("E4", "D4", "A4"),
  wait(10)
)

play(song)
