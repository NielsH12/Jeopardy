class TeamSelect{
  TeamSelect(){
    sliderY = height/10 * 4;
    sliderHeight = height/5;
  }
  
  void draw(){
    // Repeat intro song until game starts
    if (!player.isPlaying()) {
      player = minim.loadFile(sketchPath() + "/data/DefaultMusic/intro_song.mp3", 2048);
      player.play();
    }
    background(color(0,0,255));
  
    // Enter team name
    textSize(36);
    fill(color(255, 255, 0));
    //textAlign(CENTER);
    text("Enter team name", width/2 , height/10);
    text(teamName, width/2 , height/10*1.5);
  
    // Color preview
    fill(color(r,g,b));
    rect(width/2 - 100, height/10 * 2, 200,50);
    
    // Red selector
    fill(color(255,0,0));
    rect(width/2 - 200 - 20, sliderY, 40, sliderHeight);
    
    // Green selector
    fill(color(0,255,0));
    rect(width/2 - 20, sliderY, 40, sliderHeight);
    
    // Blue selector
    fill(color(0,0,255));
    rect(width/2 + 200 - 20, sliderY, 40, sliderHeight);
    
    // Sliders
    fill(color(0,0,0));
    rect(width/2 - 200 - 20, sliderY + constrain(int(map(r,0,255,sliderHeight,0)),0,sliderHeight), 40, 2);
    rect(width/2 - 20, sliderY + constrain(int(map(g,0,255,sliderHeight,0)),0,sliderHeight), 40, 2);
    rect(width/2 + 200 - 20, sliderY + constrain(int(map(b,0,255,sliderHeight,0)),0,sliderHeight), 40, 2);
    
    // Add team button
    textSize(28);
    fill(color(255,128,0));
    rect(width/2 - 100, height/10 * 8, 200,50);
    fill(color(0,0,0));
    text("Add team", width/2 - 100 + 100, height/10 * 8 + 25);
    
    // Continue button
    fill(color(128,255,0));
    rect(width/2 - 100, height/10 * 8.75, 200,50);
    fill(color(0,0,0));
    text("Continue",width/2 - 100 + 100, height/10 * 8.75 + 25);
    
    // No teams
    fill(color(255,0,0));
    rect(width/2 - 100, height/10 * 9.5, 200,50);
    fill(color(0,0,0));
    text("No teams",width/2 - 100 + 100, height/10 * 9.5 + 25);
    
    if (locked){
      colorName();
    }
  }
  
  void keyPressed(){
    if (key == BACKSPACE){
      if (teamName.length() > 0){
        teamName = "";
        //teamName = teamName.replace(teamName.substring(teamName.length()-1), "");
      }
    } else if (key == ' '){
        teamName = teamName + ' ';
    } else if (key != CODED){
      teamName += key;
    } 
  }
  
  void mouseReleased(){
    locked = false;
    currentColor = "";
  }
  
  void click(){
    if (mouseY > sliderY && mouseY < sliderY + sliderHeight){
      if (mouseX > width/2 - 200 - 20 && mouseX < width/2 - 200 - 20 + 40){
        locked = true;
        currentColor = "red";
      } else if (mouseX > width/2 - 20 && mouseX < width/2 - 20 + 40){
        locked = true;
        currentColor = "green";
      } else if (mouseX > width/2 + 200 - 20 && mouseX < width/2 + 200 - 20 + 40){
        locked = true;
        currentColor = "blue";
      } //    rect(width/2 - 100, height/10 * 8, 200,50);
    } else if (mouseX > width/2 - 100 && mouseX < width / 2 + 100 && mouseY > height/10 * 8 && mouseY < height/10 * 8 + 50){ // Add team button
    
      boolean blueText = false;
      if (r > 180 && g > 180){
        blueText = true;
      }
      TC.addTeam(new Team(teamName, new PVector(0,0), new PVector(0,0), color(r,g,b), blueText));
      teamName = "";
      r = 0;
      g = 0;
      b = 0;
    } else if (mouseX > width/2 - 100 && mouseX < width / 2 + 100 && mouseY > height/10 * 8.75 && mouseY < height/10 * 8.75 + 50){ // Continue button
      TC.fixTeamSizes();
      
      state++;
    } else if(mouseX > width/2 - 100 && mouseX < width / 2 + 100 && mouseY > height/10 * 9.5 && mouseY < height/10 * 9.5 + 50){ //Skip
      quiz.setSize(new PVector(width,height));
      noTeam = true;
      state++;
    }
      

  }
  
  void colorName(){
    if (currentColor == "red"){
      r = int(map(mouseY, sliderY + sliderHeight, sliderY, 0, 255));
    } else if (currentColor == "green"){
      g = int(map(mouseY, sliderY + sliderHeight, sliderY, 0, 255));
    } else if (currentColor == "blue"){
      b = int(map(mouseY, sliderY + sliderHeight, sliderY, 0, 255));
    }
  }
  
  int sliderY;
  int sliderHeight;
  
  String teamName = "";
  
  boolean locked = false;
  public boolean noTeam = false;
  
  String currentColor = "";
  
  int r = 0;
  int g = 0;
  int b = 0;
}
