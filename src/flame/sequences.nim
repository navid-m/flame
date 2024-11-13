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

  ChordNote* = object
    note*: Note
    octave*: int

  SoundBlock* = ref object of SequenceItem
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
  "A#": Note.As,
  "C#": Note.Cs,
  "D#": Note.Ds,
  "G#": Note.Gs,
  "F#": Note.Fs,
}.toTable

proc addAll*(items: seq[SequenceItem], toAdd: varargs[SequenceItem]): seq[SequenceItem] =
  ## Add all of the given sequence items to the sequence
  result = items
  for addable in toAdd:
    result.add(addable)

func getOctaveIndex(note: string): int =
  ## Internally retrieve octave index
  if $"#" in note:
    return 2
  return 1

func getNtuseRoot(note: string): string =
  ## Internally retrieve note root name
  if $"#" in note:
    return note[0..1]
  return $note[0]

proc single*(noteName: string): SoundBlock =
  ## Get back some note item
  let
    noteToUse = getNtuseRoot($noteName[0 .. ^2])
    octaveToUse = parseInt($noteName[getOctaveIndex(noteName)])
  return SoundBlock(
    note: stringsToNotes[$noteToUse],
    octave: octaveToUse,
    isChord: false
  )

proc chord*(noteNames: varargs[string]): SoundBlock =
  ## Create a chord from multiple notes
  var chordNotes: seq[ChordNote]
  for noteName in noteNames:
    let
      noteToUse = getNtuseRoot($noteName[0 .. ^2])
      octaveToUse = parseInt($noteName[getOctaveIndex(noteName)])
    chordNotes.add(ChordNote(
      note: stringsToNotes[$noteToUse],
      octave: octaveToUse
    ))

  let firstNote = noteNames[0]
  result = SoundBlock(
    note: stringsToNotes[$firstNote[0]],
    octave: parseInt($firstNote[getOctaveIndex(firstNote)]),
    isChord: true,
    chordNotes: chordNotes
  )

proc wait*(beats: float32): DelayBlock =
  ## Get back some delay item
  DelayBlock(beats: beats)
