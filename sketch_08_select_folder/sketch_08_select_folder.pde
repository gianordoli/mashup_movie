//Video
import processing.video.*;
ArrayList<Movie> myMovies; //All movies
ArrayList<Sub> subs;       //All subtitles
Movie currMovie;           //Movie currently playing

//File system
java.io.File folder;
String path;

//Playback variables
Boolean isPlaying;
int subIndex;
Sub currSub;
Boolean isTalking;
StringList myWords;

//Layout
PVector margin;
PVector thumbSize;
PVector movieSize;
PVector moviePos;

PFont raleway;
String msg;

void setup() {
//  size(displayWidth, displayHeight);
  size(1033, 640);
  frameRate(30);
//  colorMode(HSB);

  margin = new PVector(30, 20);
  thumbSize = new PVector(120, 65);
  moviePos = new PVector(2 * margin.x + cWidth, margin.y);
  raleway = loadFont("Raleway-Bold-21.vlw");

  myMovies = new ArrayList<Movie>();
  subs = new ArrayList<Sub>();
  
  isPlaying = false;
  setGUI();
  
  msg = "";
}

void draw(){
  background(0);
  
    /*----- SUBTITLE START -----*/
    if (isTalking != null && isTalking == false && isPlaying) {
      
      //Pause all movies
      for(Movie m : myMovies){
        m.pause();
      }

      //What's the current subtitle?
      currSub = subs.get(subIndex);
  
      //Based on that, what's the current movie?
      currMovie = currSub.movie;
      
      //Play and jump to position
      currMovie.play();
      currMovie.jump(currSub.start);
      isTalking = true;    
    }
    
    /*---------- DRAW ----------*/  
    if(myMovies != null && currMovie != null){      
      //Main movie 
      PVector mRatio = new PVector(currMovie.width, currMovie.height);
      mRatio.normalize();
      float availableWidth = width - cWidth;
      movieSize = new PVector(mRatio.x * availableWidth, mRatio.y * availableWidth);      
      image(currMovie, moviePos.x, moviePos.y, movieSize.x, movieSize.y);
      
//      //Subtitle
//      textAlign(CENTER, BOTTOM);
//      textFont(raleway);
//      text(currSub.speech, moviePos.x, moviePos.y - margin.y, movieSize.x, movieSize.y);

      //Thumbs
      PVector thumbPos = new PVector(2*margin.x + cWidth, moviePos.y + movieSize.y + margin.y);
      for(int i = 0; i < myMovies.size(); i++){
        Movie m = myMovies.get(i); 
        image(m, thumbPos.x, thumbPos.y, thumbSize.x, thumbSize.y);
        thumbPos.x += thumbSize.x;
        if(thumbPos.x > width){
          thumbPos.x = margin.x;
          thumbPos.y += margin.y;
        }
      }  
    }
   
    /*----- SUBTITLE ENDING ----*/
    if (currMovie != null && currMovie.time() >= currSub.end) {
      subIndex ++;
      isTalking = false;
    }
  
    /*--------- FINISH ---------*/
    //Quits the app
    if (subs != null && subIndex >= subs.size() && isPlaying) {
      //Drop all movies
      for(Movie m : myMovies){
        m.stop();
      }
      exit();
    }  

    textAlign(CENTER, CENTER);
    textFont(raleway);
    text(msg, 2*margin.x + cWidth, margin.y, width - 2*margin.x - cWidth, 200); 

}

void movieEvent(Movie m) {
  m.read();
//  println(myMovie.time());
}

//boolean sketchFullScreen() {
//  return true;
//}

void keyPressed(){
  if(keyCode == 27){
    if(myMovies.size() > 0){
      for(Movie m : myMovies){
        m.stop();
      }
    }  
  }
  else if(key == 'e'){
    if(subs.size() > 0){
      String[] everySub = new String[subs.size()];
      for(int i = 0; i < subs.size(); i++){
        everySub[i] = subs.get(i).speech;
      }
      saveStrings("parsed_subtitles.srt", everySub);
    }
  }
}
