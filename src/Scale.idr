module Scale

import Notes

public export
data ScaleVar
  = Major | Dorian | Phrygian | Lydian | Mixolydian | Aeolian | Locrian
  | Minor | HarmonicMajor | Blues | Chromatic
  | MajorPentatonic | MinorPentatonic
  | NeapolitanMajor | NeapolitanMinor | Tritone

export
Eq ScaleVar where
  Major            == Major            = True
  Dorian           == Dorian           = True
  Phrygian         == Phrygian         = True
  Lydian           == Lydian           = True
  Mixolydian       == Mixolydian       = True
  Aeolian          == Aeolian          = True
  Locrian          == Locrian          = True
  Minor            == Minor            = True
  HarmonicMajor    == HarmonicMajor    = True
  Blues            == Blues            = True
  Chromatic        == Chromatic        = True
  MajorPentatonic  == MajorPentatonic  = True
  MinorPentatonic  == MinorPentatonic  = True
  NeapolitanMajor  == NeapolitanMajor  = True
  NeapolitanMinor  == NeapolitanMinor  = True
  Tritone          == Tritone          = True
  _                == _                = False

export
Show ScaleVar where
  show Major           = "major"
  show Dorian          = "dorian"
  show Phrygian        = "phrygian"
  show Lydian          = "lydian"
  show Mixolydian      = "mixolydian"
  show Aeolian         = "aeolian"
  show Locrian         = "locrian"
  show Minor           = "minor"
  show HarmonicMajor   = "harmonic-major"
  show Blues           = "blues"
  show Chromatic       = "chromatic"
  show MajorPentatonic = "major-pentatonic"
  show MinorPentatonic = "minor-pentatonic"
  show NeapolitanMajor = "neapolitan-major"
  show NeapolitanMinor = "neapolitan-minor"
  show Tritone         = "tritone"

-- ScaleVar is unchanged by transposition
export
Transposable ScaleVar where
  tr _ var = var

-- Semitone intervals relative to root
export
scaleIntervals : ScaleVar -> List Int
scaleIntervals Major           = [0, 2, 4, 5, 7, 9, 11]
scaleIntervals Dorian          = [0, 2, 3, 5, 7, 9, 10]
scaleIntervals Phrygian        = [0, 1, 3, 5, 7, 8, 10]
scaleIntervals Lydian          = [0, 2, 4, 6, 7, 9, 11]
scaleIntervals Mixolydian      = [0, 2, 4, 5, 7, 9, 10]
scaleIntervals Aeolian         = [0, 2, 3, 5, 7, 8, 10]
scaleIntervals Locrian         = [0, 1, 3, 5, 6, 8, 10]
scaleIntervals Minor           = [0, 2, 3, 5, 7, 8, 11]
scaleIntervals HarmonicMajor   = [0, 2, 4, 5, 7, 8, 11]
scaleIntervals Blues           = [0, 3, 5, 6, 7, 10]
scaleIntervals Chromatic       = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
scaleIntervals MajorPentatonic = [0, 2, 4, 7, 9]
scaleIntervals MinorPentatonic = [0, 3, 4, 7, 10]
scaleIntervals NeapolitanMajor = [0, 1, 3, 5, 7, 9, 11]
scaleIntervals NeapolitanMinor = [0, 1, 3, 5, 7, 8, 11]
scaleIntervals Tritone         = [0, 1, 4, 6, 7, 10]

-- Scale is a (root note, scale type) pair
public export
Scale : Type
Scale = (Note, ScaleVar)

-- Scale -> absolute ordinals
export
scaleToNums : Scale -> List Int
scaleToNums (root, var) =
  case noteToNum root of
    Just rootNum => map (tr rootNum) (scaleIntervals var)
    Nothing      => []

-- Scale -> note names; flat/sharp spelling follows the root note
-- e.g. scaleToNotes (D, Dorian) = [D, E, F, G, A, B, C]
export
scaleToNotes : Scale -> List Note
scaleToNotes scale@(root, _) = map (numToNote' root) (scaleToNums scale)

-- The End
