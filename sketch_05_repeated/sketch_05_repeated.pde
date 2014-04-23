import processing.video.*;
Movie myMovie;
ArrayList<Sub> subs;

int subIndex;
Boolean isPlaying;
Sub currSub;

void setup() {
  size(1280, 688);
  frameRate(60);
  myMovie = new Movie(this, "Groundhog.Day.1993.BrRip.720p.x264.YIFY.mp4");
  myMovie.frameRate(60); 
  myMovie.play();

  subs = new ArrayList<Sub>();
  processSubs("groundhog_day", "Groundhog.Day.1993.BrRip.720p.x264.YIFY.srt");

  subIndex = 0;
  isPlaying = false;
  currSub = subs.get(subIndex);

  textAlign(CENTER);
  textSize(16);

//  sortArrayList();
  selectRepeated();
}

void draw() {
  background(0);

  if (!isPlaying) {
    currSub = subs.get(subIndex);
    myMovie.jump(currSub.start);
    //    println(currSub.start);
    isPlaying = true;
  }

  image(myMovie, 0, 0);

  //Draw subtitle
  text(currSub.speech, width/2, height - 25);
//  text(currSub.end, width/2, height - 35);
  
  //Draw "player"
  noStroke();
  fill(255, 50);
  rect(10, height - 10, width - 20, 3);
  float thisTime = map(myMovie.time(), 0, myMovie.duration(), 10, width - 10);
  fill(255);
  ellipse(thisTime, height - 9, 9, 9);

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

