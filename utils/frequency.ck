public class FreqCalc
{
    fun float calc_harmonic_freq( float root, int halfSteps )
    {
        // This function calculates the frequency of harmonics in the equal tempered scale
        // following fn = f0 * (a) power n
        // where f0 = the root, n = interval in half steps, a = the twelfth root of 2
        1.0594630943593 => float a; // The twelfth root of two 
        return root * Math.pow( a, halfSteps ); 
    }

    fun void play_scale( float tonic, int notes[], dur noteDuration )
    {
        SinOsc note => dac;
        0.075 => note.gain;
        
        // loop through the notes from the list provided
        for(0 => int i; i < notes.cap(); i++)
        {
            // Calculate the frequency of the interval, and assign it to the sine osc frequency
            calc_harmonic_freq(tonic, notes[ i ] ) => float interval => note.freq;
            <<< "interval:", i, "degrees:", notes[i], "freq:", interval >>>;
            
            // Play the interval
            noteDuration => now;
        }
        0 => note.gain;
    }

    fun int[] get_scale( string name )
    {
        int scaleName[0];
        // Assign integer index values to an associative array, with a string index to match to the "name" function argument 
        0 => scaleName["empty"];         // This index maps to an array containing one member, 0, which becomes the list returned when an invalid name is passed
        1 => scaleName["chromatic"];
        2 => scaleName["natural_major"];
        2 => scaleName["ionian_mode"];
        3 => scaleName["natural_minor"];
        4 => scaleName["harmonic_minor"];
        5 => scaleName["octatonic"];
        6 => scaleName["pentatonic"];
        7 => scaleName["dorian_mode"];
        8 => scaleName["phrygian_mode"];
        9 => scaleName["lydian_mode"];
        10 => scaleName["mixolydian_mode"];
        11 => scaleName["aeolian_mode"];
        12 => scaleName["locrian_mode"];
        
        // These arrays represent scales as a list of (integer) semitone intervals from the tonic 
        [ [ 0 ] ,                                          // 0, Default to Tonic (name not found) 
        [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 ] ,     // 1, Chromatic
        [ 0, 2, 4, 5, 7, 9, 11, 12 ] ,                     // 2, Natural Major, Ionian mode 
        [ 0, 2, 3, 5, 7, 8, 10, 12 ] ,                     // 3, Natural Minor
        [ 0, 2, 3, 5, 7, 8, 11, 12 ] ,                     // 4, Harmonic Minor
        [ 0, 2, 3, 5, 6, 8, 9, 11, 12 ] ,                  // 5, Octatonic
        [ 0, 2, 4, 7, 9, 12 ] ,                            // 6, Pentatonic
        [ 0, 2, 3, 5, 7, 9, 10, 12],                       // 7, Dorian mode
        [ 0, 1, 3, 5, 7, 8, 10, 12 ],                      // 8, Phrygian mode 
        [ 0, 2, 4, 6, 7, 9, 11, 12 ],                      // 9, Lydian mode
        [ 0, 2, 4, 5, 7, 9, 10, 12 ],                      // 10, Mixolydian mode
        [ 0, 2, 3, 5, 7, 8, 10, 12 ],                      // 11, Aeolian mode
        [ 0, 1, 3, 5, 6, 8, 10, 12 ]                       // 12, Locrian mode
        ] @=> int scale [][];

        // Get the scale at the scaleName index passed in as the "name" function argument
        // <<< "Getting", name, "scale" >>>;
        return scale[scaleName[name]];
    }

    fun float get_frequency_for_note( string note )
    {
        ["A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G","G#"] @=> string notes[];
        0 => int interval;
        // Get the index of the interval matching the note provided
        for(0 => int i; i < notes.cap(); i++)
        {
            // <<< i, note, notes[i], notes[i] == note >>>;
            if( notes[ i ] == note ) 
            {
            // <<< notes[ i ] >>>;
            i => interval;
            }
        }

        get_scale("chromatic") @=> int chromatic[];

        // We start from A4 and then find the frequency of the target tonic by relation using the get_scale function 
        440.00 => float A4;   

        calc_harmonic_freq(A4, chromatic[interval]) => float frequency; 
        // <<< "tonic frequency", frequency >>>;
        return frequency;
    }

    fun int get_midi_number_for_note( string note, int octave)
    {
        ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#","B"] @=> string notes[];
        0 => int interval;
        
        for(0 => int i; i < notes.cap(); i++)
        {
            if( notes[ i ] == note ) 
            {
                // <<< notes [ i ] >>>;
                i => interval;
            }
        }

        octave++; // increment octave by one to align with array index
        
        [
        [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ],                       // 0  (octave -1) 
        [ 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23 ],             // 1  (octave  0)
        [ 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35 ],             // 2  (octave  1)
        [ 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47 ],             // 3  (octave  2)
        [ 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59 ],             // 4  (octave  3)
        [ 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71 ],             // 5  (octave  4)
        [ 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83 ],             // 6  (octave  5)
        [ 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95 ],             // 7  (octave  6)
        [ 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107],      // 8  (octave  7)
        [ 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119],  // 9  (octave  8)
        [ 120, 121, 122, 123, 124, 125, 126, 127]                       // 10 (octave  9)
        ] @=> int midi_note_table [][];
        
        return midi_note_table[octave] [interval];
    }
}