/*class Randomizer{
  Randomizer(List<String> _names){
    names = _names;  
    rand = new Random();
  }
  
  void draw(){
    background(color(0,0,255));
    textSize(72);
    textAlign(CENTER);
    fill(color(255,255,0));
    
    switch(internalState){
      case 0:
        text("?", width/2, height/2);
      break;

      case 1:
        tick++;
        drawName(tick * 10);
        if (tick >= 30){
          internalState = 2; 
        }
      break;
      
      case 2:
        textSize(106);
        fill(color(255,255,255));
        text(names.get(n), width/2, height/2);
      break;
      
      default:
      
      break;
    }
  }
  
  void drawName(int sleep){
    while (n == lastn){
    n = rand.nextInt(names.size());
    }
    lastn = n;
    
    text(names.get(n), width/2, height/2);
    delay(sleep);
  }
  
  void setNextState(int _nextState){
    nextState = _nextState;
  }
  
  void mousePressed(){
    println(internalState);
    switch(internalState){
      case 0:
        internalState = 1;
      break;
      
      case 1:
      
      break;
      
      case 2:
        state = nextState;
      break;
      
      default:
      
      break;
    }
  }
  
  List<String> names;
  
  int internalState = 0;
  
  int tick;
  
  int n;
  int lastn;
  
  int nextState = 0;
  
  Random rand;

  
};*/
