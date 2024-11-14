import
  std/math

type
  Note* = enum
    C, Cs, D, Ds, E, F, Fs, G, Gs, A, As, B

  MidiNote* = object
    note*: Note
    octave*: int

const
  baseFrequency* = 440.0

proc getNoteFrequency(note: Note): float =
  ## Get corresponding base frequency given some note
  case note
    of Note.C: 261.63
    of Note.Cs: 277.18
    of Note.D: 293.66
    of Note.Ds: 311.13
    of Note.E: 329.63
    of Note.F: 349.23
    of Note.Fs: 369.99
    of Note.G: 392.00
    of Note.Gs: 415.30
    of Note.A: 440.00
    of Note.As: 466.16
    of Note.B: 493.88

proc frequency*(note: MidiNote): float =
  ## Calculate frequency for a given note and octave
  return getNoteFrequency(note.note) * (2.0 ^ (note.octave - 4))
