import flame

var song: seq[SequenceItem]

song = song.addAll(
  chord("C4", "D5"),
  wait(1),
  chord("C#4", "D#5"),
  wait(1),
)

play(song)
