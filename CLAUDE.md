# CLAUDE.md

This file provides guidance to Claude Code when working with code in this repository.

## Project Overview

Caz-idr is an Idris2 port of the Clojure `caz` music theory library (`../caz`). It provides utilities for working with chromatic music theory using ordinal numbers (0-11 representing semitones). The Clojure source is the authoritative reference for behaviour.

## Commands

### Build

```bash
idris2 --build caz.ipkg
```

### REPL

```bash
# Load a specific module (resolves imports via package file)
idris2 --find-ipkg src/Notes.idr
idris2 --find-ipkg src/Chord.idr
idris2 --find-ipkg src/Scale.idr

# In the REPL, evaluate expressions with :exec
:exec printLn (chordToNotes (C, Maj7))
:exec printLn (scaleToNotes (D, Dorian))
:q
```

There is no automated test suite. Verify behaviour in the REPL.

## Architecture

### Core Concepts

**Ordinals**: `Int` values 0-11 representing semitone positions (C=0, C#/Db=1, ..., B=11). Operations use `mod12` to wrap. Ordinals outside 0-11 are valid in intermediate computation (e.g. ninth chord intervals use 14).

**Notes**: `Note` constructors — C D E F G A B for naturals, Cs Ds Fs Gs As for sharps, Db Eb Gb Ab Bb for flats. The `Eq Note` instance implements **enharmonic equality** (`Cs == Db = True`). This is intentional.

**Chords**: `Chord = (Note, ChordVar)` — root note paired with a chord type.

**Scales**: `Scale = (Note, ScaleVar)` — root note paired with a scale type.

**Pitches**: `Pitch = MkPitch Note Int` — a note at a specific octave.

### Module Structure

**`src/Notes.idr`** — foundation module:
- `Note`, `Pitch`, `eqNote`, `Eq Note`, `Show Note`
- `mod12`, `allNotes`, `basicNotes`
- `noteToNum : Note -> Maybe Int`, `numToNote : Int -> Note`, `numToNote' : Note -> Int -> Note`
- `Transposable` interface with `tr : Int -> a -> a`
- Instances: `Transposable Int` (unbounded addition), `Transposable Note` (via ordinal), `Transposable (Note, b)` (root only)
- `trMod : Int -> Int -> Int`, `inv : Int -> Note -> Note`
- `inversions : List Int -> List (List Int)`, `canonical : List Int -> List Int`

**`src/Chord.idr`** — chord operations:
- `ChordVar` — 37 chord types
- `chordIntervals : ChordVar -> List Int`
- `Chord : Type = (Note, ChordVar)`
- `chordToNums`, `numsToChord`, `chordToNotes`
- `containsNote`, `chordContainsNote`
- `allChordVars`, `myChords` (curated 13-type subset)

**`src/Scale.idr`** — scale operations:
- `ScaleVar` — 16 scale types (modes, pentatonics, blues, exotic)
- `scaleIntervals : ScaleVar -> List Int`
- `Scale : Type = (Note, ScaleVar)`
- `scaleToNums`, `scaleToNotes`

### Key Design Patterns

1. **`public export` vs `export`**: Use `public export` for `data` types and interfaces (so importers can pattern-match and implement instances). Use `export` for functions and interface instances.

2. **Enharmonic `Eq Note`**: `(==)` on `Note` is enharmonic equality. Do not use `elem` or `find` with a `[Db, Eb, ...]` list to detect flat notes — use the `isFlatRef` pattern-match helper instead, which uses structural equality.

3. **Transposable interface**: `tr n x` shifts `x` up by `n` semitones. Defined for `Int` (unbounded), `Note` (via ordinal), and `(Note, b)` pairs (root only — `b` is always passed through unchanged). `ChordVar` and `ScaleVar` have identity instances (`tr _ var = var`) so that `tr n : Chord -> Chord` works correctly.

4. **Flat/sharp spelling**: `numToNote` always returns sharp spelling. `numToNote'` takes a reference note and uses flat spelling when the reference is a flat note (Db/Eb/Gb/Ab/Bb). Scale and chord functions use `numToNote` by default; `scaleToNotes` uses `numToNote'` for contextual spelling.

5. **`numsToChord` limitation**: Intervals are mod-12'd before matching, so ninth chords (with interval 14) do not round-trip through `numsToChord`. This matches the Clojure source behaviour.

### Known Quirks (inherited from Clojure source)

- `X4p5` and `Sus4` share identical intervals `[0, 5, 7]`. `numsToChord` always returns `X4p5` for that interval set.
- `Minor` scale (`[0,2,3,5,7,8,11]`) is harmonic minor, not natural minor. Natural minor is `Aeolian`.
- `MinorPentatonic = [0,3,4,7,10]` — this is the value from the Clojure source and is faithfully replicated here, even though it differs from the standard music theory definition (`[0,3,5,7,10]`).
