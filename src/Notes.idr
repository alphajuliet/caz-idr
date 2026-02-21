module Notes

-- Note type
public export
data Note = C | D | E | F | G | A | B | Cs | Ds | Fs | Gs | As | Db | Eb | Gb | Ab | Bb

-- Pitch: a note at a specific octave
public export
data Pitch = MkPitch Note Int

-- Enharmonic equivalence
export
eqNote : Note -> Note -> Bool
eqNote C  C  = True
eqNote D  D  = True
eqNote E  E  = True
eqNote F  F  = True
eqNote G  G  = True
eqNote A  A  = True
eqNote B  B  = True
eqNote Cs Cs = True
eqNote Ds Ds = True
eqNote Fs Fs = True
eqNote Gs Gs = True
eqNote As As = True
eqNote Db Db = True
eqNote Eb Eb = True
eqNote Gb Gb = True
eqNote Ab Ab = True
eqNote Bb Bb = True
eqNote Cs Db = True
eqNote Db Cs = True
eqNote Ds Eb = True
eqNote Eb Ds = True
eqNote Fs Gb = True
eqNote Gb Fs = True
eqNote Gs Ab = True
eqNote Ab Gs = True
eqNote As Bb = True
eqNote Bb As = True
eqNote _  _  = False

export
Eq Note where
  (==) = eqNote

export
Show Note where
  show C  = "C";  show D  = "D";  show E  = "E";  show F  = "F"
  show G  = "G";  show A  = "A";  show B  = "B"
  show Cs = "C#"; show Ds = "D#"; show Fs = "F#"
  show Gs = "G#"; show As = "A#"
  show Db = "Db"; show Eb = "Eb"; show Gb = "Gb"
  show Ab = "Ab"; show Bb = "Bb"

-- Mod-12 arithmetic (handles negatives correctly)
export
mod12 : Int -> Int
mod12 n = ((n `mod` 12) + 12) `mod` 12

-- 12 semitone slots; entry is (sharp, Just flat) for enharmonic pairs
export
allNotes : List (Note, Maybe Note)
allNotes = [ (C,  Nothing),  (Cs, Just Db), (D,  Nothing),  (Ds, Just Eb)
           , (E,  Nothing),  (F,  Nothing),  (Fs, Just Gb), (G,  Nothing)
           , (Gs, Just Ab),  (A,  Nothing),  (As, Just Bb), (B,  Nothing) ]

-- Canonical 12-note set (one spelling per semitone)
export
basicNotes : List Note
basicNotes = [C, Cs, D, Eb, E, F, Fs, G, Ab, A, Bb, B]

-- Safe list index by position
listIndex : Nat -> List a -> Maybe a
listIndex _ []          = Nothing
listIndex Z     (x :: _)  = Just x
listIndex (S k) (_ :: xs) = listIndex k xs

-- Note -> ordinal (0-11); respects enharmonics
export
noteToNum : Note -> Maybe Int
noteToNum note = go 0 allNotes
  where
    go : Int -> List (Note, Maybe Note) -> Maybe Int
    go _ [] = Nothing
    go i ((sharp, mflat) :: rest) =
      if note == sharp || mflat == Just note
        then Just i
        else go (i + 1) rest

-- Ordinal -> note (sharp spelling by default)
export
numToNote : Int -> Note
numToNote n =
  case listIndex (cast (mod12 n)) allNotes of
    Just (sharp, _) => sharp
    Nothing => C  -- unreachable: allNotes has exactly 12 entries

-- Structural (non-enharmonic) check for flat reference notes
isFlatRef : Note -> Bool
isFlatRef Db = True
isFlatRef Eb = True
isFlatRef Gb = True
isFlatRef Ab = True
isFlatRef Bb = True
isFlatRef _  = False

-- Ordinal -> note, using flat spelling when reference note is flat
export
numToNote' : Note -> Int -> Note
numToNote' ref n =
  case listIndex (cast (mod12 n)) allNotes of
    Just (sharp, Just flat) => if isFlatRef ref then flat else sharp
    Just (sharp, Nothing)   => sharp
    Nothing                 => C

-- The End
