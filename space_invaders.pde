// 2790 Sturla
// 3300 ole
// 1170 Markus

int difficultylevel = 0;
int[] leftRightInvaderIndex = {0, 9}; //every row is ten in length
int hitWallCounter = 1;
int breakTimer = 0;
boolean paused = false;
Player p1;
Invader[] invaders = new Invader[0];

void setup() {
  size(500, 500);
  p1 = new Player(width/2, height - 50, 50, 20); // x, y, w, h
}

void waveSetup() {
  if (difficultylevel != 0) {
    p1.lives ++;
  }
  difficultylevel++;
  for (int i = 0; i < difficultylevel; i++) { // ++ verticaly
    for (int j = 0; j < 10; j++) { // + 10 Invaders hoizontaly
      invaders = (Invader[])append(invaders, new Invader(j * 30 + 5, i * 30 + 30, 20, 20)); // xPos, yPos, width, height
    }
  }
  leftRightInvaderIndex = checkLeftRightInvader(invaders); // check the left and right invader after wavesetup
}

void draw() {
  background(0);
  stroke(100, 0, 0);
  line(0, height -200, width, height-200);
  
  p1.updatePosition();
  p1.updateBullet();
  p1.show();
  
  for (int i = 0; i < invaders.length; i++) {
    invaders[i].update();
    invaders[i].shoot();
    invaders[i].show();
    if (invaders[i].dead && invaders[i].currentBullet == null) {
      invaders = removeEelement(invaders, i); // removes the invader when dead and the bullet is out of play
      leftRightInvaderIndex = checkLeftRightInvader(invaders); // check the left and right invader after a invader has died
    }
  }
  
  updateBullets();
  
  // invader movement
  if (invaders.length > 0) {
    
    if (invaders[leftRightInvaderIndex[1]].x + invaders[leftRightInvaderIndex[1]].w > width -5 || // right wall
        invaders[leftRightInvaderIndex[0]].x < 5) { // left wall
      for (int i = 0; i < invaders.length; i++) {
        invaders[i].speed *= -1;
      }
      hitWallCounter ++;
    }
    if (hitWallCounter % 4 == 0) {
      for (int i = 0; i < invaders.length; i++) {
        invaders[i].moveDown();
      }
      hitWallCounter ++; //stop making this true
    }
  }
  
  // round over (no invaders)
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
    waveSetup();
  }
  
  
  fill(255);
  textSize(20);
  text("SCORE: " + p1.score, 10, 20);
  text("LIVES: " + p1.lives, width - 100, 20);
 
  if (p1.lives == 0) {
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

void updateBullets() {
  if (p1.currentBullet != null) { // if playerBullet exists, check for hit on invaders
    for (int i = 0; i < invaders.length; i++) { // if invader exists, check for hit
      if (rectHitsRect(p1.currentBullet.x, p1.currentBullet.y, p1.currentBullet.w, p1.currentBullet.h, // playerBullet xPos, yPos, width, height
                       invaders[i].x, invaders[i].y, invaders[i].w, invaders[i].h)) { // invader xPos, yPos, width, height
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

int[] checkLeftRightInvader( Invader[] invaders) { // finding the invader that is the most to the left and the right
  int maxX = 0;
  int rightIndex = 0;
  int minX = width;
  int leftIndex = 0;
  
  for (int i = 0; i < invaders.length; i++) {
    if (invaders[i].x < minX) {
      minX = invaders[i].x;
      leftIndex = i;
    }
    if (invaders[i].x > maxX) {
      maxX = invaders[i].x;
      rightIndex = i;
    }
  }
  
  int[] leftRight = {leftIndex, rightIndex};
  return leftRight;
}

void keyPressed() {
  p1.press();
  
  if (key == 'p') {
    if (paused) {
      loop();
      paused = false;
    } else {
      noLoop();
      paused = true;
    }
  }
}

void keyReleased() {
  p1.release();
}
