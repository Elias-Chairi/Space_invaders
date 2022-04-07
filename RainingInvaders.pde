class RainingInvaders implements gameMode {
  
  boolean invadersSpawning = false;
  int breakTimer = 0; // 3-2-1 counter
  int enemySpwanTimer = 90;
  Player p1;
  Invader[] invaders = new Invader[0];
  
  void gameSetup() {
    p1 = new Player(width/2, height - 50, 50, 20); // x, y, w, h
    print("Starting Raining invaders");
  }
  
  void gameDraw() {
    if (p1.lives > 0) { // player alive?
      background(0);
      stroke(100, 0, 0);
      line(0, height -200, width, height-200);
      
      p1.updatePosition();
      p1.updateBullet();
      p1.show();
      
      if (invadersSpawning) {
        spawnInvaders();
      }
      
      for (int i = 0; i < invaders.length; i++) {
        invaders[i].update();
        invaders[i].shoot();
        invaders[i].show();
      }
      
      updateBullets();
      
      for (int i = 0; i < invaders.length; i++) {
        if (invaders[i].dead && invaders[i].currentBullet == null) {
          invaders = removeEelement(invaders, i); // removes the invader when dead and the bullet is out of play
        }
      }
      
      
      // invader movement
      if (invaders.length > 0) {
        for (int i = 0; i < invaders.length; i++) {
          invaders[i].y += 0.5;
          if (invaders[i].x >  width - invaders[i].w || invaders[i].x < 0){
            invaders[i].speed *= -1;
          }
        }

      }
      
      // round over (no invaders) starting timer, starting new round
      else {
        breakTimer++;
      }
      fill(255);
      textSize(100);
      if (breakTimer > 120) {
        text(1, width/2 - 30, height/2);
      } else if (breakTimer > 60) {
        text(2, width/2 - 30, height/2);
      } else if (breakTimer > 1) {
        text(3, width/2 - 30, height/2);
      }
      if (breakTimer > 180) {
        breakTimer = 1;
        invadersSpawning = true;
      }
      
      fill(255);
      textSize(20);
      textAlign(BASELINE);
      text("SCORE: " + p1.score, 10, 20);
      text("LIVES: " + p1.lives, width - 100, 20);
    }
    
    else { // player dead (game over)
      noLoop();
      background(0);
      fill(255, 0, 0);
      textSize(80);
      text("GAME OVER", 50, height/2);
      fill(255);
      textSize(30);
      text("Final score: " + p1.score, 50, height/2 + 100);
    }
  }
  
  void spawnInvaders() {
    if (enemySpwanTimer % 90 == 0) {
      invaders = (Invader[])append(invaders, new Invader(int(random(width -20)), 0, 20, 20, p1, 0.05, true)); // xPos, yPos, width, height, ySpeed, randomDirection
      invaders[invaders.length - 1].moveToY = height;
    } 
    enemySpwanTimer++;
  }
  
  
  
  void updateBullets() {
    if (p1.currentBullet != null) { // if playerBullet exists, check for hit on invaders
      for (int i = 0; i < invaders.length; i++) { // if invader exists, check for hit
        if (rectHitsRect(p1.currentBullet.x, p1.currentBullet.y, p1.currentBullet.w, p1.currentBullet.h, // playerBullet xPos, yPos, width, height
                         invaders[i].x, int(invaders[i].y), invaders[i].w, invaders[i].h)) { // invader xPos, yPos, width, height
          p1.currentBullet = null;
          p1.score += invaders[i].value;
          invaders[i].dead = true;
          break; // can only hit one invader at the same time
        }
      }
    }
    for (int i = 0; i < invaders.length; i++) {
      if (invaders[i].currentBullet != null && // if invaderBullet exists, check for hit on player
          rectHitsRect(invaders[i].currentBullet.x, invaders[i].currentBullet.y, invaders[i].currentBullet.w, invaders[i].currentBullet.h, // inavderBullet xPos Ypos width height
                       p1.x, p1.y, p1.w, p1.h)) { // player xPos, Ypos, width
          p1.HIT();
          invaders[i].currentBullet = null;
      }
    }
  }
  
  boolean rectHitsRect (int rX, int rY, int rW, int rH, int r2X, int r2Y, int r2W, int r2H) {
    if (rY < r2Y + r2H && // top r past Bottom r2
        rX < r2X + r2W && // left r past right r2
        rX + rW > r2X && // right r past left r2
        rY + rH > r2Y) { // right r past left r2
      return true;
    } 
    return false;
  }
  
  Invader[] removeEelement( Invader[] array, int index) {
    Invader[] newArray = new Invader[array.length -1];
    int k = 0;
    for (int i = 0; i < array.length; i++){
      if (i != index) {
        newArray[k] = array[i];
        k++;
      }
    }
    return newArray;
  }
  
  void gameKeyPressed() {
    p1.press();
  }
  
  void gameKeyReleased() {
    p1.release();
  }
}
