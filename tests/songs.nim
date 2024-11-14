import flame

var song: seq[SequenceItem]

song = song.addAll(
  single("E5"), wait(0.5),
  single("E5"), wait(0.5),
  single("E5"), wait(0.5),
  single("C5"), wait(0.5),
  single("E5"), wait(0.5),
  single("G5"), wait(1.0),

  wait(0.5),

  single("G4"), wait(1.0),
  single("C5"), wait(0.5),
  single("G4"), wait(0.5),
  single("E4"), wait(0.5),
  single("A4"), wait(0.5),
  single("B4"), wait(0.5),
  single("A#4"), wait(0.5),
  single("A4"), wait(0.5),

  single("G4"), wait(0.5),
  single("E5"), wait(0.5),
  single("G5"), wait(0.5),
  single("A5"), wait(1.0),
  single("F5"), wait(0.5),
  single("G5"), wait(0.5),

  wait(0.5),

  single("E5"), wait(0.5),
  single("C5"), wait(0.5),
  single("D5"), wait(0.5),
  single("B4"), wait(1.0)
)

play(song)
