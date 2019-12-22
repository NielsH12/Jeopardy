class Quiz{
  Quiz(PVector _pos, PVector _size){
    size = _size;
    pos = _pos;
 }
  
  void draw(){
    for (int i = 0; i < categories.size(); i++){
       categories.get(i).draw();
    }
  }
  
  void keyPress(char key){
    if (key == 'q'){
      TC.findWinningTeam();
      state = Jeopardy.JeopardyState.WINNING_SCREEN;
    }
  }
  
  void keyPressed(){
    if (key == 'q'){
      TC.findWinningTeam();
      state = Jeopardy.JeopardyState.WINNING_SCREEN;
    }
  }
  
  void click(PVector click, boolean left){
    // Check that click was within Quiz window
    if(mouseX > pos.x && mouseX < pos.x + size.x && mouseY > pos.y && mouseY < pos.y + size.y){ 
      
      // Find which category was clicked
      int t = (int)Math.floor(mouseX / (size.x / categories.size())); 
      
      // Call click function on clicked category
      currentlyPlaying = categories.get(t).click(); 
    }
  }
  
  public int getPoints(color _c, boolean correct){
    if (currentlyPlaying == null) return 0;
    if (currentlyPlaying.state != 3) return 0;
    
    if (correct){
      currentlyPlaying.setWinningColor(_c);
    }
    return int(currentlyPlaying.value);
  }
  
  public void setSize(PVector _size){
    size = _size;
    for (int i = 0; i < categories.size(); i++){
      categories.get(i).setSize(new PVector(size.x / categories.size(), size.y));
    }
    
  }
  
  void load(String path){
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
