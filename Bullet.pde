class Bullet { 
  int x, y, w, h, speed;
  Bullet (int xPos, int yPos) {
    w = 4;
    h = 10;
    x = xPos - w/2;
    y = yPos;
    if (y < height-100) { // gå ned hvis oppe
      speed = 10;
    } else { // gå opp hvis nede
      speed = -50;
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
