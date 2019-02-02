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
  private final double USUALVX;
  private final double DUCKSHRINKAMOUNT;
  private final double CHARGEAMOUNT;
  private final int CHARGETIME;
  private final int DAZETIME;
  
  private int pWidth;
  private int pHeight;
  
  private boolean hasWon;
  private boolean isOnGround;
  private boolean isDucking;
  private boolean isCharging;
  private boolean chargeSuccessful;
  private boolean isDazed;
  
  public Player(){
    
    x = 100;
    y = 400;
    vX = 0;
    vY = 0;
    
    chargeCounter = -1;
    
    GRAVTIY = -1;
    USUALVX = 2;
    DUCKSHRINKAMOUNT = 100;
    CHARGEAMOUNT = 3;
    CHARGETIME = 40;
    DAZETIME = 100;    //Always: DAZETIME > CHARGETIME * (CHARGEAMOUNT - 1)
    
    pWidth = 100;
    pHeight = 200;
    
    hasWon = false;
    isOnGround = true;
    isDucking = false;
    isCharging = false;
    chargeSuccessful = false;
    isDazed = false;
  }
  
  //Handles one timestep
  public int step(){
    
    x += vX;
    y += vY;
    if (!isOnGround){
      vY += GRAVTIY;
    }
    
    //Check this later
    if (y - pHeight <= 200){
      y = pHeight + 200;
      vY = 0;
      isOnGround = true;
    }else{
      isOnGround = false;
    }
    
    chargeCounter--;
    dazeCounter--;
    if (chargeCounter == 0){
      endCharge();
      if (!chargeSuccessful){
        startDaze();
      }
    }
    if (dazeCounter == 0){
      endDaze();
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
    if (isOnGround && !isDazed){
      vY = 20;
      endDuck();
    }
  }
  
  //Causes it to go right at the usual speed
  public void goRight(){
    if (!isDazed){
      vX = USUALVX;
    }
  }
  
  //Causes it to go right at the usual speed
  public void goLeft(){
    if (!isDazed){
      vX = -USUALVX;
    }
  }
  
  //Causes it to duck
  public void duck(){
    if (isOnGround && !isDazed && !isCharging && !isDucking){
      isDucking = true;
      y -= DUCKSHRINKAMOUNT;
      pHeight -= DUCKSHRINKAMOUNT;
    }
  }
  
  //Causes it to end the duck
  public void endDuck(){
    if (isDucking){
      isDucking = false;
      y += DUCKSHRINKAMOUNT;
      pHeight += DUCKSHRINKAMOUNT;
    }
  }
  
  //Causes it to charge
  public void charge(){
    if (isOnGround && !isDazed && !isCharging){
      isCharging = true;
      vX *= CHARGEAMOUNT;
      chargeCounter = CHARGETIME;
      endDuck();
    }
  }
  
   //Causes it to end charge
  public void endCharge(){
    if (isCharging){
      isCharging = false;
      vX /= CHARGEAMOUNT;
    }
  }
  
  //Starts the daze
  public void startDaze(){
    isDazed = true;
    vX = 0;
    dazeCounter = DAZETIME;
    pWidth *= 2;
    y -= pHeight/2;
    pHeight /= 2;
  }
  
  //Ends the daze
  public void endDaze(){
    isDazed = false;
    pWidth /= 2;
    y += pHeight;
    pHeight *= 2;
  }
  
  //Draws the agent
  public void drawAgent(){
    if (isDucking){
      drawDucking();
    }else if (isCharging){
      drawCharging();
    }else if (isDazed){
      drawDazed();
    }else{
      drawNormal();
    }
  }
  
  public void drawCharging(){
    stroke(0, 0, 255);
    fill(0, 0, 255);
    quad(x+0.3*pWidth, height-y, x, height-y+pHeight, x+pWidth, height-y+pHeight, x+1.3*pWidth, height-y);
  }
  
  public void drawDucking(){
    stroke(0, 255, 0);
    fill(0, 255, 0);
    rect(x, height-y, pWidth, pHeight);
  }
  
  public void drawDazed(){
    stroke(255, 255, 0);
    fill(255, 255, 0);
    rect(x, height-y, pWidth, pHeight);
  }
  
  public void drawNormal(){
    stroke(255, 0, 0);
    fill(255, 0, 0);
    rect(x, height-y, 100, 200);
  }
  
}
