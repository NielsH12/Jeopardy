// Jeopardy 2.0
import ddf.minim.*;
import java.util.Date;
import java.util.Arrays;
import java.util.List;

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

void setup(){
  fullScreen();
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

void draw(){
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

void mousePressed(){
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

void mouseReleased(){
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

void keyPressed(){
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
