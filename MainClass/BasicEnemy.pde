public class BasicEnemy implements Agent
{
  private int x;
  private int y;
  private int aWidth;
  private int aHeight;
  
  public BasicEnemy(){
    x = 400;
    y = 300;
    aWidth = 100;
    aHeight = 100;
  }
  
  public int step(){
    return 0;
  }
  
  public void drawAgent(){
    stroke(255, 0, 255);
    fill(255, 0, 255);
    rect(x, height-y, aWidth, aHeight);
  }
  
  //Returns position with row denoting vertex, ordered clockwise from top left, and columns denoting x and y
  public int[][] getPosition(){
    int[][] position = new int[4][2];
    position[0][0] = x;
    position[0][1] = y;
    position[1][0] = x+aWidth;
    position[1][1] = y;
    position[2][0] = x;
    position[2][1] = y+aHeight;
    position[3][0] = x+aWidth;
    position[3][1] = y+aHeight;
    return position;
  }
  
}
