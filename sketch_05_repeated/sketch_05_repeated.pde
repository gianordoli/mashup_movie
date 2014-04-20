import processing.video.*;
Movie myMovie;
ArrayList<Sub> subs;

int subIndex;
Boolean isPlaying;

void setup() {
  size(1280, 688);
  
  myMovie = new Movie(this, "Groundhog.Day.1993.BrRip.720p.x264.YIFY.mp4");
  myMovie.play();

  subs = new ArrayList<Sub>();
  processSubs("groundhog_day", "Groundhog.Day.1993.BrRip.720p.x264.YIFY.srt");
  
  subIndex = 0;
  isPlaying = false;
  
  textAlign(CENTER);
  
//  sortArrayList();
  checkRepeated();
}

void draw() {
  background(0);

  Sub currSub = subs.get(subIndex);

  if(!isPlaying){
    myMovie.jump(currSub.start);
//    println(currSub.start);
    isPlaying = true;
  }
  
  image(myMovie, 0, 0);
  
  //Draw subtitle
  float mt = myMovie.time();
  if(mt <= currSub.end){
    pushMatrix();
      translate(width/2, height - 20);
        text(currSub.speech, 0, 0);
    popMatrix();
  
  //Jump to the next subtitle
  }else{
    subIndex ++;
    isPlaying = false;
  }
}

// Called every start a new frame is available to read
void movieEvent(Movie m) {
  m.read();
}

void checkRepeated(){
  
  //This temporary ArrayList will store the objects sorted
  ArrayList<Sub> tempList = new ArrayList<Sub>();
  
  for(int i = 0; i < subs.size(); i++){
  
    String thisSub = subs.get(i).speech;
    Boolean addedThis = false;
    
    for(int j = 0; j < subs.size(); j++){
      
      String thatSub = subs.get(j).speech;  
      
      if(thisSub.equals(thatSub) && i != j){

        //Add "this" — only if it hasn't been added before        
        if(!addedThis){
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
