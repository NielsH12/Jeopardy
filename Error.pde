class Error{
  Error(){
  }
  


  void draw(){
    background(0);
    fill(color(255,255,255));
    textSize(36);
    
    text(error, width/2, height/2);
  }
  
  void setError(String message){
    state = 4;
    error = message;
  }
  
  String error;

};
