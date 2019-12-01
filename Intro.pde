class Intro{
  Intro(int _introCounter){
    introCounter = _introCounter * 30;
    introCounterBackup = _introCounter * 30;
    

    file = new File(sketchPath() + "/data/credit.txt");
    
    if(file.exists()){
      author = loadStrings(sketchPath() + "/data/credit.txt");
      credit = true;
    }
    
  }
  
  void draw(){
    background(color(0,0,255));
    
    fill(color(255, 255, 0, map(introCounter, introCounterBackup, 120, 0, 255)));
    textSize(72);
    //textAlign(CENTER);
    text("Music Jeopardy", width/2, height/2 - 25);
    
    fill(color(255, 255, 0, map(introCounter, introCounterBackup - 10, 10, 0, 255)));
    textSize(18);
    //textAlign(CENTER);
    text("By Niels Hvid", width/2, height/2 + 35);
    
    if (credit){
      fill(color(255, 255, 0, map(introCounter, introCounterBackup - 60, 60, 0, 255)));
      textSize(36);
      //textAlign(CENTER);
      text("Music by " + author[0], width/2, height/2 + 125);
    }
    
    introCounter--;
    
    if (introCounter <= 0){
      state++;
    } 
  }
  

  

  
  void click(){
    if (state == 0){
      if (mouseButton == RIGHT){
        introCounter = 0;
      }
    }
  }
  
  float introCounter;
  float introCounterBackup;
  
  boolean credit = false;
  
  File file;
  
  String[] author;
}
