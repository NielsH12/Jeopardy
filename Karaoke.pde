class Karaoke{
  Karaoke(){


  }
  
  void draw(){
    fill(c);
    ellipse(width/2, height/2, 200, 200);
  }
  
  void mousePressed(){
    
    switch(internalState){
      case 0:
        internalState = 1;
        c = color(0,0,120);
        break;
      
      case 1:
        if (mouseButton == LEFT){
          internalState = 2;
          c = color(200,200,0);
        } else {
          c = color(0,0,200);
          internalState = 0;
        }
        break;
      
      case 2:
        if (mouseButton == LEFT){
          internalState = 3;
          c = color(0,200,0);
        } else {
          c = color(0,0,120);
          internalState = 1;
        }
        break;
      
      case 3:
        if (mouseButton == LEFT){
          internalState = 0;
          c = color(0,0,200);
          state = nextState;
        } else {
          c = color(200,200,0);
          internalState = 2;
        }
        break;      
      
      
      
      
    }

  }

  
  // 0 Passive
  // 1 Playing
  // 2 Waiting
  // 3 Playing Answer
  // 4 Done
  
  color c = color(0,0,200);
  int internalState = 0;
  boolean increasing = true;
  JeopardyState nextState = JeopardyState.QUIZ; // default, return to main game after minigame
  long tick = 10;
  


};
