import
  notes,
  std /
  [
    strutils,
    tables
  ]

type
  SequenceItem* = ref object of RootRef

  DelayBlock* = ref object of SequenceItem
    beats*: float32

  NoteBlock* = ref object of SequenceItem
    note*: Note
    octave*: int

let stringsToNotes: Table[string, Note] = {
  "A": Note.A,
  "B": Note.B,
  "C": Note.C,
  "D": Note.D,
  "E": Note.E,
  "F": Note.F,
  "G": Note.G,
  "G#": Note.Gs,
  "F#": Note.Fs,
  "A#": Note.As,
}.toTable

proc addAll*(items: seq[SequenceItem], toAdd: varargs[SequenceItem]): seq[SequenceItem] =
  ## Add all of the given sequence items to the sequence
  result = items
  for addable in toAdd:
    result.add(addable)

proc single*(noteName: string): NoteBlock =
  ## Get back some note item
  let
    noteToUse = noteName[0]
    octaveToUse = parseInt($noteName[1])
  return NoteBlock(note: stringsToNotes[$noteToUse], octave: octaveToUse)

proc wait*(beats: float32): DelayBlock =
  ## Get back some delay item
  DelayBlock(beats: beats)
