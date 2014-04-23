ArrayList<Sub> selectRepeated(ArrayList<Sub> originalArrayList) {

  //This temporary ArrayList will store the objects sorted
  ArrayList<Sub> tempList = new ArrayList<Sub>();

  for (int i = 0; i < originalArrayList.size(); i++) {

    String thisSub = originalArrayList.get(i).speech;
    Boolean addedThis = false;

    for (int j = 0; j < originalArrayList.size(); j++) {

      String thatSub = originalArrayList.get(j).speech;  

      if (thisSub.equals(thatSub) && i != j) {

        //Add "this" — only if it hasn't been added before        
        if (!addedThis) {
          tempList.add(originalArrayList.get(i));
          addedThis = true;
        }

        //Add "that"
        tempList.add(originalArrayList.get(j));
        originalArrayList.remove(originalArrayList.get(j));
      }
    }
  }

  //Replace the original list with the sorted one
  return tempList;
}
