//For now, just calls the gameLoop, but it will eventually have menu options

private Game g;

void setup(){
  size(1000, 500);
  g = new Game();
}

void draw(){
  g.gameLoop();
}

void keyPressed(){
  g.handleKeyPress();
}
