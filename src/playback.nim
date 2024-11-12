import
  sdl2,
  sdl2/audio,
  math,
  notes,
  sequence

const
  SampleRate = 44100
  Volume = 0.4
  BufferSizeInSamples = 4096

var progress: int
var currentNote = 140.0

proc setCurrentNote*(note: MidiNote) =
  currentNote = frequency(note)

proc generateSineAmplitude(freq: float): float32 =
  ## Generate a sine wave amplitude for a given frequency
  let cycleLength = float(SampleRate) / freq
  result = float32(
    sin(float(progress mod int(cycleLength)) / cycleLength * 2.0 * PI) * Volume
  )
  inc(progress)

proc audioCallback(userdata: pointer; stream: ptr uint8; len: cint) {.cdecl.} =
  ## Audio callback to fill the stream buffer with wave data
  var floatStream = cast[ptr UncheckedArray[float32]](stream)
  let samples = len div sizeof(float32)
  for i in 0 ..< samples:
    floatStream[i] = generateSineAmplitude(currentNote)

proc initAudio*(): bool =
  ## Initialize the audio output
  if sdl2.init(INIT_AUDIO) != SdlSuccess:
    echo("Couldn't initialize SDL audio: ", $getError())
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
    echo("Couldn't opening audio device: ", $getError())
    return false

  audio.pauseAudio(0)

  return true

proc quitAudio() =
  ## Close audio output
  audio.closeAudio()
  sdl2.quit()

proc playSequence*(sequence: seq[SequenceItem]) =
  ## Play some given sequence
  if not initAudio():
    return
  defer: quitAudio()
  for item in sequence:
    if item of DelayBlock:
      sdl2.delay(cast[DelayBlock](item).amount)
    elif item of NoteBlock:
      var asNote = cast[NoteBlock](item)
      setCurrentNote(MidiNote(note: asNote.note, octave: asNote.octave))
