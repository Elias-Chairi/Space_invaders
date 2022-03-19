class Invader {
  int x, y, w, h, moveToY;
  int counter = 0;
  int speed = 1;
  int value = 30;
  Bullet currentBullet;
  boolean dead = false;
  Invader (int xPos, int yPos, int iWidth, int iHeight) {
    x = xPos;
    y = yPos;
    w = iWidth;
    h = iHeight;
    
    moveToY = yPos;
  }
  
  void update() {
    x += speed;
    
    if (y < moveToY) {
      y += abs(speed);
      if (y >= height -200) {
        original.p1.lives = 0;
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
        currentBullet = new Bullet(x +w/2, y + h);
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
