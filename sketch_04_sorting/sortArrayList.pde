void sortArrayList(){
  //Creating an empty array that will store the values we want to compare
  String[] values = new String[subs.size()];
  for(int i = 0; i < subs.size(); i++){
    //We'l compare based on...?
    values[i] = subs.get(i).speech;
  }
  //Sorting those values
  values = sort(values);
//  printArray(values);
  
  //This temporary ArrayList will store the objects sorted
  ArrayList<Sub> tempList = new ArrayList<Sub>();
  
  //Looping through each sorted value
  for(int i = 0; i < values.length; i++){
    //Looping through each object
    for(int j = 0; j < subs.size(); j++){
      //We'l compare based on...?
      String objectValue = subs.get(j).speech;  
      
      //If the sorted value is found...
      if(values[i] == objectValue){
        //Add the object to the temporary list and jump to the next iteration
        tempList.add(subs.get(j));
        subs.remove(subs.get(j));
        break;
      }
    }
  }
  //Replace the original list with the sorted one
  subs = tempList;
}
