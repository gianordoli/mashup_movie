ArrayList<Sub> selectWords(ArrayList<Sub> originalArrayList, HashMap<String,Integer> myWords) {
  
  //This temporary ArrayList will store the objects sorted
  ArrayList<Sub> tempList = new ArrayList<Sub>();

  for (int i = 0; i < originalArrayList.size(); i++) {
    
    Sub thisSub = originalArrayList.get(i);
    boolean isStored = false;
    for (String s : thisSub.speechStringList) {
      for (Map.Entry me : myWords.entrySet()) {
        if(me.getKey().equals(s)){
          tempList.add(thisSub);
          originalArrayList.remove(originalArrayList.get(i));
          isStored = true;
          break;
        }
      }
      if(isStored){
        isStored = false;
        break;
      }
    }
    
//    for (int j = 0; j < myWords.size(); j++) {
//      
//      if (thisSub.indexOf(myWords.get(j)) != -1) {
////      if (thisSub.indexOf(myWords.get(j)) != -1) {
//        
//        //IF THE WORD IS MORE THAN 30% OF THE SENTENCE
////        if (myWords.get(j).length() * 2 > thisSub.length()) {  
//          
//          //Add "this"
//          tempList.add(originalArrayList.get(i));
//          originalArrayList.remove(originalArrayList.get(i));
//          break;
//          
////        }
//      }
      
//    }
  }
  
  originalArrayList.clear();

  //Replace the original list with the sorted one
  return tempList;
}

