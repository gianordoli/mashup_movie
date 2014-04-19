import processing.video.*;
Movie myMovie;
ArrayList<Sub> subs;

void setup() {
  size(720, 464);
  
  myMovie = new Movie(this, "Portlandia.S03E06.HDTV.x264-2HD.mp4");
  myMovie.loop();

  subs = new ArrayList<Sub>();
  processSubs("portlandia", "Portlandia.S03E06.HDTV.x264-2HD.srt");
}

void draw() {
  background(0);  
//  tint(255, 0, 0);
  image(myMovie, 0, 0);
  
  if(mousePressed){
    float mt = myMovie.time();
    myMovie.jump(mt + 1);
    println(mt);
  }
}

// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
}

void processSubs(String _movie, String filename) {

  int i = 0;
  String[] mySubs = loadStrings(filename);

  while (i < mySubs.length - 3) {
    //   while (i < 20) { 

    int index = parseInt(mySubs[i]);
    i++;

    //2 - Subtitle time    
//    String time = mySubs[i];
    int time = toSeconds(mySubs[i]);
    i++;

    String speech = mySubs[i];
    i++;
    
    //If the next line is also text
    while (mySubs[i].length() != 0 && parseInt(mySubs[i]) == 0) {  //Second line?
      speech += " " + mySubs[i];
      i++;
    }
    
    //If the next line is a paragraph
    //"while", because there may be more than one paragraph     
    while(mySubs[i].length() == 0){
      i++;
    }    

    subs.add(new Sub(_movie, index, time, speech));
  }
}

int toSeconds(String myTime) {
  myTime = myTime.substring(0, 8);
  int hours = parseInt(myTime.substring(0, 2));
  int minutes = parseInt(myTime.substring(3, 5));
  int seconds = parseInt(myTime.substring(6, 8));
//  myTime = "h: " + hours + ", min: " + minutes + ", s: " + seconds;
  seconds += (60 * minutes) + (3600 * hours);
//  println(myTime);
  return seconds;
}

