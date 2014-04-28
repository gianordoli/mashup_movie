import processing.video.*;
Movie myMovie1;
Movie myMovie2;
ArrayList<Sub> subs;

int subIndex;
Boolean isPlaying;
Sub currSub;

String[] myWords;

void setup() {
  size(1440, 808);
  frameRate(30);
  myMovie1 = new Movie(this, "Portlandia.S03E06.HDTV.x264-2HD.mp4");
  myMovie1.frameRate(30); 
  // Pausing the video at the first frame. 
  myMovie1.play();
  myMovie1.jump(0);
  myMovie1.pause();

  myMovie2 = new Movie(this, "Portlandia.S03E07.HDTV.x264-2HD.mp4");
  myMovie2.frameRate(30);
  // Pausing the video at the first frame. 
  myMovie2.play();
  myMovie2.jump(0);
  myMovie2.pause();

  subs = new ArrayList<Sub>();
  processSubs("portlandia_s03_e06", "Portlandia.S03E06.HDTV.x264-2HD.srt");
  processSubs("portlandia_s03_e07", "Portlandia.S03E07.HDTV.x264-2HD.srt");

  subIndex = 0;
  isPlaying = false;
  currSub = subs.get(subIndex);

  subs = sortArrayList(subs);
//  subs = selectRepeated(subs);
  
//  myWords = new String[2];
//  myWords[0] = "hello";
//  myWords[1] = "yeah";
//  subs = selectWords(subs, myWords);
  
//  for(Sub s : subs){
//    println(s.movie);
//  }  
  
  textSize(16);   
}
Movie currMovie;
void draw() {
  background(0);
  
  if (!isPlaying) {
    currSub = subs.get(subIndex);
    println(currSub.movie);
    if(currSub.movie.equals("portlandia_s03_e06")){
      currMovie = myMovie1;
      myMovie2.pause();
    }else{
      currMovie = myMovie2;
      myMovie1.pause();
    }
    
    currMovie.play();
    currMovie.jump(currSub.start);
    //    println(currSub.start);
    isPlaying = true;
  }

  image(myMovie1, 0, 0);
  image(myMovie2, 720, 0);
  image(currMovie, 0, 404);

  //Draw subtitle
  textAlign(CENTER);
  text(currSub.speech, width/2, height - 25);

  //Check subtitle ending
  if (currMovie.time() >= currSub.end) {
    subIndex ++;
    isPlaying = false;
  }

  //Quits the app
  if (subIndex >= subs.size()) {
    exit();
  }
}

// Called every start a new frame is available to read
void movieEvent(Movie m) {
  m.read();
//  println(myMovie.time());
  
}
