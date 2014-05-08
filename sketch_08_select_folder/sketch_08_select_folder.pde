//Video
import processing.video.*;
Movie myMovie;

//GUI
import controlP5.*;
ControlP5 cp5;

//File system
java.io.File folder;
java.io.FilenameFilter mp4Filter = new java.io.FilenameFilter() {
  boolean accept(File dir, String name) {
    return name.toLowerCase().endsWith(".jpg");
  }
};

void setup() {
//  size(displayWidth, displayHeight);
  size(1033, 640);
  
  setGUI();  
}

void draw(){
  background(255); 
  if(myMovie != null){
    if(myMovie.width > width){
      image(myMovie, 0, 0, width, 400);
    }
  }
}

void folderSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    
    //Read files
    listMovieFiles(selection.getAbsolutePath());
    
    //Enable editing
    cp5.group("edit").enableCollapse();
  }
}

void movieEvent(Movie m) {
  m.read();
//  println(myMovie.time());
}

void listMovieFiles(String path){
  folder = new java.io.File(dataPath(path));
  String[] filenames = folder.list();
//  println(filenames[0]);
  myMovie = new Movie(this, path + "/" + filenames[0]);
  myMovie.loop();
  
//  for(String filename : filenames){
//    println(filename);
//    String extension = filename;
//    while(extension.indexOf(".") != -1){
//      extension = extension.substring(extension.indexOf(".") + 1);
//    }
////    println("\t" + extension);
//  }  

}
