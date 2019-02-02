//For now, just calls the gameLoop, but it will eventually have menu options

private Game g;

void setup(){
  size(1000, 500);
  g = new Game();
}

void draw(){
  g.gameLoop();
}

//Restarts game
void mousePressed(){
  if (g.isGameOver()){
    g = new Game();
  }
}

void keyPressed(){
  g.handleKeyPress();
}

void keyReleased(){
  g.handleKeyRelease();
}
