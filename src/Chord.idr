module Chord

import Notes
import Data.List

-- 40 chord types
public export
data ChordVar
  = Major | Minor | Dim   | Aug   | X4p5  | Maj4  | Sus4  | Min4
  | Maj6  | Min6  | Aug4  | X4p6  | B5    | MinS5
  | X7    | Maj7  | Aug7  | AugMaj7 | Min7 | MinMaj7 | Dim7 | DimMin7 | X7b5
  | X9    | Maj9  | Min9  | MinMaj9 | Add9 | MinAdd9
  | MajP2 | MinP2 | Mixed3 | Sus2p4 | Maj4p6 | Min4p6 | MinP6 | MinAug7

export
Eq ChordVar where
  Major   == Major   = True;  Minor   == Minor   = True
  Dim     == Dim     = True;  Aug     == Aug     = True
  X4p5    == X4p5    = True;  Maj4    == Maj4    = True
  Sus4    == Sus4    = True;  Min4    == Min4    = True
  Maj6    == Maj6    = True;  Min6    == Min6    = True
  Aug4    == Aug4    = True;  X4p6    == X4p6    = True
  B5      == B5      = True;  MinS5   == MinS5   = True
  X7      == X7      = True;  Maj7    == Maj7    = True
  Aug7    == Aug7    = True;  AugMaj7 == AugMaj7 = True
  Min7    == Min7    = True;  MinMaj7 == MinMaj7 = True
  Dim7    == Dim7    = True;  DimMin7 == DimMin7 = True
  X7b5    == X7b5    = True;  X9      == X9      = True
  Maj9    == Maj9    = True;  Min9    == Min9    = True
  MinMaj9 == MinMaj9 = True;  Add9    == Add9    = True
  MinAdd9 == MinAdd9 = True;  MajP2   == MajP2   = True
  MinP2   == MinP2   = True;  Mixed3  == Mixed3  = True
  Sus2p4  == Sus2p4  = True;  Maj4p6  == Maj4p6  = True
  Min4p6  == Min4p6  = True;  MinP6   == MinP6   = True
  MinAug7 == MinAug7 = True;  _       == _       = False

export
Show ChordVar where
  show Major   = "major";   show Minor   = "minor";   show Dim   = "dim"
  show Aug     = "aug";     show X4p5    = "x4+5";    show Maj4  = "maj4"
  show Sus4    = "sus4";    show Min4    = "min4";    show Maj6  = "maj6"
  show Min6    = "min6";    show Aug4    = "aug4";    show X4p6  = "x4+6"
  show B5      = "b5";      show MinS5   = "min#5";   show X7    = "x7"
  show Maj7    = "maj7";    show Aug7    = "aug7";    show AugMaj7 = "augmaj7"
  show Min7    = "min7";    show MinMaj7 = "minmaj7"; show Dim7  = "dim7"
  show DimMin7 = "dimmin7"; show X7b5   = "x7b5";    show X9    = "x9"
  show Maj9    = "maj9";    show Min9    = "min9";    show MinMaj9 = "minmaj9"
  show Add9    = "add9";    show MinAdd9 = "minadd9"; show MajP2  = "maj+2"
  show MinP2   = "min+2";   show Mixed3  = "mixed3";  show Sus2p4 = "sus2+4"
  show Maj4p6  = "maj4+6";  show Min4p6  = "min4+6";  show MinP6  = "min+6"
  show MinAug7 = "minaug7"

-- ChordVar is unchanged by transposition (only the root note moves)
export
Transposable ChordVar where
  tr _ var = var

-- Semitone intervals relative to root
export
chordIntervals : ChordVar -> List Int
chordIntervals Major   = [0, 4, 7]
chordIntervals Minor   = [0, 3, 7]
chordIntervals Dim     = [0, 3, 6]
chordIntervals Aug     = [0, 4, 8]
chordIntervals X4p5    = [0, 5, 7]
chordIntervals Maj4    = [0, 4, 5]
chordIntervals Sus4    = [0, 5, 7]
chordIntervals Min4    = [0, 3, 5]
chordIntervals Maj6    = [0, 4, 9]
chordIntervals Min6    = [0, 3, 9]
chordIntervals Aug4    = [0, 5, 8]
chordIntervals X4p6    = [0, 5, 9]
chordIntervals B5      = [0, 4, 6]
chordIntervals MinS5   = [0, 3, 8]
chordIntervals X7      = [0, 4, 7, 10]
chordIntervals Maj7    = [0, 4, 7, 11]
chordIntervals Aug7    = [0, 4, 8, 10]
chordIntervals AugMaj7 = [0, 4, 8, 11]
chordIntervals Min7    = [0, 3, 7, 10]
chordIntervals MinMaj7 = [0, 3, 7, 11]
chordIntervals Dim7    = [0, 3, 6, 9]
chordIntervals DimMin7 = [0, 3, 6, 10]
chordIntervals X7b5    = [0, 4, 6, 10]
chordIntervals X9      = [0, 4, 7, 10, 14]
chordIntervals Maj9    = [0, 4, 7, 11, 14]
chordIntervals Min9    = [0, 3, 7, 10, 14]
chordIntervals MinMaj9 = [0, 3, 7, 11, 14]
chordIntervals Add9    = [0, 4, 7, 14]
chordIntervals MinAdd9 = [0, 3, 7, 14]
chordIntervals MajP2   = [0, 2, 4, 7]
chordIntervals MinP2   = [0, 2, 3, 7]
chordIntervals Mixed3  = [0, 3, 4, 7]
chordIntervals Sus2p4  = [0, 2, 5, 7]
chordIntervals Maj4p6  = [0, 4, 5, 9]
chordIntervals Min4p6  = [0, 3, 5, 8]
chordIntervals MinP6   = [0, 3, 7, 9]
chordIntervals MinAug7 = [0, 3, 8, 11]

-- Chord is a (root note, chord type) pair
public export
Chord : Type
Chord = (Note, ChordVar)

-- All chord types in definition order
export
allChordVars : List ChordVar
allChordVars =
  [ Major, Minor, Dim, Aug, X4p5, Maj4, Sus4, Min4
  , Maj6, Min6, Aug4, X4p6, B5, MinS5
  , X7, Maj7, Aug7, AugMaj7, Min7, MinMaj7, Dim7, DimMin7, X7b5
  , X9, Maj9, Min9, MinMaj9, Add9, MinAdd9
  , MajP2, MinP2, Mixed3, Sus2p4, Maj4p6, Min4p6, MinP6, MinAug7 ]

-- Curated subset of commonly-used chord types
export
myChords : List ChordVar
myChords = [Major, Minor, Dim, Aug, Maj7, Min7, X7, Maj9, Min9, Add9, Sus4, Maj6, Min6]

-- Chord -> list of absolute ordinals
export
chordToNums : Chord -> List Int
chordToNums (root, var) =
  case noteToNum root of
    Just rootNum => map (rootNum +) (chordIntervals var)
    Nothing      => []

-- Ordinal list -> matching chord, if any.
-- Note: intervals > 11 (ninths) are mod-12'd before matching, so ninth
-- chords will not round-trip through numsToChord (matches Clojure behaviour).
export
numsToChord : List Int -> Maybe Chord
numsToChord [] = Nothing
numsToChord nums@(root :: _) =
  let intervals = map (\x => mod12 (x - root)) nums
      match     = find (\cv => chordIntervals cv == intervals) allChordVars
  in map (\cv => (numToNote root, cv)) match

-- Chord -> list of note names (sharp spelling)
export
chordToNotes : Chord -> List Note
chordToNotes = map numToNote . chordToNums

-- Does the chord contain the given note (enharmonic-aware via Eq Note)?
export
containsNote : Chord -> Note -> Bool
containsNote ch note = note `elem` chordToNotes ch

-- All chords from myChords x basicNotes that contain the given note
export
chordContainsNote : Note -> List Chord
chordContainsNote note =
  [ (root, cv) | root <- basicNotes, cv <- myChords
               , containsNote (root, cv) note ]

-- The End
