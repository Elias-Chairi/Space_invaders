class Invader {
  int x, w, h;
  float y, moveToY;
  int counter = 0;
  int speed = 1;
  float ySpeed;
  int value = 30;
  Bullet currentBullet;
  boolean randDir;
  boolean dead = false;
  Player p1;
  Invader (int xPos, float yPos, int iWidth, int iHeight, Player player, float yspeed, boolean randomDirection) {
    x = xPos;
    y = yPos;
    w = iWidth;
    h = iHeight;
    
    randDir = randomDirection;
    if (randDir) {
      if (int(random(2)) == 0) {
        speed *= -1;
      }
    }
    ySpeed = yspeed;
    
    p1 = player;
    moveToY = yPos;
  }
  
  void update() {
    x += speed;
    
    if (y < moveToY) {
      y += ySpeed;
      if (y >= height -200) {
        p1.lives = 0;
      }
    }
  }
  
  void moveDown() {
    moveToY += 30;
  }
  
  void shoot() {
    if (currentBullet != null){ // if bullet exists, update bullet
      currentBullet.update();
      currentBullet.show();
      
      if (currentBullet.y > height){ // out off the screen
        currentBullet = null;
      }
      
    } else { // no bullet exsists, random chance at shooting
      int r = int(random(600));
      if (r == 0) {
        currentBullet = new Bullet(x +w/2, int(y) + h);
      }
    }
  }
  
  void show() {
    if (!dead) {
      stroke(255, 0, 0);
      if (currentBullet != null) { // blue stroke when shooting
        stroke( 0, 0, 255);
      }
      fill(100, 0, 0);
      rect(x, y, w, h);
    }
  }
}
