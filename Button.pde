class Button{
  
  Button(color _c, String _value, String _song, String _answer, boolean _title){
    c = _c; // Current
    c0 = _c; // Passive
    c1 = color(0,0,120); // Playing
    c2 = color(200,200,0); // Waiting
    c3 = color(0, 200, 0); // Playing answer
    c4 = color(100, 100, 100); // Dead
    
    value = _value;
    backupValue = _value;
    
    song = _song;
    answer = _answer;
    state = 0;
    
    title = _title;
  }
  
  int getState(){
    return state;
  }
  
  void draw(){
    // Square
    fill(c);
    stroke(0);
    strokeWeight(15);
    rect(pos.x, pos.y, size.x, size.y);
    // Text
    if (title){
      textFont(createFont("Arial Bold", 46));
    } else {
      textFont(createFont("Arial", 46));
    }
    
    fill(color(255,255,0));
    textSize(46);
    
    if (title){
      text(value, pos.x + size.x / 2, pos.y + size.y / 2);
    } else {
      if (state != 4)
      text("$" + value, pos.x + size.x / 2, pos.y + size.y / 2);
    }
  }
  
  void click(){
    if (title) return;
    
    switch (state) {
      case 0:  // Button is passive
        if (mouseButton==LEFT){
          player.pause();
          player = minim.loadFile(song,2048);
          player.play();
          c = c1;
          state = 1;
        } else {
          c = c4;
          value = " ";
          state = 4;
        }
        break;
      
      case 1: // Button is playing
        if (mouseButton==LEFT){
          player.pause();
          c = c2;
          state = 2;
        } else {
          player.pause();
          c = c0;
          state = 0;
        }
        break;
          
      case 2: // Button is waiting
        if (mouseButton==LEFT){
          player = minim.loadFile(answer, 2048);
          player.play();
          c = c3;
          state = 3;
        } else {
          player.play();
          c = c1;
          state = 1;  
        }      
        break;
      
      case 3: // Button is playing answer
        if (mouseButton==LEFT) {
          player.pause();
          value = " ";
          c = c4;
          state = 4;
        } else {
          value = backupValue;
          player.pause();
          c = c1;
          state = 1;   
        }
        break;
        
      case 4: // Button is dead
        if (mouseButton==LEFT) {
          player.pause();
        } else {
          value = backupValue;
          player.pause();
          c = c0;
          c4 = color(100, 100, 100);
          state = 0;
        }
        break;
        
      default: 
        error.setError("Unexpected button state");
        break;
    }
  }
  
  void setPosition( PVector _pos){
    pos = _pos;
  }
  
  void setSize( PVector _size){
    size = _size;
  }
  
  void setColor(color _c){
    c = _c;
  }
  
  void setWinningColor(color _c){
    c4 = _c;
  }
  
  void setValue(String _value){
    value = _value;
    backupValue = _value;
  }
  
  String getValue(){
    return value;
  }
  
  void setSong(String _song){
    song = _song; 
  }
  
  boolean title; // If title, use bold font
  
  PVector pos;
  PVector size;
  
  color c; // Current color
  
  color c0; // Color in state 0 (Passive)
  color c1; // Color in state 1 (Playing)
  color c2; // Color in state 2 (Waiting)
  color c3; // Color in state 3 (Answer)
  color c4; // Color in state 4 (Dead)
  
  String value;
  String backupValue;
  
  int state;
  
  String song;
  String answer;
}; 
