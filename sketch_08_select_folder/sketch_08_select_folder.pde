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

void setup() {
//  size(displayWidth, displayHeight);
  size(1033, 640);
//  colorMode(HSB);
  margin = new PVector(30, 20);
  isPlaying = false;
  setGUI();
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
    if(myMovies != null){
      //Thumbs
      PVector mSize = new PVector(120, 65);   
      for(int i = 0; i < myMovies.size(); i++){
        Movie m = myMovies.get(i);
        image(m, margin.x + i * mSize.x, height - mSize.y - margin.y, mSize.x, mSize.y);
      }
      
      //Main movie
      PVector mRatio = new PVector(currMovie.width, currMovie.height);
      mRatio.normalize();
      float availableWidth = width - cWidth; 
      image(currMovie, 2 * margin.x + cWidth, margin.y, mRatio.x * availableWidth, mRatio.y * availableWidth);
    }
   
    /*----- SUBTITLE ENDING ----*/
    if (currMovie != null && currMovie.time() >= currSub.end) {
      subIndex ++;
      isTalking = false;
    }
  
    /*--------- FINISH ---------*/
    //Quits the app
    if (subs != null && subIndex >= subs.size()) {
      //Drop all movies
      for(Movie m : myMovies){
        m.stop();
      }
      exit();
    }  

}

void movieEvent(Movie m) {
  m.read();
//  println(myMovie.time());
}

//boolean sketchFullScreen() {
//  return true;
//}
