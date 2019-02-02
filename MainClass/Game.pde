//Runs the game

import java.util.ArrayList;

public class Game
{
  
  private int x;
  private Player player;
  private ArrayList<Agent> enemies;
  private boolean hasWon;
  private boolean hasLost;
  
  public Game(){
    x = 0;
    player = new Player();
    enemies = new ArrayList();
    enemies.add(new BasicEnemy());
    hasWon = false;
    hasLost = false;
  }
  
  //Main game loop
  public void gameLoop(){
    delay(20);
    if (hasWon){
      drawWinMessage();
    }else if (hasLost){
      drawLossMessage();
    }else{
      drawMap();
      for (Agent a : enemies){
        a.step();
        a.drawAgent();
        if (player.collidesWith(a)){
          if (player.isAttacking()){
            a.hide();
            player.rewardForHit();
          }else{
            hasLost = true;
          }
        }
      }
      int stepResult = player.step();
      player.drawAgent();
      if (stepResult == 1){
        hasWon = true;
      }
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
  
  //Draws the message as the result of a loss
  public void drawLossMessage(){
    background(0);
    fill(255);
    textSize(64);
    text("You lose!", 300, 200);
  }
  
}
