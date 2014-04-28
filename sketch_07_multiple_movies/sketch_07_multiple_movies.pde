import processing.video.*;

ArrayList<Movie> myMovies; //All movies
ArrayList<Sub> subs;       //All subtitles
Movie currMovie;           //Movie currently playing

//Playback variables
int subIndex;
Boolean isPlaying;
Sub currSub;
StringList myWords;
 
void setup() {
  size(1440, 808);
  frameRate(30);
  myMovies = new ArrayList<Movie>();
  subs = new ArrayList<Sub>();
  
  //Adding movies
  myMovies.add(new Movie(this, "Portlandia.S03E06.HDTV.x264-2HD.mp4"));
  myMovies.add(new Movie(this, "Portlandia.S03E07.HDTV.x264-2HD.mp4"));
  
  //Setting movies up
  setupMovies(myMovies);

  //Adding subs
  processSubs(myMovies.get(0), "Portlandia.S03E06.HDTV.x264-2HD.srt");
  processSubs(myMovies.get(1), "Portlandia.S03E07.HDTV.x264-2HD.srt");

  subIndex = 0;
  isPlaying = false;
  currSub = subs.get(subIndex);

//  subs = sortArrayList(subs);
//  subs = selectRepeated(subs);
  
  myWords = new StringList();
  println(myWords.size());
  myWords.append("hello");
  myWords.append("yeah");
  subs = selectWords(subs, myWords);
 
 for(Sub s : subs){
   println(s.movie);
 } 
}

void draw() {
  background(0);
  
  /*----- SUBTITLE START -----*/
  if (!isPlaying) {
    //Pause all movies
    for(Movie m : myMovies){
      m.pause();
    }
    
    //What's the current subtitle?
    currSub = subs.get(subIndex);
//    println(currSub.movie);

    //Based on that, what' the current movie?
    currMovie = currSub.movie;
    
    //Play and jump to position
    currMovie.play();
    currMovie.jump(currSub.start);
    isPlaying = true;
  }


  /*---------- DRAW ----------*/
  image(myMovies.get(0), 0, 0);
  image(myMovies.get(1), 720, 0);
  image(currMovie, 0, 404);

  //Draw subtitle
  textAlign(CENTER);
  textSize(16);  
  text(currSub.speech, width/2, height - 25);
  
  //Draw counter
  if(myWords.size() > 0){
    textAlign(LEFT);
    String msg = "| ";
    for(String s : myWords){
      msg += s + " | ";
    }
    text(msg + ": " + subIndex, 10, 20);  
  }


  /*----- SUBTITLE ENDING ----*/
  if (currMovie.time() >= currSub.end) {
    subIndex ++;
    isPlaying = false;
  }


  /*--------- FINISH ---------*/
  //Quits the app
  if (subIndex >= subs.size()) {
    //Drop all movies
    for(Movie m : myMovies){
      m.stop();
    }
    exit();
  }
}

// Called every start a new frame is available to read
void movieEvent(Movie m) {
  m.read();
//  println(myMovie.time());
}

void setupMovies(ArrayList<Movie> allMovies){
  for(Movie m : allMovies){
    //Setting the framerate
    m.frameRate(30); 
    // Pausing the video at the first frame. 
    m.play();
    m.jump(0);
    m.pause();
  }
}
