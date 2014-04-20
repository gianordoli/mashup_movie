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
  textSize(16);

  //  sortArrayList();
  selectRepeated();
}

void draw() {
  background(0);

  Sub currSub = subs.get(subIndex);

  if (!isPlaying) {
    myMovie.jump(currSub.start);
    //    println(currSub.start);
    isPlaying = true;
  }

  image(myMovie, 0, 0);

  //Draw subtitle
  float mt = myMovie.time();
  if (mt <= currSub.end) {
    text(currSub.speech, width/2, height - 25);
  }
  else {
    subIndex ++;
    isPlaying = false;
  }

  noStroke();
  fill(255, 50);
  rect(10, height - 10, width - 20, 3);
  float thisTime = map(myMovie.time(), 0, myMovie.duration(), 10, width - 10);
  fill(255);
  ellipse(thisTime, height - 9, 9, 9);

  //Quits the app
  if (subIndex >= subs.size()) {
    exit();
  }
}

// Called every start a new frame is available to read
void movieEvent(Movie m) {
  m.read();
}

