class Player { 
  int x, y, w, h, moveSpeed, recoverTime;
  boolean right, left, shoot, recovering;
  int score, lives;
  Bullet currentBullet;
  Player (int xPos, int yPos, int pWidth, int pheight) {  
    x = xPos;
    y = yPos;
    w = pWidth;
    h = pheight;
    moveSpeed = 10;
    
    right = false;
    left = false;
    shoot = false;
    
    score = 0;
    lives = 3;
    recovering = false;
    recoverTime = 0;
  }
  
  void press() { // key pressed (update variables)
    if (keyCode == RIGHT) {
        right = true;
    }
    if (keyCode == LEFT) {
        left = true;
    }
    if (key == ' ' || keyCode == UP) {
        shoot = true;
    }
  }
  
  void release() { // key realeased (update variables)
    if (keyCode == RIGHT) {
        right = false;
    }
    if (keyCode == LEFT) {
        left = false;
    }
    if (key == ' ' || keyCode == UP) {
        shoot = false;
    }
  }
  
  void HIT() {
    if (!recovering) {
      lives --;
      recovering = true;
    }
  }
  
  void updatePosition() {
    if (right == false || left == false){ // movement
      if (right) {
        x += moveSpeed;
      } 
      if (left){
        x -= moveSpeed;
      }
    }
    
    if (x + w > width){ // right barrier
      x = width - w;
    }
    if (x < 0){ // left barrier
      x = 0;
    }
  }
  
  void updateBullet() {
    if (currentBullet != null){ // if bullet exists, update bullet
      currentBullet.update();
      currentBullet.show();
      
      if (currentBullet.y < 0 - currentBullet.h){ // out off the screen
        currentBullet = null;
      }
      
    } else if (shoot && !recovering) { // if shooting and no bullet exsists and not recovering, create bullet
      currentBullet = new Bullet(x +w/2, y-15);
    }
  }

  void show() {
    fill(255, 0, 0);
    
    if (recovering) {
      if (recoverTime > 120){
        recovering = false;
        recoverTime = 0;
      }
      if (recoverTime % 20 > -10 && recoverTime % 20 < 10){ // hit animation
        fill(0, 0, 0);
      }
      recoverTime ++;
    }
    
    stroke(255, 0, 0);
    rect(x, y, w, h); // body
    rect(x + w/2 - 5, y - 15, 10, 15); // canon
  } 
}
