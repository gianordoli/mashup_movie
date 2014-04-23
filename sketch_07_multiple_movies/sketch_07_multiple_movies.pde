import processing.video.*;
Movie myMovie;
ArrayList<Sub> subs;

int subIndex;
Boolean isPlaying;
Sub currSub;

void setup() {
  size(960, 400);
  frameRate(30);
  myMovie = new Movie(this, "Portlandia.S03E06.HDTV.x264-2HD.mp4");
  myMovie.frameRate(30); 
  myMovie.play();

  subs = new ArrayList<Sub>();
  processSubs("portlandia_s03_e06", "Portlandia.S03E06.HDTV.x264-2HD.srt");

  subIndex = 0;
  isPlaying = false;
  currSub = subs.get(subIndex);

  subs = sortArrayList(subs);
//  selectRepeated();
  
//  String[] myWords = {"fucking", "fuck", "fuckin"};
//  String[] myWords = {"fuck"};
//  selectWords(myWords);
  
  textSize(16);   
}

void draw() {
  background(0);
  
  if (!isPlaying) {
    currSub = subs.get(subIndex);
    myMovie.jump(currSub.start);
    //    println(currSub.start);
    isPlaying = true;
  }

  image(myMovie, 0, 0, width, height);

  //Draw subtitle
  textAlign(CENTER);
  text(currSub.speech, width/2, height - 25);
//  text(currSub.end, width/2, height - 35);
  
  //Draw "player"
  noStroke();
  fill(255, 50);
  rect(10, height - 10, width - 20, 3);
  float thisTime = map(myMovie.time(), 0, myMovie.duration(), 10, width - 10);
  fill(255);
  ellipse(thisTime, height - 9, 9, 9);

  //Draw counter
  textAlign(LEFT);
  text("fucking/fuckin/fuck: " + subIndex, 10, 20);

  //Check subtitle ending
  if (myMovie.time() >= currSub.end) {
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
