//GUI
import controlP5.*;
ControlP5 cp5;
Accordion accordion;
CheckBox checkbox;

int cWidth = 300;
int cHeight = 19;
int cPadding = 4;
int cX = cPadding;
int cY = cPadding;
color myColor;

void setGUI(){
  cp5 = new ControlP5(this);
  
  myColor = color(2, 52, 77, 180);

  Group g0 = cp5.addGroup("add")
                .setPosition(0, 0)
                .setWidth(cWidth + 2 * cPadding)
                .setBackgroundHeight(cHeight + 2 * cPadding)
                .setBackgroundColor(myColor)            
                ;

  cp5.addButton("select")
     .setPosition(cX, cY)
     .setSize(cWidth/3, cHeight)
     .setCaptionLabel("Select files")
     .setGroup(g0)
     .getLabel()
//     .align(ControlP5.CENTER, ControlP5.CENTER)     
     ;
     
  cX = cPadding;
  cY = cPadding;             

  accordion = cp5.addAccordion("acc")
                 .setMoveable(true)
                 .setPosition(margin.x, margin.y)
                 .setWidth(cWidth + 2* cPadding)
                 .addItem(g0)
                 .setItemHeight(cHeight + 2 * cPadding)
//                 .addItem(g2)
                 ;
                 println(accordion.getColor());
                           
  accordion.open(0)
           .setCollapseMode(Accordion.MULTI);  
  
  //Toggle visibility 
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      if(accordion.isVisible()){
        accordion.setVisible(false);  
      }else{
        accordion.setVisible(true);
      }
    }
  }, '0');
}

void select() {
  selectFolder("Select a folder to process:", "folderSelected");
}

void folderSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    
    //Read files
    path = selection.getAbsolutePath();
    listMovieFiles();
  }
}

void listMovieFiles(){

  folder = new java.io.File(dataPath(path));
  String[] filenames = folder.list();
//  println(filenames[0]);

  StringList movieFiles = new StringList();
  for(String file : filenames){
//    println(file);
    String extension = file;
    while(extension.indexOf(".") != -1){
      extension = extension.substring(extension.indexOf(".") + 1);
    }
//    println("\t" + extension);    
    if(extension.equals("mp4") || extension.equals("mov")){
      movieFiles.append(file);
//      println("Found new movie: " + file);
    }
  }
  path += "/";
//  println(movieFiles);
  createMoviesList(movieFiles);
} 

void createMoviesList(StringList myList){
  
  Group g1 = cp5.addGroup("check")
                .setWidth(cWidth + 2 * cPadding)
                .setBackgroundHeight((myList.size() + 1) * (cHeight + cPadding) + cPadding)
                .setBackgroundColor(myColor)            
                ;
                
  cX = cPadding;
  cY = cPadding;
  checkbox = cp5.addCheckBox("checkBox")
                .setPosition(cX, cY)
                .setGroup(g1)
//                .setColorForeground(color(120))
//                .setColorActive(color(255))
                .setColorLabel(color(255))
                .setSize(cHeight, cHeight)
                .setItemsPerRow(1)
                .setSpacingRow(cPadding)
                ;  
  
  for(String s : myList){
    checkbox.addItem(s, 0);
  }
  cY += myList.size() * (cHeight + cPadding);
  
  cp5.addButton("addMovies")
     .setPosition(cX, cY)
     .setSize(cWidth/3, cHeight)
     .setGroup(g1)
     .setCaptionLabel("Add movies")
     ;  
  
  accordion.addItem(g1)
           .open(1)
           ;
}

void addMovies() {
  
  myMovies = new ArrayList<Movie>();
  subs = new ArrayList<Sub>();
  
//    println(checkbox.getItems());
  for (int i = 0 ; i < checkbox.getItems().size(); i++) {
    String filename = checkbox.getItem(i).getLabel();
    if(checkbox.getItem(i).getValue() > 0){
      //Movies
      Movie m = new Movie(this, path + filename); 
      myMovies.add(m);  //Add
      m.frameRate(30);  //Set the framerate 
      m.play();         //Pause at the first frame. 
      m.jump(m.duration()*0.25);
      m.pause();
      
      //Subtitles
      String tempFilename = filename;
      while(tempFilename.indexOf(".") != -1){
        tempFilename = tempFilename.substring(tempFilename.indexOf(".") + 1);
      }
      int index = filename.length() - tempFilename.length() - 1;
      String subtitle = filename.substring(0, index) + ".srt";
      //Add
      processSubs(m, path + subtitle);
    } 
  }
  
  //Playback settings
  subIndex = 0;
  isTalking = false;
  currSub = subs.get(subIndex);
  currMovie = myMovies.get(subIndex);
  
  addEditingFunctions();
}

void addEditingFunctions(){
  cX = cPadding;
  cY = cPadding;
  Group g2 = cp5.addGroup("edit")
//                .setPosition(cX, cY)
                .setWidth(cWidth + 2 * cPadding)
                .setBackgroundHeight(5 * (cHeight + cPadding) + cPadding)
//                .setBackgroundHeight(10 * cHeight)
                .setBackgroundColor(myColor)            
                ;                
  
  cp5.addButton("sortAZ")
     .setPosition(cX, cY)
     .setSize(cWidth/3, cHeight)
     .setCaptionLabel("Sort")
     .setGroup(g2)
     ;       
  cY += cHeight + cPadding;   
  
  cp5.addButton("findRepeated")
     .setPosition(cX, cY)
     .setSize(cWidth/3, cHeight)
     .setCaptionLabel("Find repeated")
     .setGroup(g2)
     ;
   cY += cHeight + cPadding;
   
  cp5.addTextfield("Search for words")
     .setPosition(cX, cY)
//     .setAutoClear(false)
     .setSize(cWidth - 50, cHeight)
     .setGroup(g2)
     .setColorCaptionLabel(color(255));
     ;
  cX += cWidth - 50 + cPadding;
   
  cp5.addBang("searchForWords")
     .setPosition(cX, cY)
     .setSize(50 - cPadding, cHeight)
     .setCaptionLabel("Ok")
     .setGroup(g2)
     .getCaptionLabel()
     .align(ControlP5.CENTER, ControlP5.CENTER)
     ;
  cX = cPadding;   
  cY += 2*cHeight + cPadding;

  cp5.addButton("playMovie")
     .setPosition(cX, cY)
     .setSize(cWidth/3, cHeight)
     .setCaptionLabel("Play movie")
     .setGroup(g2)
     ;
     
     accordion.addItem(g2)
              .open(2);
}

void sortAZ(){
  subs = sortArrayList(subs);
  if(subs.size() == 0){
    currSub = subs.get(subIndex);
    currMovie = currSub.movie;
  }  
}

void findRepeated(){
  subs = selectRepeated(subs);
//  println(subs.size());
  if(subs.size() == 0){
    msg = "It seems like this movie has no repeated lines. Quite unusual!";
  }else{
    currSub = subs.get(subIndex);
    currMovie = currSub.movie;
  }
}

void searchForWords(){

}

void playMovie(){      
      isPlaying = true;
}
