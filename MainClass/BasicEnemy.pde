public class BasicEnemy implements Agent
{
  private int x;
  private int y;
  private int aWidth;
  private int aHeight;
  private boolean hidden;
  
  public BasicEnemy(){
    x = 0;
    y = 0;
    aWidth = 10;
    aHeight = 10;
    hidden = false;
  }
  
  public BasicEnemy(int xPos, int yPos){
    x = xPos;
    y = yPos;
    aWidth = 10;
    aHeight = 10;
    hidden = false;
  }
  
  public int step(){
    return 0;
  }
  
  public void drawAgent(){
    if (!hidden){
      stroke(255, 0, 255);
      fill(255, 0, 255);
      rect(x, height-y-aHeight, aWidth, aHeight);
    }
  }
  
  //Returns position with row denoting vertex, ordered clockwise from top left, and columns denoting x and y
  public int[][] getPosition(){
    int[][] position = new int[4][2];
    position[0][0] = x;
    position[0][1] = y+aHeight;
    position[1][0] = x+aWidth;
    position[1][1] = y+aHeight;
    position[2][0] = x;
    position[2][1] = y;
    position[3][0] = x+aWidth;
    position[3][1] = y;
    return position;
  }
  
  public boolean getHidden(){
    return hidden;
  }
  
  public void hide(){
    hidden = true;
  }
  
}
