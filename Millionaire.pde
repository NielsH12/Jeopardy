class Millionaire{
  Millionaire(List<Question> _questions){
    imageMode(CORNER);
    questions = _questions;
    
    numberOfQuestions = questions.size();

    logo.resize(width,height);
    background.resize(width, height);
    
    team = loadImage("data/Millionaire/team.png");
    fifty = loadImage("data/Millionaire/50.png");
    
    team.resize(100,0);
    fifty.resize(100,0);
    
    for(int i = 0; i < numberOfQuestions; i++){
      table.add(i+1 + " - $" + (i+1)*100);
    }
    
    /*
    table.add("1 - $100");
    table.add("2 - $200");
    table.add("3 - $300");
    table.add("4 - $400");
    table.add("5 - $500");
    table.add("6 - $600");
    table.add("7 - $700");
    */
  }
  
  void draw(){
    imageMode(CORNER);
    tick++;
    
    switch(internalState){
      case 0:
        intro();
      
      break;
      
      case 1:
        gamePaused();
      break;
      
      case 2:
        game();
      break;
        
      case 3: 
        question();
      break;
      
      case 4: 
        waiting();
      break;
      
      case 5: 
        correct();
      break;
      
      case 6: 
        incorrect();
      break;
      
      case 7:
        win();
      break;
      
      case 8:
        done();
      break;
      
      default:
      
      break;
      
      
    }

  }
  
  private void intro(){ // state 0
    // Start off with a black screen to build suspension
    if (tick == 1){
      // Play millionaire sound
      player.pause();
      player = minim.loadFile(sketchPath() + "/data/Millionaire/sound/main2.mp3",2048);
      player.play();
    }
    if(tick == 10){

      textFont(createFont("Arial", 32));
          
      // Display image
      image(logo,0,0);
    }
    
    if (tick > 10){
     image(logo,0,0); 
    }
  }
  
  private void gamePaused(){ // state 1
    image(background,0,0);
    image(fifty,width/2 - width/8*3,height/8);
    image(team,width/2 - width/8*3,height/8 * 2);
    
    int xh = width/5;
    int yh = height/2;
    
    int x = width/2 - xh/2;
    int y = height/2 - height/4;
        
    fill(color(02,05,36));
    stroke(92,193,255);
    strokeWeight(2);
    rect(x,y,xh,yh);
    textAlign(CENTER, CENTER);
    
    fill(255);
    for (int i = 0; i < table.size(); i++){
      if (i < questionIndex) {
        fill(color(0,200,0));
      } else {
        fill(255);
      }
      text(table.get(i), x+xh/2, y+yh - yh/table.size()*i - yh/table.size()*0.5);
    }
    
  }
  
  private void game(){ // state 2
    if (tick == 1){
      player.pause();
      player = minim.loadFile(sketchPath() + "/data/Millionaire/sound/play.mp3",2048);
      player.play();
    }
    
    image(background,0,0);
    image(fifty,width/2 - width/8*3,height/8);
    image(team,width/2 - width/8*3,height/8 * 2);
    
    // Draw the table
    int xh = width/5;
    int yh = height/2;
    
    int x = width/2 - xh/2;
    int y = height/2 - height/4;
        
    fill(color(02,05,36));
    stroke(92,193,255);
    strokeWeight(2);
    rect(x,y,xh,yh);
    textAlign(CENTER, CENTER);
    
    //fill(255);
    for (int i = 0; i < table.size(); i++){
      if (i == questionIndex) {
        fill(color(200,200,0));
      } else if (i < questionIndex) {
        fill(color(0,200,0));
      } else {
        fill(255);
      }
      text(table.get(i), x+xh/2, y+yh - yh/table.size()*i - yh/table.size()*0.5);
    }
    

    // Automatically switch to the question
    if (tick >= 150){ // should be 150
      tick = 0;
      internalState = 3;
      
    }
  }
  
  public void useTeam(){
    team = loadImage("data/Millionaire/teamused.png");
    team.resize(100,0);
  }
  
  public void useFifty(){
    fifty = loadImage("data/Millionaire/50used.png");
    fifty.resize(100,0);
  }
  
  private void question(){ // state 3
    if (tick == 1){
      player.pause();
      player = minim.loadFile(sketchPath() + "/data/Millionaire/sound/question.mp3",2048);
      player.play();
    }
 
    image(background,0,0);
    image(fifty,width/2 - width/8*3,height/8);
    image(team,width/2 - width/8*3,height/8 * 2);
    
    questions.get(questionIndex).draw();
    
  }
  
  private void waiting(){ // state 4
    if (tick == 1){
      player.pause();
      player = minim.loadFile(sketchPath() + "/data/Millionaire/sound/answer.mp3",2048);
      player.play();
    }
    
    image(background,0,0);
    image(fifty,width/2 - width/8*3,height/8);
    image(team,width/2 - width/8*3,height/8 * 2);
    
    questions.get(questionIndex).draw();
    
  }
  
    private void correct(){ // state 5
    if (tick == 1){
      player.pause();
      player = minim.loadFile(sketchPath() + "/data/Millionaire/sound/win.mp3",2048);
      player.play();
    }
    image(background,0,0);
    image(fifty,width/2 - width/8*3,height/8);
    image(team,width/2 - width/8*3,height/8 * 2);

    questions.get(questionIndex).draw();
    
  }
  
    private void incorrect(){ // state 6
    if (tick == 1){
      player.pause();
      player = minim.loadFile(sketchPath() + "/data/Millionaire/sound/lose.mp3",2048);
      player.play();
    }
    
    image(background,0,0);
    image(fifty,width/2 - width/8*3,height/8);
    image(team,width/2 - width/8*3,height/8 * 2);
    questions.get(questionIndex).draw();
    
  }
  
    private void win(){ // state 7
    if (tick == 1){
      player.pause();
      player = minim.loadFile(sketchPath() + "/data/Millionaire/sound/winAll.mp3",2048);
      player.play();
      questionIndex++;
    }
    

    
    image(background,0,0);
    
    int xh = width/5;
    int yh = height/2;
    
    int x = width/2 - xh/2;
    int y = height/2 - height/4;
        
    fill(color(02,05,36));
    stroke(92,193,255);
    strokeWeight(2);
    rect(x,y,xh,yh);
    textAlign(CENTER, CENTER);
    

    fill(color(0,200,0));
    for (int i = 0; i < table.size(); i++){
      text(table.get(i), x+xh/2, y+yh - yh/table.size()*i - yh/table.size()*0.5);
    }
  }
  
  private void done(){ // state 8
    if(tick == 1){
      quiz.currentlyPlaying.setValue(str(questionIndex * 100));
      println(questionIndex);
    }
    
    image(background,0,0);
    
    int xh = width/5;
    int yh = height/2;
    
    int x = width/2 - xh/2;
    int y = height/2 - height/4;
        
    fill(color(02,05,36));
    stroke(92,193,255);
    strokeWeight(2);
    rect(x,y,xh,yh);
    textAlign(CENTER, CENTER);
    
    fill(255);
    for (int i = 0; i < table.size(); i++){
      if (i < questionIndex) {
        fill(color(0,200,0));
      } else {
        fill(255);
      }
      text(table.get(i), x+xh/2, y+yh - yh/table.size()*i - yh/table.size()*0.5);
    }
    
  }

  
  void mousePressed(){
    switch(internalState){
      case 0:
        tick = 0;
        internalState = 1;
      
      break;
      
      case 1:
        tick = 0;
        internalState = 2;
        
      break;
      
      case 2:
        //tick = 0;
        //internalState = 3;
      break;
      
      case 3:
        if (questions.get(questionIndex).mousePressed()){
          tick = 0;
          internalState = 4;
        };
      break;
      
       case 4:
       if (questions.get(questionIndex).getCorrect()){
         if (questionIndex == numberOfQuestions-1){
           tick = 0;
           internalState = 7;
         } else {
          tick = 0;
          internalState = 5;
         }
       } else {
         tick = 0;
         internalState = 6;
       }
      break;
      
      case 5:
        questionIndex++;
        
        tick = 0;
        internalState = 1;
      break;
      
      case 6:
        tick = 0;
        internalState = 8;
      break;
      
      case 7:
        tick = 0;
        //questionIndex = 7;
        internalState = 8;
      break;
      
      case 8:
        tick = 0;
        internalState = 0;
        state = nextState;
      default:
      break;
    }
    
  }
  
  long tick = 0;
  PImage logo = loadImage("data/Millionaire/back.jpg");
  
  PImage background = loadImage("data/Millionaire/galaxy.jpg");
  
  PImage team;
  PImage fifty;
  
  /*
  Internal states of millionaire:
  0: intro
  1: game (paused)
  2: game
  3: question
  4: waiting for answer
  5: correct answer
  6: incorrect answer
  7: winning the game
  */
  
  /*
  Sevilla
  Bilbao
  Zaragoza
  Madrid
  */
  
  int internalState = 0;
  int questionIndex = 0;
  
  int numberOfQuestions = 0;
  
  JeopardyState nextState = JeopardyState.QUIZ; // default, return to main game after minigame

  List<Question> questions = new ArrayList<Question>();
  List<String> table = new ArrayList<String>();

};
