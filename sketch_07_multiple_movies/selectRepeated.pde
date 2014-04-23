void selectRepeated() {

  //This temporary ArrayList will store the objects sorted
  ArrayList<Sub> tempList = new ArrayList<Sub>();

  for (int i = 0; i < subs.size(); i++) {

    String thisSub = subs.get(i).speech;
    Boolean addedThis = false;

    for (int j = 0; j < subs.size(); j++) {

      String thatSub = subs.get(j).speech;  

      if (thisSub.equals(thatSub) && i != j) {

        //Add "this" — only if it hasn't been added before        
        if (!addedThis) {
          tempList.add(subs.get(i));
          addedThis = true;
        }

        //Add "that"
        tempList.add(subs.get(j));
        subs.remove(subs.get(j));
      }
    }
  }

  //Replace the original list with the sorted one
  subs = tempList;
}
