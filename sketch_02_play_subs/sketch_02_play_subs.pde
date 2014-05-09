import processing.video.*;
Movie myMovie;
ArrayList<Sub> subs;

void setup() {
  size(720, 464);
  
  myMovie = new Movie(this, "Portlandia.S03E06.HDTV.x264-2HD.mp4");
  myMovie.loop();

  subs = new ArrayList<Sub>();
  processSubs("portlandia", "Portlandia.S03E06.HDTV.x264-2HD.srt");
  
  textAlign(CENTER);
}

void draw() {
  background(0);  
//  tint(255, 0, 0);
  image(myMovie, 0, 0);
  
  float mt = myMovie.time();
  for(Sub s : subs){
    if(s.start < mt && mt < s.end){
      pushMatrix();
        translate(width/2, height - 20);
          text(s.speech, 0, 0);
      popMatrix();
    }
  }
  
//  if(mousePressed){
//    float mt = myMovie.time();
//    myMovie.jump(mt + 1);
//    println(mt);
//  }
}

// Called every start a new frame is available to read
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

    //2 - Subtitle start
    String startString = mySubs[i].substring(0, 12);
//    println("start: " + startString);
    float start = toSeconds(startString);
    println("start: " + start);
    String endString = mySubs[i].substring(17);
//    println("end: " + endString);
    float end = toSeconds(endString);
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
    while(i < mySubs.length && mySubs[i].length() == 0){
      i++;
    }    

    subs.add(new Sub(_movie, index, start, end, speech));
  }
}

float toSeconds(String myTime) {
//  println(myTime);
  int hours = parseInt(myTime.substring(0, 2));
  int minutes = parseInt(myTime.substring(3, 5));
  float seconds = parseFloat(myTime.substring(6, myTime.indexOf(',')));
  float milliseconds = parseFloat(myTime.substring(myTime.indexOf(',') + 1)) / 1000;
  seconds += milliseconds;
//  println("h: " + hours + ", min: " + minutes + ", s: " + seconds);
  seconds += (60 * minutes) + (3600 * hours);
//  println(seconds);
  return seconds;
}
