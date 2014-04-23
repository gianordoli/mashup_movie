float toSeconds(String myTime) {
//  println(myTime);
  int hours = parseInt(myTime.substring(0, 2));
  int minutes = parseInt(myTime.substring(3, 5));
  float seconds = parseFloat(myTime.substring(6, myTime.indexOf(',')));
  float milliseconds = parseFloat(myTime.substring(myTime.indexOf(',') + 1)) / 1000;
//  seconds += milliseconds;
//  println("h: " + hours + ", min: " + minutes + ", s: " + seconds);
  seconds += (60 * minutes) + (3600 * hours) + milliseconds;
//  println(seconds);
  return seconds;
}
