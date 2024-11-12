import playback, sequence, notes

when isMainModule:
  discard initAudio()
  var song: seq[SequenceItem]
  song.add(NoteBlock(note: Note.A, octave: 4))
  song.add(DelayBlock(amount: 1000))
  song.add(NoteBlock(note: Note.D, octave: 4))
  song.add(DelayBlock(amount: 1000))
  song.add(NoteBlock(note: Note.C, octave: 4))
  song.add(DelayBlock(amount: 1000))
  playSequence(song)

