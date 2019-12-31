class Team{
  Team(String _title, PVector _pos, PVector _size, color _c, boolean _blue){

    title = _title;
    pos = _pos;
    size = _size;
    c = _c;
    score = 0;
    scoreToAdd = 0;
    blueText = _blue;
  }
  
void click(){
  if (mouseButton == LEFT){
    if(mouseX > pos.x && mouseX < pos.x+size.x && mouseY > pos.y && mouseY < pos.y+size.y ){
      scoreToAdd += quiz.getPoints(c, true);
    }
  } else {
    if(mouseX > pos.x && mouseX < pos.x+size.x && mouseY > pos.y && mouseY < pos.y+size.y ){
      //score -= quiz.getPoints(c, false);
      scoreToAdd -= quiz.getPoints(c, false);
    }
  }
}

void draw(){
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

  textFont(createFont("Arial Bold", 36));
  fill(color(255,255,0));
  textSize(36);
  
  if(blueText){
    fill(color(0,0,255));
  }
  
  //textAlign(CENTER);
  text(title + ": " + score, pos.x + size.x / 2, pos.y + size.y / 2);
}

void setPos(PVector _pos){
  pos = _pos;
}

void setSize(PVector _size){
 size = _size; 
}

void turn(){
  turn = true; 
}

void noTurn(){
 turn = false; 
}

boolean blueText;
String title;
PVector pos;
PVector size;
color c;
int score;
int scoreToAdd;
boolean turn = false;
};
