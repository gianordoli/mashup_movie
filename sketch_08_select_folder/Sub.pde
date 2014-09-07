class Sub{
  Movie movie;
  int index;
  float start;
  float end;
  String speech;  
  
  Sub(Movie _movie, int _index, float _start, float _end, String _speech){
    movie = _movie;
    index = _index;
    start = _start;
    end = _end;

    // Removing punctuation
    speech = trim(_speech);    
    while((speech.length() > 0 &&
          speech.charAt(speech.length()-1) == '?'
          || speech.charAt(speech.length()-1) == '!'
          || speech.charAt(speech.length()-1) == '.')){
        speech = speech.substring(0, speech.length()-1);
    }
    println(speech);    
  }
}
