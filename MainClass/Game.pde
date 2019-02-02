//Runs the game

public class Game
{
  
  private int x;
  private Player player;
  
  public Game(){
    x = 0;
    player = new Player();
  }
  
  //Main game loop
  public void gameLoop(){
    delay(20);
    drawMap();
    int stepResult = player.step();
    player.drawAgent();
    if (stepResult == 1){
      drawWinMessage();
    }
  }
  
  public void handleKeyPress(){
    if (key == CODED){
      if (keyCode == UP){
        player.jump();
      }else if (keyCode == RIGHT){
        player.goRight();
      }else if (keyCode == LEFT){
        player.goLeft();
      }else if (keyCode == DOWN){
        player.duck();
      }else if (keyCode == SHIFT){
        player.charge();
      }
    }
  }
  
  public void handleKeyRelease(){
    if (key == CODED){
      if (keyCode == DOWN){
        player.endDuck();
      }
    }
  }
  
  //Draws the map
  public void drawMap(){
    background(255);
    fill(0, 0, 0);
    stroke(0, 0, 0);
    rect(0, 300, width, height-300);
  }
  
  //Draws the message as the result of a win
  public void drawWinMessage(){
    background(0);
    fill(255);
    textSize(64);
    text("You win!", 300, 200);
  }
}
