import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ddf.minim.*; 
import java.util.Date; 
import java.util.Arrays; 
import java.util.List; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Jeopardy extends PApplet {

// Jeopardy 2.0





Minim minim;
AudioPlayer player;

TeamController TC;

Intro intro;
TeamSelect teamSelect;
Quiz quiz;
Winner winner;

Error error;

/*
  STATES:
  0: Intro
  1: Team select
  2: Quiz
  3: Winning screen
  4: Error screen
*/

int state; 

public void setup(){
  
  frameRate(30);
  
  textAlign(CENTER, CENTER);
  
  surface.setTitle("Music Jeopardy");
  
  error = new Error();

  minim = new Minim(this);
  File introSong = new File(sketchPath() + "/data/DefaultMusic/intro_song.mp3");
  if (introSong.exists()) {
    player = minim.loadFile(sketchPath() + "/data/DefaultMusic/intro_song.mp3", 2048);
    player.play();
  }
  
  TC = new TeamController();
  
  intro = new Intro(5);
  teamSelect = new TeamSelect();
  quiz = new Quiz(new PVector(0,0), new PVector(width, height / 7 * 6));
  winner = new Winner();
  
  try {
    quiz.load("categories");
  } catch (Exception e) {
    error.setError("Couldn't load categories");
  }
}

public void draw(){
  background(0);
  
  switch(state){
    case 0:
      intro.draw();
      break;
      
    case 1:
      teamSelect.draw();
      break;
      
    case 2:
      quiz.draw();
      TC.draw();
      break;
      
    case 3:
      winner.draw(TC.winner);
      break;
      
    case 4:
      error.draw();
      break;
      
    default:
    
      break;
  }
}

public void mousePressed(){
  switch(state){
    
    case 0:
      intro.click();
      break;
      
    case 1:
      teamSelect.click();    
      break;
      
    case 2:
      quiz.click(new PVector(mouseX, mouseY), mouseButton == LEFT);
      TC.click(new PVector(mouseX, mouseY), mouseButton == LEFT);
      
      break;
      
    default:
    
      break;
  }
}

public void mouseReleased(){
  switch(state){
    
    case 0:

      break;
      
    case 1:
      teamSelect.mouseReleased();
      break;
      
    case 2:

      break;
      
    case 3:
    
      break;
      
    default:
    
      break;
  }
}

public void keyPressed(){
  switch(state){
    
    case 0:
    
      break;
      
    case 1:
      teamSelect.keyPressed();
      break;
      
    case 2:
      quiz.keyPressed();
      break;
      
    case 3:
    
      break;
      
    default:
    
      break;
  }
}
class Button{
  
  Button(int _c, String _value, String _song, String _answer, boolean _title){
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
  
  public int getState(){
    return state;
  }
  
  public void draw(){
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
  
  public void click(){
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
  
  public void setPosition( PVector _pos){
    pos = _pos;
  }
  
  public void setSize( PVector _size){
    size = _size;
  }
  
  public void setColor(int _c){
    c = _c;
  }
  
  public void setWinningColor(int _c){
    c4 = _c;
  }
  
  public void setValue(String _value){
    value = _value;
    backupValue = _value;
  }
  
  public String getValue(){
    return value;
  }
  
  public void setSong(String _song){
    song = _song; 
  }
  
  boolean title; // If title, use bold font
  
  PVector pos;
  PVector size;
  
  int c; // Current color
  
  int c0; // Color in state 0 (Passive)
  int c1; // Color in state 1 (Playing)
  int c2; // Color in state 2 (Waiting)
  int c3; // Color in state 3 (Answer)
  int c4; // Color in state 4 (Dead)
  
  String value;
  String backupValue;
  
  int state;
  
  String song;
  String answer;
}; 
class Category{
  // Constructor
  Category(PVector _pos, PVector _size, String _path){
    buttons = new ArrayList <Button>();
    path = _path;
    size = _size;
    pos = _pos;
    
    // Load songs and store in array
    String songPath = sketchPath() + "/data/Categories/" + path + "/songs";
    String[] songs = listFileNames(songPath);
    Arrays.sort(songs);
    
    // Load answers and store in array    
    String answerPath = sketchPath() + "/data/Categories/" + path + "/answers";
    String[] answers = listFileNames(answerPath);
    Arrays.sort(answers);
    
    if(songs.length != answers.length){
      error.setError("Number of songs and answers in \"" + path + "\" does not match");
    }
    
    // Create buttons with songs and answers
    for (int j = 0; j < songs.length + 1; j++){
      
      String song = "";
      String answer = "";
      
      if (j == 0){
        buttons.add(new Button(color(0, 0, 200), _path, song, answer, true));
      } else {
        song = songPath + "/" + songs[j-1];
        answer = answerPath + "/" + answers[j-1];
        buttons.add(new Button(color(0, 0, 200), str(j * 100), song, answer, false));
      }
    }
    
    // Loop through buttons and set size and position
    for (int i = 0; i < buttons.size(); i++){
      buttons.get(i).setPosition(new PVector(pos.x, size.y / buttons.size() * i));
      buttons.get(i).setSize(new PVector(size.x, size.y / buttons.size()));
    }
  }
  
  // Public functions
  
  public Button click(){
    int t = (int)Math.floor(PApplet.parseInt(mouseY) / (size.y / buttons.size()));
    
    buttons.get(t).click();
    return buttons.get(t);
  }
  
  public void setSize(PVector _size){
    size = _size;
    for (int i = 0; i < buttons.size(); i++){
      buttons.get(i).setPosition(new PVector(pos.x, size.y / buttons.size() * i));
      buttons.get(i).setSize(new PVector(size.x, size.y / buttons.size()));
    }
  }
  
  public void draw(){
    for (int i = 0; i < buttons.size(); i++){
      buttons.get(i).draw(); 
    }
  }

  // Private functions
  private String[] listFileNames(String dir){
    File file = new File(dir);
    if (file.isDirectory()) {
      String names[] = file.list();
      return names;
    } else {
      error.setError("No directory found named " + dir);
      return new String[0];
    }
}

  List<Button> buttons;
  
  PVector pos = new PVector(0,0);
  PVector size = new PVector(0,0);
  
  int buttonWidth;
  int buttonHeight;
  
  String path;
  
  boolean finish;
};
class Error{
  Error(){
  }
  


  public void draw(){
    background(0);
    fill(color(255,255,255));
    textSize(36);
    
    text(error, width/2, height/2);
  }
  
  public void setError(String message){
    state = 4;
    error = message;
  }
  
  String error;

};
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
  
  public void draw(){
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
  

  

  
  public void click(){
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
class Quiz{
  Quiz(PVector _pos, PVector _size){
    size = _size;
    pos = _pos;
 }
  
  public void draw(){
    for (int i = 0; i < categories.size(); i++){
       categories.get(i).draw();
    }
  }
  
  public void keyPress(char key){
    if (key == 'q'){
      TC.findWinningTeam();
      state = 3;
    }
  }
  
  public void keyPressed(){
    if (key == 'q'){
      TC.findWinningTeam();
      state = 3;
    }
  }
  
  public void click(PVector click, boolean left){
    // Check that click was within Quiz window
    if(mouseX > pos.x && mouseX < pos.x + size.x && mouseY > pos.y && mouseY < pos.y + size.y){ 
      
      // Find which category was clicked
      int t = (int)Math.floor(mouseX / (size.x / categories.size())); 
      
      // Call click function on clicked category
      currentlyPlaying = categories.get(t).click(); 
    }
  }
  
  public int getPoints(int _c, boolean correct){
    if (currentlyPlaying == null) return 0;
    if (currentlyPlaying.state != 3) return 0;
    
    if (correct){
      currentlyPlaying.setWinningColor(_c);
    }
    return PApplet.parseInt(currentlyPlaying.value);
  }
  
  public void setSize(PVector _size){
    size = _size;
    for (int i = 0; i < categories.size(); i++){
      categories.get(i).setSize(new PVector(size.x / categories.size(), size.y));
    }
    
  }
  
  public void load(String path){
    String[] categoryNames = listFileNames(sketchPath() + "/data/" + path);  
    for (int i = 0; i < categoryNames.length; i++){
      categories.add(new Category( new PVector(size.x / categoryNames.length * i, pos.y), new PVector(size.x / categoryNames.length, size.y), categoryNames[i]));
    }
  }
  
  private String[] listFileNames(String dir){
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  } else {
    error.setError("No directory found named " + dir);
    return new String[0];
  }
}
  
  List<Category> categories = new ArrayList <Category>();
  
  PVector size = new PVector(0,0);
  PVector pos = new PVector(0,0);
  
  Button currentlyPlaying;
};
class Team{
  Team(String _title, PVector _pos, PVector _size, int _c, boolean _blue){

    title = _title;
    pos = _pos;
    size = _size;
    c = _c;
    score = 0;
    scoreToAdd = 0;
    blueText = _blue;
  }
  
public void click(PVector click, boolean left){
  if (left){
    if(click.x > pos.x && click.x < pos.x+size.x && click.y > pos.y && click.y < pos.y+size.y ){
      scoreToAdd += quiz.getPoints(c, true);
    }
  } else {
    if(click.x > pos.x && click.x < pos.x+size.x && click.y > pos.y && click.y < pos.y+size.y ){
      //score -= quiz.getPoints(c, false);
      scoreToAdd -= quiz.getPoints(c, false);
    }
  }
}

public void draw(){
  if (scoreToAdd > 1){
    score+=5;
    scoreToAdd-=5;
  } else if (scoreToAdd < -1){
    score-=5;
    scoreToAdd+=5;
  }
  if (turn){
    fill(255,255,0);
    rect(pos.x, pos.y, size.x, size.y);
    
    fill(c);
    rect(pos.x+5, pos.y+5, size.x-10, size.y-10);
  } else {
    fill(c);
    rect(pos.x, pos.y, size.x, size.y);    
  }

  textFont(createFont("Arial Bold", 46));
  fill(color(255,255,0));
  textSize(46);
  
  if(blueText){
    fill(color(0,0,255));
  }
  
  //textAlign(CENTER);
  text(title + ": " + score, pos.x + size.x / 2, pos.y + size.y / 2);
}

public void setPos(PVector _pos){
  pos = _pos;
}

public void setSize(PVector _size){
 size = _size; 
}

public void turn(){
  turn = true; 
}

public void noTurn(){
 turn = false; 
}

boolean blueText;
String title;
PVector pos;
PVector size;
int c;
int score;
int scoreToAdd;
boolean turn = false;
};
class TeamController {
  TeamController(){
    teams = new ArrayList<Team>();
  }
  
  public void addTeam(Team _team){
    teams.add(_team);
  }
  
  public void draw(){
    if (teamSelect.noTeam == false){
      for (int i = 0; i < teams.size(); i++){
        teams.get(i).draw(); 
      }
    }

  }
  
  public Team get(int i){
    return teams.get(i); 
  }
  
  public void click(PVector click, boolean left){
    for (int i = 0; i < teams.size(); i++){
      teams.get(i).click(click, left); 
    }
    winner = findWinningTeam();
  }
  
  public void fixTeamSizes(){
    for (int i = 0; i < teams.size(); i++){     
      teams.get(i).setSize(new PVector(width / teams.size(), height/7));
      teams.get(i).setPos(new PVector((width / teams.size()) * i, height / 7 * 6));
    }
  }
  
  
  
  public String findWinningTeam(){
    if (teamSelect.noTeam == false){

      int highScore = 0;
      winner = "";
      
      for (int i = 0; i < teams.size(); i++){
        if(teams.get(i).score > highScore){
          highScore = teams.get(i).score;
          winner = teams.get(i).title;
        } else if(teams.get(i).score == highScore){          
          if ( winner == "" ) {
            winner = teams.get(i).title;  
          } else {
            winner = winner + " & " + teams.get(i).title;  
          }
        }; 
      } 
    } else {
      winner ="Thanks for playing"; 
    }
    return winner;
  }
  
  
  List<Team> teams;
  String winner="Everybody wins";
};
class TeamSelect{
  TeamSelect(){
    sliderY = height/10 * 4;
    sliderHeight = height/5;
  }
  
  public void draw(){
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
    text(teamName, width/2 , height/10*1.5f);
  
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
    rect(width/2 - 200 - 20, sliderY + constrain(PApplet.parseInt(map(r,0,255,sliderHeight,0)),0,sliderHeight), 40, 2);
    rect(width/2 - 20, sliderY + constrain(PApplet.parseInt(map(g,0,255,sliderHeight,0)),0,sliderHeight), 40, 2);
    rect(width/2 + 200 - 20, sliderY + constrain(PApplet.parseInt(map(b,0,255,sliderHeight,0)),0,sliderHeight), 40, 2);
    
    // Add team button
    textSize(28);
    fill(color(255,128,0));
    rect(width/2 - 100, height/10 * 8, 200,50);
    fill(color(0,0,0));
    text("Add team", width/2 - 100 + 100, height/10 * 8 + 25);
    
    // Continue button
    fill(color(128,255,0));
    rect(width/2 - 100, height/10 * 8.75f, 200,50);
    fill(color(0,0,0));
    text("Start Game",width/2 - 100 + 100, height/10 * 8.75f + 25);
    
    // No teams
    fill(color(255,0,0));
    rect(width/2 - 100, height/10 * 9.5f, 200,50);
    fill(color(0,0,0));
    text("No teams",width/2 - 100 + 100, height/10 * 9.5f + 25);
    
    if (locked){
      colorName();
    }
  }
  
  public void keyPressed(){
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
  
  public void mouseReleased(){
    locked = false;
    currentColor = "";
  }
  
  public void click(){
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
      if ( teamName == "" ) {
        return;
      }
      boolean blueText = false;
      if (r > 180 && g > 180){
        blueText = true;
      }
      TC.addTeam(new Team(teamName, new PVector(0,0), new PVector(0,0), color(r,g,b), blueText));
      teamName = "";
      r = 0;
      g = 0;
      b = 0;
    } else if (mouseX > width/2 - 100 && mouseX < width / 2 + 100 && mouseY > height/10 * 8.75f && mouseY < height/10 * 8.75f + 50){ // Start Game Button
      if ( TC.teams.size() < 2 ) {
        return;
      }
      
      TC.fixTeamSizes(); 
      state++;
    } else if(mouseX > width/2 - 100 && mouseX < width / 2 + 100 && mouseY > height/10 * 9.5f && mouseY < height/10 * 9.5f + 50){ //Skip
      quiz.setSize(new PVector(width,height));
      noTeam = true;
      state++;
    }
      

  }
  
  public void colorName(){
    if (currentColor == "red"){
      r = PApplet.parseInt(map(mouseY, sliderY + sliderHeight, sliderY, 0, 255));
    } else if (currentColor == "green"){
      g = PApplet.parseInt(map(mouseY, sliderY + sliderHeight, sliderY, 0, 255));
    } else if (currentColor == "blue"){
      b = PApplet.parseInt(map(mouseY, sliderY + sliderHeight, sliderY, 0, 255));
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
class Winner{
  Winner(){

  }
  
  public void draw(String teamName){
    if (winningCounter == 0){
      player.pause();
      
      File winnerSong = new File(sketchPath() + "/data/DefaultMusic/victory_song.mp3");
      if (!winnerSong.exists()) {
        error.setError("Victory song not found");
      } else {
        player = minim.loadFile(sketchPath() + "/data/DefaultMusic/victory_song.mp3", 2048);
        player.play();
      }
    }
    
    background(color(0,0,255));

    int r = (int) winningCounter % 512;
    int g = (int) ((winningCounter*2)+85) % 512;
    int b = (int) ((winningCounter*3)+190) % 512;
    
    r = r - 255;
    g = g - 255;
    b = b - 255;
  
    textSize(map(winningCounter, 0, 10000, 72, 1000));
    fill(color(abs(r),abs(g),abs(b)));
    //textAlign(CENTER);
    text(teamName, width/2, height/2);
    
    winningCounter++;
  }
  
  float winningCounter = 0;

  
}
  public void settings() {  fullScreen(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Jeopardy" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
