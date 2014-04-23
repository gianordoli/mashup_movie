void selectWords(String[] myWords) {
  
  //This temporary ArrayList will store the objects sorted
  ArrayList<Sub> tempList = new ArrayList<Sub>();

  for (int i = 0; i < subs.size(); i++) {
    
    String thisSub = subs.get(i).speech;
    
    for (int j = 0; j < myWords.length; j++) {
      
      if (thisSub.indexOf(myWords[j]) != -1) {
        //Add "this"
        tempList.add(subs.get(i));
        subs.remove(subs.get(i));
        break;
      }
      
    }
  }

  //Replace the original list with the sorted one
  subs = tempList;
}

