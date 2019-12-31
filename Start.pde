class Start{
  Start(){
  for ( int i = 0; i <= 55; i++){
    imageMode(CENTER);
    images.add(loadImage("data/image/" + i + ".png"));

  }
    currentImage = images.get(imageIndex);
    currentImage.resize(0,height);
  }

  
  void draw(){
    strokeWeight(4);
    imageMode(CENTER);
    switch(internalState){
       case 0:
         fill(0,0);
         stroke(0,0,200);
         rect(0,0,width-2,height-2);

         break;
         
      case 1:

      
        image(currentImage, width/2, height/2);
        
         fill(0,0);
         stroke(200,200,0);
         rect(0,0,width-2,height-2);
        break;
        
      case 2:
        tick++;
        
        if (tick > 60){
          imageIndex++;
          if (imageIndex >= images.size()){
            
          } else {
            currentImage = images.get(imageIndex);
            currentImage.resize(0,height);
          }
          
          tick = 0;
        }
        
        image(currentImage, width/2, height/2);
        
        fill(0,0);
        stroke(0,0,120);
        rect(0,0,width-2,height-2);
        
        
        break;
      
      case 3:
         
        
        image(correctImage, width/2, height/2);
        
        fill(0,0);
        stroke(0, 200, 0);
        rect(0,0,width-2,height-2);
        
      default:
        break;
      }
  }
  
  void mousePressed(){
    if (mouseButton == LEFT){
      switch(internalState){
       case 0:
         internalState = 2;
         break;
         
      case 1:
        correctImage = images.get(0);
        correctImage.resize(0,height);
      
        internalState = 3;
        break;
        
      case 2:
        internalState = 1;
        break;
      
      case 3:
        stroke(0);
        state = nextState;
        
      default:
        break;
      }
    } else {
      switch(internalState){
       case 0:

         break;
         
      case 1:
        internalState = 2;
        break;
        
      case 2:

        break;
        
      case 3:
        imageMode(CORNER);
        internalState = 2;
        
      default:
        break;
      }      
    }
  }
  
  PImage currentImage;
  PImage correctImage;
  int tick = 0;
  
  // 0: Waiting
  // 1: Paused
  // 2: Running
  // 3: Answer
  
  int internalState = 0;
  
  int imageIndex = 1;
  
  boolean started = false;
  boolean running = false;
  
  List<PImage> images = new ArrayList<PImage>();
  JeopardyState nextState = JeopardyState.QUIZ; // default, return to main game after minigame
};
