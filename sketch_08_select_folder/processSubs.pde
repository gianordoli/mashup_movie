void processSubs(Movie _movie, String filename) {

  int i = 0;
  String[] mySubs = loadStrings(filename);

  while (i < mySubs.length - 1) {

    int index = parseInt(mySubs[i]);
    if(i < mySubs.length - 1){
      i++;
    }

    //2 - Subtitle start
    String startString = mySubs[i].substring(0, 12);
//    println("start: " + startString);
    float start = toSeconds(startString);
//    println("start: " + start);
    String endString = mySubs[i].substring(17);
//    println("end: " + endString);
    float end = toSeconds(endString);
    if(i < mySubs.length - 1){
      i++;
    }

    String speech = mySubs[i].toLowerCase();
    speech = trim(speech);
    if(i < mySubs.length - 1){
      i++;
    }
    
    //If the next line is also text
    while (mySubs[i].length() != 0 && parseInt(mySubs[i]) == 0) {  //Second line?
      speech += " " + mySubs[i].toLowerCase();
      if(i < mySubs.length - 1){
        i++;
      }else{
        break;
      }
    }
    
    //If the next line is a paragraph
    //"while", because there may be more than one paragraph
//    println(mySubs[i].length());    
    while(mySubs[i].length() == 0){
      if(i < mySubs.length - 1){
        i++;
      }else{
        break;
      }
    }    
    
    println(speech);
    subs.add(new Sub(_movie, index, start, end, speech));
  }
}
