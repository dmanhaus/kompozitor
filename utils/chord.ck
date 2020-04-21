public class Chord
{
  FreqCalc fc;

  int m_semitones[];
  float m_tonic;
  string m_root;
  string m_chordName;
  string m_chordType;

  fun void name( string chordName )
  {
    chordName => m_chordName;                           // set the m_chordName instance variable
    get_root_from_chordName();
    get_tonic_from_root();
    get_chordType_from_chordName();          
    get_chord_intervals( m_chordType ) @=> m_semitones;  // set the m_semitones instance variable
  }

  fun void get_root_from_chordName ()
  {
    if( m_chordName.length() == 1 ) // conditional expression goes here
    {
       m_chordName => m_root; 
    }
    else
    {
       if( m_chordName.find("#") == 1 ) // conditional expression goes here
       {
          m_chordName.substring(0, 2) => m_root;
       }
       else
       {
          m_chordName.substring(0, 1) => m_root;
       }
    }
  }

  fun void get_tonic_from_root ()
  {
    if( m_root.length() > 0 ) // conditional expression goes here
    {
       fc.get_frequency_for_note(m_root) => m_tonic;
    }
  }

  fun void get_chordType_from_chordName ()
  {
    if( m_chordName.length() == 1 ) // conditional expression goes here
    {
       "maj" => m_chordType;
    }
    else
    {
       if( m_chordName.find("#") == 1 ) // conditional expression goes here
       {
          m_chordName.substring(2) => m_chordType;
       }
       else
       {
          m_chordName.substring(1) => m_chordType;
       }
    }
  }

  fun void play( dur duration )
    {   
        SinOsc n1 => JCRev r1 => dac;
        SinOsc n2 => JCRev r2 => dac;
        SinOsc n3 => JCRev r3 => dac;
        SinOsc n4 => JCRev r4 => dac;
        SinOsc n5 => JCRev r5 => dac;

        // <<< chordName, sharpLoc >>>;

        0.075 => float gainLevel;
        fc.calc_harmonic_freq(m_tonic, m_semitones[0]) => n1.freq;
        fc.calc_harmonic_freq(m_tonic, m_semitones[1]) => n2.freq;
        fc.calc_harmonic_freq(m_tonic, m_semitones[2]) => n3.freq;
        gainLevel => n1.gain;
        gainLevel => n2.gain;
        gainLevel => n3.gain;
        0 => n4.gain;
        0 => n5.gain;

        if(m_semitones.cap()==4)
        {
            // <<< notes.cap(), 4, "notes in chord" >>>;
            fc.calc_harmonic_freq(m_tonic, m_semitones[3]) => n4.freq;
            gainLevel => n4.gain;
        }
        if(m_semitones.cap()==5)
        {
            // <<< notes.cap(), 5, "notes in chord" >>>;
            fc.calc_harmonic_freq(m_tonic, m_semitones[4]) => n5.freq;
            gainLevel => n5.gain;
        }
        
        0.1 => float mixLevel;
        mixLevel => r1.mix;
        mixLevel => r2.mix;
        mixLevel => r3.mix;
        mixLevel => r4.mix;
        mixLevel => r5.mix;

        duration => now;
        0 => n1.gain;
        0 => n2.gain;
        0 => n3.gain;
        0 => n4.gain;
        0 => n5.gain;
    }

    fun int[] get_chord_intervals( string name)
    {
      int chordName[0];
      0 => chordName["empty"];
      1 => chordName["major_triad"];
      1 => chordName["maj"];
      
      2 => chordName["minor_triad"];
      2 => chordName["min"];
      2 => chordName["m"];
      
      3 => chordName["diminished_triad"];
      3 => chordName["dim"];
      3 => chordName["o"];
      
      4 => chordName["augmented_triad"];
      4 => chordName["aug"];
      4 => chordName["+"];

      5 => chordName["suspended_second"];
      5 => chordName["sus2"];

      6 => chordName["suspended_fourth"];
      6 => chordName["sus4"];
      
      7 => chordName["added_ninth"];
      7 => chordName["add9"];

      8 => chordName["diminished_seventh"];
      8 => chordName["dim7"];
      
      9 => chordName["minor_seventh"];
      9 => chordName["min7"];
      9 => chordName["m7"];
      
      10 => chordName["major_seventh"];
      10 => chordName["maj7"];
      10 => chordName["7"];
      
      11 => chordName["minor_major_seventh"];
      11 => chordName["minmaj7"];
      11 => chordName["mM7"];

      [ [-1] ,                  // 0, Default to empty chord (no name found)
      [ 0, 4, 7],              // 1, Major Triad
      [ 0, 3, 7],              // 2, Minor Triad
      [ 0, 3, 6],              // 3, Diminished Triad
      [ 0, 4, 8],              // 4, Augmented Triad
      [ 0, 2, 7],              // 5, Suspended Second
      [ 0, 5, 7],              // 6, Suspended Fourth
      [ 0, 4, 7, 14],          // 7, Added Ninth
      [ 0, 3, 6, 9],           // 8, Diminished Seventh
      [ 0, 3, 7, 10],          // 9, Minor Seventh
      [ 0, 4, 7, 10],          // 10, Major Seventh
      [ 0, 3, 7, 11]           // 11, Minor Major Seventh

      ] @=> int chord [][];

      // chord[chordName[name]] @=> m_semitones;
      return chord[chordName[name]];    
      }
}