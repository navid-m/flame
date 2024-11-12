import notes

type SequenceItem* = ref object of RootRef

type DelayBlock* = ref object of SequenceItem
  amount*: uint32

type NoteBlock* = ref object of SequenceItem
  note*: Note
  octave*: int
