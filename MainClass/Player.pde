//The player's character

public class Player implements Agent
{
  private int x;
  private int y;
  private double vX;
  private double vY;
  
  private int chargeCounter;
  private int dazeCounter;
  
  private final double GRAVTIY;
  private final double JUMPAMOUNT;
  private final double USUALVX;
  private final double DUCKSHRINKAMOUNT;
  private final double CHARGEAMOUNT;
  private final int CHARGETIME;
  private final int DAZETIME;
  
  private int pWidth;
  private int pHeight;
  
  private boolean hasWon;
  private boolean inAir;
  private boolean ducking;
  private boolean charging;
  private boolean chargeSuccessful;
  private boolean dazed;
  private boolean hidden;
  
  private Terrain terrain;
  
  public Player(Terrain t){
    
    x = 100;
    y = 200;
    vX = 0;
    vY = 0;
    
    chargeCounter = -1;
    
    GRAVTIY = -1;
    JUMPAMOUNT = 20;
    USUALVX = 8;
    DUCKSHRINKAMOUNT = 101;
    CHARGEAMOUNT = 3;
    CHARGETIME = 20;
    DAZETIME = 50;    //Always: DAZETIME > CHARGETIME * (CHARGEAMOUNT - 1)
    
    pWidth = 100;
    pHeight = 200;
    
    hasWon = false;
    inAir = false;
    ducking = false;
    charging = false;
    chargeSuccessful = false;
    dazed = false;
    hidden = false;
    
    terrain = t;
  }
  
  //Handles one timestep
  public int step(){
    
    x += vX;
    y += vY;
    
    if (terrain.isInAir(this)){
      inAir = true;
      vY += GRAVTIY;
    }else if (inAir){    //So it's on the ground, but was just in the air -> landing
      land();
    }
    
    chargeCounter--;
    dazeCounter--;
    if (chargeCounter == 0){
      endCharge();
    }
    if (dazeCounter == 0){
      endDaze();
    }
    
    if (x+pWidth >= 1000){
      hasWon = true;
    }
    if (hasWon){
      return 1;
    }
    
    return 0;
  }
  
  //Returns position with row denoting vertex, ordered clockwise from top left, and columns denoting x and y
  //Note: charging doesn't actually tilt the agent
  public int[][] getPosition(){
    int[][] position = new int[4][2];
    position[0][0] = x;
    position[0][1] = y+pHeight;
    position[1][0] = x+pWidth;
    position[1][1] = y+pHeight;
    position[2][0] = x;
    position[2][1] = y;
    position[3][0] = x+pWidth;
    position[3][1] = y;
    return position;
  }
  
  //Determines if the player collides with the other agent
  public boolean collidesWith(Agent a){
    if (a.getHidden()){
      return false;
    }
    int[][] agentPos = a.getPosition();
    int agentLeft = agentPos[0][0];
    int agentRight = agentPos[1][0];
    int agentTop = agentPos[0][1];
    int agentBottom = agentPos[2][1];
    int playerLeft = x;
    int playerRight = x+pWidth;
    int playerTop = y+pHeight;
    int playerBottom = y;
    return (agentRight >= playerLeft && agentLeft <= playerRight && agentBottom <= playerTop && agentTop >= playerBottom);
  }
  
  //Causes it to jump
  public void jump(){
    if (!inAir && !dazed && !charging){
      vY = JUMPAMOUNT;
      endDuck();
    }
  }
  
  //Handles landing
  private void land(){
    y = 200; //Fix later
    vY = 0;
    inAir = false;
  }
  
  //Causes it to go right at the usual speed
  public void goRight(){
    if (!dazed && !inAir && !charging){
      vX = USUALVX;
    }
  }
  
  //Causes it to go right at the usual speed
  public void goLeft(){
    if (!dazed && !inAir && !charging){
      vX = -USUALVX;
    }
  }
  
  //Causes it to duck
  public void duck(){
    if (!inAir && !dazed && !charging && !ducking){
      ducking = true;
      pHeight -= DUCKSHRINKAMOUNT;
    }
  }
  
  //Causes it to end the duck
  public void endDuck(){
    if (ducking){
      ducking = false;
      pHeight += DUCKSHRINKAMOUNT;
    }
  }
  
  //Causes it to charge
  public void charge(){
    if (!inAir && !dazed && !charging){
      charging = true;
      vX *= CHARGEAMOUNT;
      chargeCounter = CHARGETIME;
      chargeSuccessful = false;
      endDuck();
    }
  }
  
  //Causes it to end charge
  private void endCharge(){
    if (charging){
      charging = false;
      vX /= CHARGEAMOUNT;
      if (!chargeSuccessful){
        startDaze();
      }
    }
  }
  
  //Returns true if the player is attacking
  public boolean isAttacking(){
    return charging;
  }
  
  //Lets the player know that is has hit an enemy
  public void rewardForHit(){
    if (charging){
      chargeSuccessful = true;
    }
  }
  
  //Starts the daze
  private void startDaze(){
    dazed = true;
    vX = 0;
    dazeCounter = DAZETIME;
    pWidth *= 2;
    pHeight /= 2;
  }
  
  //Ends the daze
  private void endDaze(){
    dazed = false;
    pWidth /= 2;
    pHeight *= 2;
  }
  
  //Draws the agent
  public void drawAgent(){
    if (ducking){
      drawDucking();
    }else if (charging){
      drawCharging();
    }else if (dazed){
      drawDazed();
    }else{
      drawNormal();
    }
  }
  
  private void drawCharging(){
    stroke(0, 0, 255);
    fill(0, 0, 255);
    quad(x+0.3*pWidth, height-y-pHeight, x, height-y, x+pWidth, height-y, x+1.3*pWidth, height-y-pHeight);
  }
  
  private void drawDucking(){
    stroke(0, 255, 0);
    fill(0, 255, 0);
    rect(x, height-y-pHeight, pWidth, pHeight);
  }
  
  private void drawDazed(){
    stroke(255, 255, 0);
    fill(255, 255, 0);
    rect(x, height-y-pHeight, pWidth, pHeight);
  }
  
  private void drawNormal(){
    stroke(255, 0, 0);
    fill(255, 0, 0);
    rect(x, height-y-pHeight, pWidth, pHeight);
  }
  
  public boolean getHidden(){
    return hidden;
  }
  
  public void hide(){
    hidden = true;
  }
  
}
