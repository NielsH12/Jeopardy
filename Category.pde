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
  
  Button click(int y, boolean left){
    int t = (int)Math.floor(y / (size.y / buttons.size()));
    
    buttons.get(t).click(left);
    return buttons.get(t);
  }
  
  public void setSize(PVector _size){
    size = _size;
    for (int i = 0; i < buttons.size(); i++){
      buttons.get(i).setPosition(new PVector(pos.x, size.y / buttons.size() * i));
      buttons.get(i).setSize(new PVector(size.x, size.y / buttons.size()));
    }
  }
  
  void draw(){
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
