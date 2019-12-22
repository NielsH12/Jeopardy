// Jeopardy 2.0
import ddf.minim.*;
import java.util.Date;
import java.util.Arrays;
import java.util.List;

enum JeopardyState {
  INTRO(0),
  TEAM_SELECT(1),
  QUIZ(2),
  WINNING_SCREEN(3),
  ERROR_SCREEN(4);

  private final int value;

  private JeopardyState(int value) {
    this.value = value;
  }
  public JeopardyState nextState() {
    return JeopardyState.values()[this.value + 1];
  }
}

Minim minim;
AudioPlayer player;

TeamController TC;

Intro intro;
TeamSelect teamSelect;
Quiz quiz;
Winner winner;

Error error;
LightInterface linterface;

JeopardyState state = JeopardyState.INTRO; 

void setup(){
  fullScreen();
  frameRate(30);
  
  textAlign(CENTER, CENTER);
  
  surface.setTitle("Music Jeopardy");
  
  error = new Error();
  linterface = new LightInterface(this);
  linterface.start();
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

void draw(){
  background(0);
  
  switch(state){
    case INTRO:
      intro.draw();
      break;
      
    case TEAM_SELECT:
      teamSelect.draw();
      break;
      
    case QUIZ:
      quiz.draw();
      TC.draw();
      break;
      
    case WINNING_SCREEN:
      winner.draw(TC.winner);
      break;
      
    case ERROR_SCREEN:
      error.draw();
      break;
      
    default:
      break;
  }
}

void mousePressed(){
  switch(state){
    
    case INTRO:
      intro.click();
      break;
      
    case TEAM_SELECT:
      teamSelect.click();    
      break;
      
    case QUIZ:
      quiz.click(new PVector(mouseX, mouseY), mouseButton == LEFT);
      TC.click(new PVector(mouseX, mouseY), mouseButton == LEFT);      
      break;

    default:
      break;
  }
}

void mouseReleased(){
  switch(state){
    
    case INTRO:
      break;
      
    case TEAM_SELECT:
      teamSelect.mouseReleased();
      break;
      
    case QUIZ:
      break;
      
    case WINNING_SCREEN:
      break;
      
    default:
      break;
  }
}

void keyPressed(){
  switch(state){
    
    case INTRO:
      break;
      
    case TEAM_SELECT:
      teamSelect.keyPressed();
      break;
      
    case QUIZ:
      quiz.keyPressed();
      break;
      
    case ERROR_SCREEN:
      break;
      
    default:
      break;
  }
}
