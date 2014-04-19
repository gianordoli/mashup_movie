class Sub{
  String movie;
  int index;
  float start;
  float end;
  String speech;  
  
  Sub(String _movie, int _index, float _start, float _end, String _speech){
    movie = _movie;
    index = _index;
    start = _start;
    end = _end;
    speech = _speech;
  }
  
//  void display(){
//    noStroke();
//    if(movie == "weird_science"){
//      fill(255, 255, 60);
//      pos.x = width*1/6;
//    }else if(movie == "her"){
//      fill(255, 255, 200);
//      pos.x = width*3/6;
//    }
////    pos.x = width*1/3;
////    ellipse(pos.x, pos.y, size, size);
//      if(speech.indexOf("<i>") != -1){
//        textFont(italic);
//      }else{
//        textFont(regular);
//      }
//      text(speech, pos.x, pos.y);
//  }
}
