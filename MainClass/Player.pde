//The player's character

public class Player implements Agent
{
  private int x;
  private int y;
  private double vX;
  private double vY;
  private double gravity;
  private double usualVX;
  
  private int pWidth;
  private int pHeight;
  
  private boolean hasWon;
  private boolean isOnGround;
  
  public Player(){
    x = 100;
    y = 400;
    vX = 0;
    vY = 0;
    gravity = -1;
    usualVX = 1;
    pWidth = 100;
    pHeight = 200;
    hasWon = false;
    isOnGround = true;
  }
  
  //Handles one timestep
  public int step(){
    
    x += vX;
    y += vY;
    if (!isOnGround){
      vY += gravity;
    }
    
    if (y - pHeight <= 200){
      y = pHeight + 200;
      vY = 0;
      isOnGround = true;
    }else{
      isOnGround = false;
    }
    
    //Temporary
    //if (x == 150 || x == 270 || x == 300 || x == 850){
      //jump();
    //}
    
    if (x >= 900){
      hasWon = true;
    }
    if (hasWon){
      return 1;
    }
    
    return 0;
  }
  
  //Causes it to jump
  public void jump(){
    if (isOnGround){
      vY = 20;
    }
  }
  
  //Causes it to go right at the usual speed
  public void goRight(){
    vX = usualVX;
  }
  
  //Causes it to go right at the usual speed
  public void goLeft(){
    vX = -usualVX;
  }
  
  //Draws the agent
  public void drawAgent(){
    stroke(255, 0, 0);
    fill(255, 0, 0);
    rect(x, height-y, 100, 200);
  }
}
