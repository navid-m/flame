import
  notes,
  std/[strutils, tables]

type
  SequenceItem* = ref object of RootRef

  DelayBlock* = ref object of SequenceItem
    beats*: float32

  ChordNote* = object
    note*: Note
    octave*: int

  NoteBlock* = ref object of SequenceItem
    note*: Note
    octave*: int
    isChord*: bool
    chordNotes*: seq[ChordNote]

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
  return NoteBlock(
    note: stringsToNotes[$noteToUse],
    octave: octaveToUse,
    isChord: false
  )

proc chord*(noteNames: varargs[string]): NoteBlock =
  ## Create a chord from multiple notes
  var chordNotes: seq[ChordNote]
  for noteName in noteNames:
    let
      noteToUse = noteName[0]
      octaveToUse = parseInt($noteName[1])
    chordNotes.add(ChordNote(
      note: stringsToNotes[$noteToUse],
      octave: octaveToUse
    ))

  # Use first note as the main note
  let firstNote = noteNames[0]
  result = NoteBlock(
    note: stringsToNotes[$firstNote[0]],
    octave: parseInt($firstNote[1]),
    isChord: true,
    chordNotes: chordNotes
  )

proc wait*(beats: float32): DelayBlock =
  ## Get back some delay item
  DelayBlock(beats: beats)
