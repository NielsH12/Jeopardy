class Winner{
  Winner(){

  }
  
  void draw(String teamName){
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
