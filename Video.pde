class Video{
  Video(String _filename, String _answername, PApplet applet){
    filename = _filename;
    answername = _answername;
    intenalState = 0;
    movie = new Movie(applet, filename);
    answer = new Movie(applet, answername);
    //movie.width = 1920;
    //movie.height = 1080;
    
    //answer.width = 1920;
    //answer.height=1080;
  }
  
  void draw(){
    switch(intenalState){
      case 1:
      case 2:
        imageMode(CENTER);
        image(movie, width / 2, height/2);
        break;
      case 3:
        imageMode(CENTER);
        image(answer, width / 2, height/2);  
        break;
    }
  }
  
  
  /* STATES:
  0 Waiting
  1 Playing movie
  2 Paused
  3 Playing answer
  4 Dead
  
  
  
  */
  
  
  
  
  void mousePressed(){
    println("Video mouse pressed");
    switch (intenalState){
      case 0:
        println("state was 0");
        if (mouseButton == LEFT){
          //movie.jump(0);
          movie.play();
          movie.volume(1);
          
          intenalState = 1;
        }
        else{
          //movie.jump(result);
          //movie.play();
          //movie.volume(1);

          //player.pause();
          
          //intenalState = 4;
        }
        
        break;
        
      case 1:
      println("state was 1");
        if (mouseButton == LEFT){
          movie.pause();
          //player.pause();
          intenalState = 2;
        }
        else{
          movie.stop();
          answer.stop();
          player.pause();
          intenalState = 0;
        }
        break;

      case 2:
        println("state was 2");
        if (mouseButton == LEFT){
          movie.stop();
          
          //answer.jump(0);
          answer.play();
          answer.volume(1);
          
          intenalState = 3;
        }
        else{
          movie.play();
          movie.volume(0);
          
          player.play();
          
          intenalState = 1;
        }
        break;

      case 3:
        println("state was 3");
        if (mouseButton == LEFT){
          answer.stop();
          intenalState = 4;
          state = nextState;
        }
        else{
          movie.pause();
          intenalState = 2;
        }
        
        break;

      case 4:
        
        break;

      default:
        break;
    }
    println("State: " + intenalState);
  }
  
  int intenalState;
  
  String filename;
  String answername;
  
  Movie movie;
  Movie answer;
  JeopardyState nextState = JeopardyState.QUIZ; // default, return to main game after minigame

};
