import processing.video.*;
Movie myMovie1;
Movie myMovie2;
ArrayList<Movie> myMovies;
ArrayList<Sub> subs;

int subIndex;
Boolean isPlaying;
Sub currSub;

String[] myWords;

void setup() {
  size(1440, 808);
  frameRate(30);
  myMovies = new ArrayList<Movie>();
  myMovies.add(new Movie(this, "Portlandia.S03E06.HDTV.x264-2HD.mp4"));
  myMovies.add(new Movie(this, "Portlandia.S03E07.HDTV.x264-2HD.mp4"));
  
  setupMovies(myMovies);

  subs = new ArrayList<Sub>();
  processSubs("portlandia_s03_e06", "Portlandia.S03E06.HDTV.x264-2HD.srt");
  processSubs("portlandia_s03_e07", "Portlandia.S03E07.HDTV.x264-2HD.srt");

  subIndex = 0;
  isPlaying = false;
  currSub = subs.get(subIndex);

  subs = sortArrayList(subs);
//  subs = selectRepeated(subs);
  
//  myWords = new String[2];
//  myWords[0] = "hello";
//  myWords[1] = "yeah";
//  subs = selectWords(subs, myWords);
  
//  for(Sub s : subs){
//    println(s.movie);
//  }  
  
  textSize(16);   
}
Movie currMovie;
void draw() {
  background(0);
  
  if (!isPlaying) {
    currSub = subs.get(subIndex);
    println(currSub.movie);
    if(currSub.movie.equals("portlandia_s03_e06")){
      currMovie = myMovies.get(0);
      myMovies.get(1).pause();
    }else{
      currMovie = myMovies.get(1);
      myMovies.get(0).pause();
    }
    
    currMovie.play();
    currMovie.jump(currSub.start);
    //    println(currSub.start);
    isPlaying = true;
  }

  image(myMovies.get(0), 0, 0);
  image(myMovies.get(1), 720, 0);
  image(currMovie, 0, 404);

  //Draw subtitle
  textAlign(CENTER);
  text(currSub.speech, width/2, height - 25);

  //Check subtitle ending
  if (currMovie.time() >= currSub.end) {
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
