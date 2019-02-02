//The player's character

public class Player implements Agent
{
  private int x;
  private int y;
  private double vX;
  private double vY;
  
  private boolean hasWon;
  
  public Player(){
    x = 0;
    y = 100;
    vX = 3;
    vY = 0;
    hasWon = false;
  }
  
  public int step(){
    x += vX;
    y += vY;
    if (x>=900){
      hasWon = true;
    }
    if (hasWon){
      return 1;
    }
    return 0;
  }
  
  public void drawAgent(){
    stroke(255, 0, 0);
    fill(255, 0, 0);
    rect(x, y, 100, 200);
  }
}
