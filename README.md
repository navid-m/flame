# Flame

High-level music and audio sequencing library for Nim.

## Features

-  Define audio sequences using blocks and items.
-  Support for delays, single notes, and chords.
-  Play and manage audio sequences easily.

## Usage example

```nim
import flame

var song: seq[SequenceItem]

song = song.addAll(
  chord("E4", "D4", "A4"),
  wait(10),
  single("D4"),
  wait(2)
)

play(song)
```
