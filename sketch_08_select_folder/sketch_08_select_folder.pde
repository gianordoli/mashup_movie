//Video
import processing.video.*;
ArrayList<Movie> myMovies; //All movies

//File system
java.io.File folder;
String path;

void setup() {
//  size(displayWidth, displayHeight);
  size(1033, 640);
  myMovies = new ArrayList<Movie>();  
  
  setGUI();
}

void draw(){
  background(255); 
//  if(myMovie != null){
//    if(myMovie.width > width){
//      image(myMovie, 0, 0, width, 400);
//    }
//  }
}

void movieEvent(Movie m) {
  m.read();
//  println(myMovie.time());
}
