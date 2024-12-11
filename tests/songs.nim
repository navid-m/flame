import flame

var song: seq[SequenceItem]

song = song.addAll(
  chord("E4", "D4", "A4"),
  wait(10),
  single("D4"),
  wait(2)
)

play(song)
