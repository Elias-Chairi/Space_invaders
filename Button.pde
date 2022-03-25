class Button { 
  int x, y, w, h;
  String text;
  boolean hover = false;
  Button (int xPos, int yPos, String buttonText) {
    w = 300;
    h = 60;
    x = xPos - w/2;
    y = yPos;
    text = buttonText;
  }
  
  void show() {
    fill(100);
    if (hover) {
      fill(70);
    }
    rect(x, y, w, h);
    
    fill(255);
    textSize(50);
    textAlign(CENTER, CENTER);
    text(text, x + w/2, y + h/2 - 12);
  }
  
}
