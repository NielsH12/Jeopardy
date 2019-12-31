class Question{
  Question(String _question, String s1, String s2, String s3, String s4, int _correct){
    
    answers = new ArrayList<String>();
    answers.add(s1);
    answers.add(s2);
    answers.add(s3);
    answers.add(s4);
    
    question = _question;
    
    correct = _correct;
    
    butColors.add(color(02,05,36));
    butColors.add(color(02,05,36));
    butColors.add(color(02,05,36));
    butColors.add(color(02,05,36));
    
    rand = new Random();
  }
  
  void draw(){
    tick++;
    if (internalState == 1){
      if (tick == 1){
        while (n1 == correct || n1 == -1){
          n1 = rand.nextInt(3);
        }
        while (n2 == correct || n2 == n1 || n2 == -1){
          n2 = rand.nextInt(3);
        }

        player.pause();
        player = minim.loadFile(sketchPath() + "/data/Millionaire/sound/fifty.mp3",2048);
        player.play();
        
        answers.set(n1, "");
        answers.set(n2, "");
      } else if(tick == 30){

        
        tick = 0;
        internalState = 3;
        
      }
    } else if (internalState == 2){
      if (tick >= 20){ // dependent on frameRate
        tick = 0;
        phoneTime--;
        if (phoneTime == -1){
          internalState = 3;
          frameRate(30);
          tick = 0;
        }
      }
      if (phoneTime >= 0){
        ellipseMode(RADIUS);
        fill(color(02,05,36));
        stroke(92,193,255);
        strokeWeight(2);
        ellipse(width/2,height/3,ellipseSize,ellipseSize);
        
        if (ellipseSize > 0){
          ellipseSize--;
        }
        
        fill(color(200,200,0));
        textFont(createFont("Arial", 106));
        text(phoneTime, width/2, height/3);  
        textFont(createFont("Arial", 32));
      }
      
      
    } else if (internalState == 3){
      if(tick >= 45){
        player.pause();
        player = minim.loadFile(sketchPath() + "/data/Millionaire/sound/question.mp3",2048);
        player.play();
        tick = 0;
        internalState = 0;
      }
    }
    
    // Draw question box
    fill(color(02,05,36));
    stroke(92,193,255);
    strokeWeight(2);
    rect(questionX, questionY, questionWidth, questionHeight, 10);
    
    // Draw answer boxes
    fill(butColors.get(0));
    rect(x1,y1,answerWidth, answerHeight, 10);
    
    fill(butColors.get(1));
    rect(x2,y1,answerWidth, answerHeight, 10);
    
    fill(butColors.get(2));
    rect(x1,y2,answerWidth, answerHeight, 10);
    
    fill(butColors.get(3));
    rect(x2,y2,answerWidth, answerHeight, 10);
    
    // Write question
    textAlign(CENTER, CENTER);
    fill(255);
    text(question, questionX + questionWidth/2, questionY + questionHeight/2);
    
    // Write answers
    text(answers.get(0), x1 + answerWidth/2, y1 + answerHeight/2);
    text(answers.get(1), x2 + answerWidth/2, y1 + answerHeight/2);
    text(answers.get(2), x1 + answerWidth/2, y2 + answerHeight/2);
    text(answers.get(3), x2 + answerWidth/2, y2 + answerHeight/2);
  }
  
  boolean getCorrect(){
    boolean r = answer == correct;
    if (r){
      butColors.set(answer, color(0,200,0));
    } else {
      butColors.set(answer, color(200,0,0));
    }
    return r;
  }
  
  boolean mousePressed(){
    if (mouseX >= x1 && mouseX < x1 + answerWidth){
      if(mouseY >= y1 && mouseY < y1 + answerHeight){
        //1st one
        println(0);
        answer = 0;
        butColors.set(0, color(200,200,0));
        return true;
      }
      else if(mouseY >= y2 && mouseY < y2 + answerHeight) {
        //3rd one
        println(2);
        answer = 2;
        butColors.set(2, color(200,200,0));
        return true;
      }
    }
    else if (mouseX >= x2 && mouseX < x2 + answerWidth){
      if(mouseY >= y1 && mouseY < y1 + answerHeight){
        //2nd one
        println(1);
        answer = 1;
        butColors.set(1, color(200,200,0));
        return true;
      }
      else if(mouseY >= y2 && mouseY < y2 + answerHeight){
        //4th one
        println(3);
        answer = 3;
        butColors.set(3, color(200,200,0));
        return true;
      }
    }
    
    if(mouseX >= width/2 - width/8*3 && mouseX <= width/2 - width/8*3 + 100){

      if (mouseY >= height/8 && mouseY <= height/8 + 77){
        println("fifty");
        
        // Switch fifty
        dad.useFifty();

        tick = 0;
        internalState = 1;
      } else if (mouseY >= height/8 * 2 && mouseY<= height/8*2 + 77){
        println("team"); 
        
        // Switch team
        dad.useTeam();
        
        frameRate(20);
        
        internalState = 2;
        tick = 0;
        phoneTime = 16;
        ellipseSize = 320; // dependent on frameRate
        player.pause();
        player = minim.loadFile(sketchPath() + "/data/Millionaire/sound/team2.mp3",2048);
        player.play();
      } 
    } else { print("no match"); }
    
    return false;
  }
  
  public void setDad(Millionaire _dad){    
    dad = _dad;
  }

  /*
  0: default
  1: fifty
  2: team
  3: pause, then return to default
  */
  int internalState = 0;
  
  int n1 = -1; // Random questions to remove when using 50:50 lifeline
  int n2 = -1;

  long tick;
  
  int phoneTime = 16; // How much time is left when using the "call a friend" lifeline
  int ellipseSize = 320;
  
  String question;
  private List<String> answers;
  
  int questionWidth = width/8*6;
  int questionHeight = height/8;
  int questionX = width/2 - width/8*3;
  int questionY = height/2 + height/8;
  
  int answerWidth = int(questionWidth/2.2);
  int answerHeight = height/16;
  
  int x1 = questionX;
  int x2 = int(questionX + questionWidth - answerWidth);
  int y1 = int(height/2 + height/8*2.5);
  int y2 = int(height/2 + height/8*3.2);
  
  int answer;
  
  int correct;
  
  List<Integer> butColors = new ArrayList<Integer>();
  
  Random rand;
  
  Millionaire dad;
  
};
