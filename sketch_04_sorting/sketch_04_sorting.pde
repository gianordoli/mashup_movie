import processing.video.*;
Movie myMovie;
ArrayList<Sub> subs;

int subIndex;
Boolean isPlaying;

void setup() {
  size(720, 464);
  
  myMovie = new Movie(this, "Groundhog.Day.1993.BrRip.720p.x264.YIFY.mp4");
  myMovie.play();

  subs = new ArrayList<Sub>();
  processSubs("portlandia", "Groundhog.Day.1993.BrRip.720p.x264.YIFY.srt");
  
  subIndex = 0;
  isPlaying = false;
  
  textAlign(CENTER);
  
  sortArrayList();
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
