module Test

import Notes
import Chord
import Scale
import Data.IORef
import System

assert : IORef Nat -> IORef Nat -> String -> Bool -> IO ()
assert passed failed label b =
  if b
    then do modifyIORef passed S
            putStrLn ("  PASS: " ++ label)
    else do modifyIORef failed S
            putStrLn ("  FAIL: " ++ label)

main : IO ()
main = do
  passed <- newIORef Z
  failed <- newIORef Z
  let t = assert passed failed

  putStrLn "=== Notes ==="

  -- numToNote
  t "numToNote 0 == C" (numToNote 0 == C)
  t "numToNote 1 == Cs" (numToNote 1 == Cs)

  -- noteToNum
  t "noteToNum C == Just 0" (noteToNum C == Just 0)
  t "noteToNum Cs == Just 1" (noteToNum Cs == Just 1)

  -- tr on notes
  t "tr 2 C == D" (tr 2 C == D)
  t "tr 9 C == A" (tr 9 C == A)
  t "tr 12 Bb == As" (tr 12 Bb == As)
  t "tr (-1) A == Gs" (tr (-1) A == Gs)
  t "tr (-3) A == Fs" (tr (-3) A == Fs)

  -- tr on ints
  t "tr 3 2 == 5" (tr 3 (the Int 2) == 5)

  -- trMod
  t "trMod (-3) 2 == 11" (trMod (-3) 2 == 11)
  t "trMod 13 2 == 3" (trMod 13 2 == 3)

  -- map tr
  t "map (tr 2) [0,2,4] == [2,4,6]" (map (tr 2) (the (List Int) [0, 2, 4]) == [2, 4, 6])
  t "map (tr 2) [C,E,Fs] == [D,Fs,Gs]" (map (tr 2) [C, E, Fs] == [D, Fs, Gs])

  -- inv
  t "inv 5 C == G" (inv 5 C == G)

  -- inversions
  t "inversions [0,4,7]" (inversions [0, 4, 7] == [[0, 4, 7], [4, 7, 0], [7, 0, 4]])

  putStrLn "\n=== Chords ==="

  -- chordToNums
  t "chordToNums (C, Major)" (chordToNums (C, Chord.Major) == [0, 4, 7])
  t "chordToNums (D, Minor)" (chordToNums (D, Chord.Minor) == [2, 5, 9])
  t "chordToNums (Fs, Dim7)" (chordToNums (Fs, Dim7) == [6, 9, 12, 15])

  -- chordToNotes
  t "chordToNotes (C, Major)" (chordToNotes (C, Chord.Major) == [C, E, G])
  t "chordToNotes (D, Minor)" (chordToNotes (D, Chord.Minor) == [D, F, A])
  t "chordToNotes (Fs, Dim7)" (chordToNotes (Fs, Dim7) == [Fs, A, C, Ds])

  -- numsToChord
  t "numsToChord [0,4,7] == Just (C, Major)" (numsToChord [0, 4, 7] == Just (C, Chord.Major))
  t "numsToChord [2,5,9] == Just (D, Minor)" (numsToChord [2, 5, 9] == Just (D, Chord.Minor))
  t "numsToChord [0,1,2,3] == Nothing" (numsToChord [0, 1, 2, 3] == Nothing)

  -- containsNote
  t "containsNote (C, Maj7) E" (containsNote (C, Maj7) E)
  t "not (containsNote (C, Maj7) F)" (not (containsNote (C, Maj7) F))

  putStrLn "\n=== Scales ==="

  -- scaleToNums
  t "scaleToNums (C, Major)" (scaleToNums (C, Scale.Major) == [0, 2, 4, 5, 7, 9, 11])

  -- scaleToNotes
  t "scaleToNotes (C, Major)" (scaleToNotes (C, Scale.Major) == [C, D, E, F, G, A, B])

  -- Summary
  p <- readIORef passed
  f <- readIORef failed
  putStrLn ("\n" ++ show p ++ " passed, " ++ show f ++ " failed")
  if f > 0
    then exitWith (ExitFailure 1)
    else exitWith ExitSuccess

-- The End
