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
  noteFrequencies: array[12, float] = [
    261.63, # C
    277.18, # Cs
    293.66, # D
    311.13, # Ds
    329.63, # E
    349.23, # F
    369.99, # Fs
    392.00, # G
    415.30, # Gs
    440.00, # A
    466.16, # As
    493.88  # B
  ]

proc frequency*(note: MidiNote): float =
  ## Calculate frequency for a given note and octave
  let
    noteIndex = ord(note.note)
    octaveDiff = note.octave - 4
  return noteFrequencies[noteIndex] * (2.0 ^ octaveDiff)
