ArrayList<Sub> selectWords(ArrayList<Sub> originalArrayList, String[] myWords) {
  
  //This temporary ArrayList will store the objects sorted
  ArrayList<Sub> tempList = new ArrayList<Sub>();

  for (int i = 0; i < originalArrayList.size(); i++) {
    
    String thisSub = originalArrayList.get(i).speech;
    
    for (int j = 0; j < myWords.length; j++) {
      
      if (thisSub.indexOf(myWords[j]) != -1) {
        //Add "this"
        tempList.add(originalArrayList.get(i));
        originalArrayList.remove(originalArrayList.get(i));
        break;
      }
      
    }
  }

  //Replace the original list with the sorted one
  return tempList;
}

