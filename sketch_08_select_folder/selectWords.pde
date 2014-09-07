ArrayList<Sub> selectWords(ArrayList<Sub> originalArrayList, HashMap<String,Integer> myWords) {
  
  //This temporary ArrayList will store the objects sorted
  ArrayList<Sub> tempList = new ArrayList<Sub>();

  for (int i = 0; i < originalArrayList.size(); i++) {
    
    String thisSub = originalArrayList.get(i).speech;
    
    for (int j = 0; j < myWords.size(); j++) {
      
      if (thisSub.indexOf(myWords.get(j)) != -1) {
//      if (thisSub.indexOf(myWords.get(j)) != -1) {
        
        //IF THE WORD IS MORE THAN 30% OF THE SENTENCE
//        if (myWords.get(j).length() * 2 > thisSub.length()) {  
          
          //Add "this"
          tempList.add(originalArrayList.get(i));
          originalArrayList.remove(originalArrayList.get(i));
          break;
          
//        }
      }
      
    }
  }
  
  originalArrayList.clear();

  //Replace the original list with the sorted one
  return tempList;
}

