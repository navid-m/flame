import
  sdl2,
  sdl2/audio,
  std/math,
  notes,
  sequences

const
  SampleRate = 44100
  Volume = 0.4
  BufferSizeInSamples = 4096

type
  ActiveNote = object
    frequency: float
    isPlaying: bool

var
  progress: int
  activeNotes: array[8, ActiveNote]
  beatDuration: float32 = 600.0

proc setBpm*(bpm: int) =
  ## Set BPM of the current playback
  beatDuration = 60000.0.float32 / bpm.float32

proc clearNotes*() =
  ## Clear all currently playing notes
  for i in 0 ..< activeNotes.len:
    activeNotes[i].isPlaying = false

proc addNote*(freq: float) =
  ## Add a note to be played simultaneously
  for i in 0 ..< activeNotes.len:
    if not activeNotes[i].isPlaying:
      activeNotes[i].frequency = freq
      activeNotes[i].isPlaying = true
      return

proc setCurrentNote*(note: MidiNote) =
  ## Set a single note (clears other notes first)
  clearNotes()
  addNote(frequency(note))

proc generateSineAmplitude(freq: float): float32 =
  ## Generate a sine wave amplitude for a given frequency
  let cycleLength = float(SampleRate) / freq
  return float32(
    sin(float(progress mod int(cycleLength)) / cycleLength * 2.0 * PI) * Volume
  )

proc audioCallback(userdata: pointer; stream: ptr uint8; len: cint) {.cdecl.} =
  ## Audio callback to mix all active notes
  var floatStream = cast[ptr UncheckedArray[float32]](stream)
  let samples = len div sizeof(float32)

  for i in 0 ..< samples:
    var mixed = 0.0'f32
    var activeCount = 0

    for note in activeNotes:
      if note.isPlaying:
        mixed += generateSineAmplitude(note.frequency)
        inc activeCount

    if activeCount > 0:
      mixed = mixed / activeCount.float32

    floatStream[i] = mixed
    inc(progress)

proc initAudio*(): bool =
  ## Initialize the audio output
  if sdl2.init(INIT_AUDIO) != SdlSuccess:
    echo("Couldn't initialize SDL audio:", $getError())
    return false

  var desired: AudioSpec
  var obtained: AudioSpec

  desired.freq = cint(SampleRate)
  desired.format = AUDIO_F32MSB
  desired.channels = 2
  desired.samples = uint16(BufferSizeInSamples)
  desired.callback = audioCallback
  desired.userdata = nil

  audio.closeAudio()

  if audio.openAudio(addr desired, addr obtained) < 0:
    echo("Couldn't open audio device:", $getError())
    return false

  audio.pauseAudio(0)
  return true

proc quitAudio() =
  ## Close audio output
  audio.closeAudio()
  sdl2.quit()

proc play*(sequence: seq[SequenceItem]) =
  ## Play the given sequence
  if not initAudio():
    return
  defer: quitAudio()

  for item in sequence:
    if item of DelayBlock:
      sdl2.delay(uint32(cast[DelayBlock](item).beats.float32 * beatDuration))

    elif item of SoundBlock:
      var asNote = cast[SoundBlock](item)
      if asNote.isChord:
        clearNotes()
        for note in asNote.chordNotes:
          addNote(
            frequency(MidiNote(
              note: note.note,
              octave: note.octave
            ))
          )
      else:
        setCurrentNote(
          MidiNote(note: asNote.note, octave: asNote.octave)
        )
