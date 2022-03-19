class Bullet { 
  int x, y, w, h, speed;
  Bullet (int xPos, int yPos) {
    w = 4;
    h = 10;
    x = xPos - w/2;
    y = yPos;
    if (y < height-100) { // speed if going down
      speed = 8;
    } else { // speed if going up
      speed = -10;
    }
  }
  
  void update() {
    y += speed;
  }
  
  void show() {
    stroke(0, 0, 255);
    fill(50, 0, 200);
    rect(x, y, w, h);
  }
  
}
