import processing.video.*;
Movie myMovie;
ArrayList<Sub> subs;

int subIndex;
Boolean isPlaying;

void setup() {
  size(720, 464);
  
  myMovie = new Movie(this, "Portlandia.S03E06.HDTV.x264-2HD.mp4");
  myMovie.play();

  subs = new ArrayList<Sub>();
  processSubs("portlandia", "Portlandia.S03E06.HDTV.x264-2HD.srt");
  
  subIndex = 20;
  isPlaying = false;
  
  textAlign(CENTER);
}

void draw() {
  background(0);

  Sub currSub = subs.get(subIndex);

  if(!isPlaying){
    myMovie.jump(currSub.start);
    println(currSub.start);
    isPlaying = true;
  }

  image(myMovie, 0, 0);
  
  //Draw subtitle
  float mt = myMovie.time();
  if(mt < currSub.end){
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
//    println("start: " + start);
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
    while(mySubs[i].length() == 0){
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
