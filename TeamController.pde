class TeamController {
  TeamController(){
    teams = new ArrayList<Team>();
  }
  
  void addTeam(Team _team){
    teams.add(_team);
  }
  
  void draw(){
    if (teamSelect.noTeam == false){
      for (int i = 0; i < teams.size(); i++){
        teams.get(i).draw(); 
      }
    }

  }
  
  Team get(int i){
    return teams.get(i); 
  }
  
  void click(){
    for (int i = 0; i < teams.size(); i++){
      teams.get(i).click(); 
    }
    winner = findWinningTeam();
  }
  
  void fixTeamSizes(){
    for (int i = 0; i < teams.size(); i++){     
      teams.get(i).setSize(new PVector(width / teams.size(), height/9));
      teams.get(i).setPos(new PVector((width / teams.size()) * i, height / 9 * 8));
    }
  }
  
  
  
  String findWinningTeam(){
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
