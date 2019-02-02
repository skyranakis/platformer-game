//Contains the platforms, stairs, and other features that don't move and aren't interacted with
//Currently uses grid system, should NOT in future

public class Terrain
{
  private final int MAP_WIDTH;
  private final int MAP_HEIGHT;
  private final int NUM_HORIZ_BOXES;
  private final int NUM_VERT_BOXES;
  private final int BOX_WIDTH;
  private final int BOX_HEIGHT;
  private final String[][] MAP;
  
  public Terrain(){
    
    MAP_WIDTH = width;
    MAP_HEIGHT = height;
    NUM_HORIZ_BOXES = 100;
    NUM_VERT_BOXES = 50;
    BOX_WIDTH = MAP_WIDTH / NUM_HORIZ_BOXES;
    BOX_HEIGHT = MAP_HEIGHT / NUM_VERT_BOXES;
    
    MAP = new String[NUM_VERT_BOXES][NUM_HORIZ_BOXES];
    for (int c = 0; c < MAP[0].length; c++){
      MAP[0][c] = "Ground";
      for (int r = 1; r < MAP.length; r++){
        MAP[r][c] = "Open";
      }
    }
    createPlatform(100, 20, 300);
    createPlatform(150, 200, 30);
    createPlatform(650, 200, 400);
  }
  
  public void createPlatform(int startX, int startY, int len){
    int platStart = startX / BOX_WIDTH;
    int platHeight = startY / BOX_HEIGHT;
    int platLength = len / BOX_WIDTH;
    print(platStart+" "+platHeight+" "+platLength);
    int platEnd = platStart + platLength;
    if (platEnd > NUM_HORIZ_BOXES){
      platEnd = NUM_HORIZ_BOXES;
    }
    for (int i = platStart; i < platEnd; i++){
      MAP[platHeight][i] = "Ground";
    }
  }
  
  public boolean isInAir(Agent a){
    int[][] aPos = a.getPosition();
    int startX = aPos[2][0];
    int endX = aPos[3][0];
    int bottomY = aPos[2][1];
    //print(startX + "\t" + endX + "\t" + bottomY + "\n");
    for (int x = startX; x < endX; x++){
      if (typeAt(x, bottomY-1).equals("Ground")){
        return false;
      }
    }
    return true;
  }
  
  public String typeAt(int x, int y){
    int r = y / BOX_HEIGHT;
    int c = x / BOX_WIDTH;
    if ( r < 0 || c < 0 || r >= NUM_VERT_BOXES || c >= NUM_HORIZ_BOXES){
      return "Out";
    }
    return(MAP[r][c]);
  }
  
  public void drawTerrain(){
    for (int r=0; r<NUM_VERT_BOXES; r++){
      for (int c=0; c<NUM_HORIZ_BOXES; c++){
        String type = MAP[r][c];
        if (type.equals("Open")){
          stroke(255);
          fill(255);
        }else if (type.equals("Ground")){
          stroke(0);
          fill(0);
        }
        rect( c * BOX_WIDTH, height - (r + 1) * BOX_HEIGHT, BOX_WIDTH, BOX_HEIGHT);
      }
    }
  }
  
}
