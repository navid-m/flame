# Package

version       = "0.1.0"
author        = "Navid M"
description   = "High level music or audio synthesis and sequencing library that wraps SDL2"
license       = "MIT"
srcDir        = "src"
bin           = @["flame"]


# Dependencies

requires "nim >= 2.2.0"

requires "sdl2 >= 2.0.5"