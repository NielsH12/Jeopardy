// Jeopardy New Year Edition
import ddf.minim.*;
import java.util.Date;
import java.util.Arrays;
import java.util.List;
import java.util.Random;
import processing.sound.*;
import processing.video.*;

ParticleSystem ps1;
ParticleSystem ps2;
ParticleSystem ps3;

enum JeopardyState {
  INTRO(0),
  TEAM_SELECT(1),
  QUIZ(2),
  WINNING_SCREEN(3),
  ERROR_SCREEN(4),
  RANDOMIZER_NAME(5),
  MILLIONAIRE_1(6),
  MILLIONAIRE_2(7),
  MILLIONAIRE_3(8),
  START_IMAGE(10),
  KARAOKE(20),
  VIDEO_1(21),
  VIDEO_2(22),
  VIDEO_3(23),
  VIDEO_4(24),
  VIDEO_5(25);

  private final int value;

  private JeopardyState(int value) {
    this.value = value;
  }
  public JeopardyState nextState() {
    return JeopardyState.values()[this.value + 1];
  }
}

Millionaire millionaire1;
Millionaire millionaire2;
Millionaire millionaire3;

List<Question> questions1 = new ArrayList<Question>();
List<Question> questions2 = new ArrayList<Question>();
List<Question> questions3 = new ArrayList<Question>();

List<Video> video = new ArrayList<Video>();

Minim minim;
AudioPlayer player;

TeamController TC;

Intro intro;
TeamSelect teamSelect;
Quiz quiz;
Winner winner;
Start start;
Karaoke karaoke;

Error error;
LightInterface linterface;

JeopardyState state = JeopardyState.INTRO; 

List<Button> themes;

void createThemes(){
  themes = new ArrayList <Button>();
  themes.add(new Button(color(0, 0, 200), "", "N/A", "N/A", true));
  themes.add(new Button(color(0, 0, 200), "Theme 1", "N/A", "N/A", true));
  themes.add(new Button(color(0, 0, 200), "Theme 2", "N/A", "N/A", true));
  themes.add(new Button(color(0, 0, 200), "Theme 3", "N/A", "N/A", true));
  themes.add(new Button(color(0, 0, 200), "Video", "N/A", "N/A", true));
  themes.add(new Button(color(0, 0, 200), "Theme 5", "N/A", "N/A", true));
  themes.add(new Button(color(0, 0, 200), "Karaoke", "N/A", "N/A", true));
  themes.add(new Button(color(0, 0, 200), "Theme 7", "N/A", "N/A", true));
  
  for (int i = 0; i < themes.size(); i++){
    themes.get(i).setSize(new PVector(width/6, height/9));
    themes.get(i).setPosition(new PVector(0, height/9 * (i)));  
  }
}


void setup(){
  //fullScreen();
  size(1920,1080);
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
  //quiz = new Quiz(new PVector(0,0), new PVector(width, height / 7 * 6));
  quiz = new Quiz(new PVector(width/6, 0), new PVector(width/6*5, height / 9 * 8));
  winner = new Winner();
  
  try {
    quiz.load("categories");
  } catch (Exception e) {
    error.setError("Couldn't load categories");
  }
  
  // New Year Edition Setup
  ps1 = new ParticleSystem(new PVector(width/4*1, 50));
  ps2 = new ParticleSystem(new PVector(width/4*2, 50));
  ps3 = new ParticleSystem(new PVector(width/4*3, 50));
  
  createThemes();
  createVideo();
  
  linterface = new LightInterface(this);
  linterface.start();
  
  karaoke = new Karaoke();
  
  start = new Start();
  
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
      for(int i = 0; i < themes.size(); i++){
        themes.get(i).draw();  
      }
      break;
      
    case WINNING_SCREEN:
      winner.draw(TC.winner);
      break;
      
    case ERROR_SCREEN:
      error.draw();
      break;
    
        case MILLIONAIRE_1:
      millionaire1.draw();
      break;
      
    case MILLIONAIRE_2:
      millionaire2.draw();
      
    case MILLIONAIRE_3:
      millionaire3.draw();
      
    case START_IMAGE:
      start.draw();
      break;
      
    case KARAOKE:
      karaoke.draw();
      break;
      
    case VIDEO_1:
      video.get(0).draw();
      break;      

    case VIDEO_2:
      video.get(1).draw();
      break;      

    case VIDEO_3:
      video.get(2).draw();
      break;      

    case VIDEO_4:
      video.get(3).draw();
      break;      

    case VIDEO_5:
      video.get(4).draw();
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
      quiz.click();
      TC.click();      
      break;

    case MILLIONAIRE_1:
      millionaire1.mousePressed();
      break;
      
    case MILLIONAIRE_2:
      millionaire2.mousePressed();
      
    case MILLIONAIRE_3:
      millionaire3.mousePressed();
      
    case START_IMAGE:
      start.mousePressed();
      break;
      
    case KARAOKE:
      karaoke.mousePressed();
      break;
      
    case VIDEO_1:
      video.get(0).mousePressed();
      break;      

    case VIDEO_2:
      video.get(1).mousePressed();
      break;      

    case VIDEO_3:
      video.get(2).mousePressed();
      break;      

    case VIDEO_4:
      video.get(3).mousePressed();
      break;      

    case VIDEO_5:
      video.get(4).mousePressed();
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

void createVideo(){
  video.add(new Video(sketchPath() + "/data/video/songs/1-song.mp4", sketchPath() + "/data/video/answers/1-answer.mp4", this));
  video.add(new Video(sketchPath() + "/data/video/songs/2-song.mp4", sketchPath() + "/data/video/answers/2-answer.mp4", this)  );
  video.add(new Video(sketchPath() + "/data/video/songs/3-song.mp4", sketchPath() + "/data/video/answers/3-answer.mp4", this));
  video.add(new Video(sketchPath() + "/data/video/songs/4-song.mp4", sketchPath() + "/data/video/answers/4-answer.mp4", this));
  video.add(new Video(sketchPath() + "/data/video/songs/5-song.mp4", sketchPath() + "/data/video/answers/5-answer.mp4", this));

  
  
  quiz.categories.get(0).buttons.get(4).setMinigame(JeopardyState.VIDEO_1); 
  quiz.categories.get(1).buttons.get(4).setMinigame(JeopardyState.VIDEO_2); 
  quiz.categories.get(2).buttons.get(4).setMinigame(JeopardyState.VIDEO_3); 
  quiz.categories.get(3).buttons.get(4).setMinigame(JeopardyState.VIDEO_4); 
  quiz.categories.get(4).buttons.get(4).setMinigame(JeopardyState.VIDEO_5); 
  

}

void movieEvent(Movie m) {
  m.read();
}
