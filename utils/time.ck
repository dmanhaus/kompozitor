public class Beat
{
  120.0 => float m_bpm; // set the default to 120 BPM

  fun void setTempo ( float bpm ) 
  {
    bpm => m_bpm;
    <<< "New Tempo:", m_bpm, "Quarter-note Value:", quarter() >>>;
  }

  fun float tempo ()
  {
    return m_bpm;
    <<< "Tempo:", m_bpm, "Quarter-note Value:", quarter() >>>;
  }

  fun dur quarter ()
  {
    return 60::second / m_bpm;
  }

  fun dur whole ()
  {
    return quarter() * 4.0;
  }

  fun dur half ()
  {
    return quarter() * 2.0;
  }

  fun dur eighth ()
  {
    return quarter() / 2.0;
  }

  fun dur sixteenth ()
  {
    return quarter() / 4.0;
  }

  fun dur thirtySecondth ()
  {
    return quarter() / 8.0;
  }

  fun dur sixtyFourth ()
  {
    return quarter() / 16.0;
  }

  fun dur tie (dur note1, dur note2)
  {
    return note1 + note2;
  }

  fun dur dot (dur note)
  {
    return note + note / 2;
  }
}