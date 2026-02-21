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

-- The End
