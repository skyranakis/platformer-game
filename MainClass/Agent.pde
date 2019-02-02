//Any moving entity

public interface Agent
{
  public int step();        //For each timestep
  public void drawAgent();
  public int[][] getPosition();
}
