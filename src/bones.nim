import
  playback,
  sequence,
  notes

export
  NoteBlock,
  DelayBlock,
  SequenceItem,
  addAll,
  play

when isMainModule:
  var song: seq[SequenceItem]
  song = song.addAll(
    NoteBlock(note: Note.A, octave: 4),
    DelayBlock(amount: 1000),
    NoteBlock(note: Note.D, octave: 4),
    DelayBlock(amount: 1000),
    NoteBlock(note: Note.C, octave: 4),
    DelayBlock(amount: 1000)
  )
  play(song)

