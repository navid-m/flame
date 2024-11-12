import
  notes,
  std /
  [
    strutils,
    tables
  ]

type SequenceItem* = ref object of RootRef

type DelayBlock* = ref object of SequenceItem
  amount*: uint32

type NoteBlock* = ref object of SequenceItem
  note*: Note
  octave*: int

proc addAll*(items: seq[SequenceItem], toAdd: varargs[SequenceItem]): seq[SequenceItem] =
  result = items
  for addable in toAdd:
    result.add(addable)

let stringsToNotes: Table[string, Note] = {
  "A": Note.A,
  "B": Note.B,
  "C": Note.C,
  "D": Note.D,
  "E": Note.E,
  "F": Note.F,
  "G": Note.G
}.toTable

proc single*(noteName: string): NoteBlock =
  let
    noteToUse = noteName[0]
    octaveToUse = parseInt($noteName[1])
  return NoteBlock(note: stringsToNotes[$noteToUse], octave: octaveToUse)

proc wait*(duration: uint32): DelayBlock = DelayBlock(amount: duration)
