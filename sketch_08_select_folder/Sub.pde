class Sub{
  Movie movie;
  int index;
  float start;
  float end;
  String speech;
  StringList speechStringList;  
  
  Sub(Movie _movie, int _index, float _start, float _end, String _speech){
    movie = _movie;
    index = _index;
    start = floor(_start);
    end = ceil(_end);
    speech = removePunctuation(_speech);
    println(speech);
    speechStringList = parseIntoStringList(_speech);
//    printArray(speechStringList);
  }
  
  StringList parseIntoStringList(String _speech){
    
    // Splitting into words
    String[] words = split(_speech, " ");
    
    StringList tempStringList = new StringList();
    for(String w : words){
      w = trim(w);
      w = removePunctuation(w);
      if(w.length() > 0){
        tempStringList.append(w);
      }
    }  
    return tempStringList; 
  }
  
  String removePunctuation(String _word){
      String word = _word;
      // End to start
      while((word.length() > 0) &&
            (word.charAt(word.length()-1) == '?'
            || word.charAt(word.length()-1) == '!'
            || word.charAt(word.length()-1) == '.'
            || word.charAt(word.length()-1) == ','
            || word.charAt(word.length()-1) == ';'
            || word.charAt(word.length()-1) == '-'
            || word.charAt(word.length()-1) == '\"'
            || word.charAt(word.length()-1) == '\'')){
          word = word.substring(0, word.length()-1);
      }
      // Start to end
      while((word.length() > 0) &&
            (word.charAt(0) == '?'
            || word.charAt(0) == '!'
            || word.charAt(0) == '.'
            || word.charAt(0) == ','
            || word.charAt(0) == ';'
            || word.charAt(0) == '-'
            || word.charAt(0) == '\"'
            || word.charAt(0) == '\'')){
          word = word.substring(1);
      }      
    return word;
  }
}
