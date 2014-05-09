//Video
import processing.video.*;
ArrayList<Movie> myMovies; //All movies
ArrayList<Sub> subs;       //All subtitles
Movie currMovie;           //Movie currently playing

//File system
java.io.File folder;
String path;

//Playback variables
int subIndex;
Boolean isPlaying;
Sub currSub;
StringList myWords;

void setup() {
//  size(displayWidth, displayHeight);
  size(1033, 640);
  
  setGUI();
}

void draw(){
  background(255);
  if(myMovies != null){
    for(int i = 0; i < myMovies.size(); i++){
      Movie m = myMovies.get(i);
      image(m, 0, 0, m.width, m.height);
    }
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
