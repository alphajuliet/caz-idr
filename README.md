# caz-idr

An Idris2 port of the Clojure [caz](https://github.com/alphajuliet/caz) music theory library, providing utilities for working with chromatic music theory using ordinal numbers.

## Overview

Caz-idr represents notes as ordinals (integers 0-11 where C=0, C#=1, ..., B=11) and provides functions to work with notes, chords, and scales. The library implements enharmonic equality (C# = Db) and supports transposition operations.

## Quick Start

### Build

```bash
idris2 --build caz.ipkg
```

### REPL

```bash
# Load a module
idris2 --find-ipkg src/Notes.idr
idris2 --find-ipkg src/Chord.idr
idris2 --find-ipkg src/Scale.idr

# Try some examples
:exec printLn (chordToNotes (C, Maj7))
:exec printLn (scaleToNotes (D, Dorian))
```

## Features

- **Notes**: Natural, sharp, and flat note representations with enharmonic equality
- **Chords**: 37 chord types including triads, sevenths, extensions, and alterations
- **Scales**: 16 scale types including modes, pentatonics, blues, and exotic scales
- **Transposition**: Generic `Transposable` interface for shifting musical elements by semitones
- **Pitches**: Notes with octave information

## Core Concepts

- **Ordinals**: Semitone positions (0-11) with modular arithmetic
- **Enharmonic Equality**: C# and Db are treated as equal
- **Interval Lists**: Chords and scales defined as lists of semitone intervals from the root

## Documentation

See [CLAUDE.md](CLAUDE.md) for detailed architecture, module structure, design patterns, and implementation notes.

