void setGUI(){
  cp5 = new ControlP5(this);
  
  int top = 30;
  int left = 20;
  int cWidth = 200;
  int cHeight = 19;
  int cPadding = 4;
  int cX = cPadding;
  int cY = cPadding;

  Group g0 = cp5.addGroup("add")
//                .setMoveable(true)
                .setPosition(left, top)
                .setWidth(cWidth + 2 * cPadding)
                .setBackgroundHeight(cHeight + 2 * cPadding)
                .setBackgroundColor(color(0,50))            
                ;

  cp5.addButton("select")
     .setPosition(cX, cY)
     .setSize(cWidth, cHeight)
     .setCaptionLabel("Select files")
     .setGroup(g0)
     ;
     
  cX = cPadding;
  cY = cPadding;     
     
  Group g1 = cp5.addGroup("edit")
//                .setMoveable(true)
                .setPosition(left, top + cHeight * 3)
                .setWidth(cWidth + 2 * cPadding)
                .setBackgroundHeight(cHeight * 5)
                .setBackgroundColor(color(0,50))
                .disableCollapse()
                .setOpen(false)            
                ;
  
  cp5.addButton("sortAZ")
     .setPosition(cX, cY)
     .setSize(cWidth, cHeight)
     .setCaptionLabel("Sort")
     .setGroup(g1)
     ;       
  cY += cHeight + cPadding;   
  
  cp5.addButton("findRepeated")
     .setPosition(cX, cY)
     .setSize(cWidth, cHeight)
     .setCaptionLabel("Find repeated")
     .setGroup(g1)
     ;
   cY += cHeight + cPadding;
   
  cp5.addTextfield("Search for words")
     .setPosition(cX, cY)
//     .setAutoClear(false)
     .setSize(cWidth - 50, cHeight)
     .setGroup(g1)
     .setColorCaptionLabel(0);
     ;
  cX += cWidth - 50 + cPadding;
   
  cp5.addBang("searchForWords")
     .setPosition(cX, cY)
     .setSize(50 - cPadding, cHeight)
     .setCaptionLabel("Ok")
     .setGroup(g1)
     .getCaptionLabel()
     .align(ControlP5.CENTER, ControlP5.CENTER)
     ;               
  
  //Toggle visibility 
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      if(cp5.group("edit").isVisible()){
        cp5.group("edit").setVisible(false);
        cp5.group("add").setVisible(false);  
      }else{
        cp5.group("edit").setVisible(true);
        cp5.group("add").setVisible(true);
      }
    }
  }, '0');
}

void select() {
  println("called select");
  selectFolder("Select a folder to process:", "folderSelected");
}
