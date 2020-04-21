FreqCalc fc;
Chord chord;

SinOsc note => dac;
0.075 => note.gain;

"A" => string noteName;

// Play tonic
fc.get_frequency_for_note(noteName) => float tonic;
tonic => note.freq;
<<< "tonic:", noteName, tonic, "Hz" >>>;

2::second => now;
0 => note.gain;

1::second => now; // rest

// Play scale
["chromatic", "natural_major", "natural_minor", "harmonic_minor", "octatonic", "pentatonic", "dorian_mode", "phrygian_mode", "lydian_mode", "mixolydian_mode", "aeolian_mode", "locrian_mode"] @=> string modes[];
// "locrian_mode" => string scaleName;

for(0 => int i; i < modes.cap(); i++)
{
    modes[i] => string scaleName;
    <<< "Playing", scaleName, "scale" >>>; 
    fc.play_scale(tonic, fc.get_scale(scaleName));
    .75::second => now;
}

["major_triad", "minor_triad", "diminished_triad", "augmented_triad", "suspended_fourth", "suspended_second", "added_ninth" , "major_triad", "diminished_seventh","minor_seventh", "minor_major_seventh"] @=> string chords[];

for(0 => int i; i < chords.cap(); i++)
{
    chords[i] => string chordName;
    <<< "Playing", noteName, chordName, "chord" >>>;
    noteName + chordName => chord.name; 
    chord.play(1);
    1::second => now;
}

0.075 => note.gain;

<<< "Playing", noteName, "octaves" >>>;

for(-1 => int i; i < 10; i++)
{
    <<< noteName, i >>>;
    Math.mtof(fc.get_midi_number_for_note(noteName, i)) => note.freq;  // Get the midi number of the note and convert it to the frequency
    .325::second => now;
}

<<< "Finished" >>>;