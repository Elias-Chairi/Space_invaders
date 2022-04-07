interface gameMode {
  void gameSetup();
  void gameDraw();
  void gameKeyPressed();
  void gameKeyReleased();
}

boolean startMenu = true;
boolean paused = false;
ArrayList<gameMode> gameList = new ArrayList<gameMode>();
int gameIndex = 100; // default
Button[] buttons = new Button[0];


void setup() {
  size(500, 500);
  gameList.add(new OriginalGameMode());
  gameList.add(new RainingInvaders());
  buttons = (Button[])append(buttons, new Button(width/2, height/4, "original"));
  buttons = (Button[])append(buttons, new Button(width/2, height/4 * 2, "Raining invaders"));
  buttons = (Button[])append(buttons, new Button(width/2, height/4 * 3, "..."));
}

void draw() {
  if (startMenu) {
    background(0);
    for (int i = 0; i < buttons.length; i++){
      buttons[i].show();
    }
    
  } else {
    gameList.get(gameIndex).gameDraw();
  }
}

void mouseMoved() {
  if (startMenu) {
    for (int i = 0; i < buttons.length; i++){
      if (mouseX > buttons[i].x && mouseX < buttons[i].x + buttons[i].w &&
          mouseY > buttons[i].y && mouseY < buttons[i].y + buttons[i].h) {
        buttons[i].hover = true;
      } else {
        buttons[i].hover = false;
      }
    } 
  }
}

void mouseClicked() {
  if (startMenu) {
    for (int i = 0; i < buttons.length; i++){
      if (mouseX > buttons[i].x && mouseX < buttons[i].x + buttons[i].w &&
          mouseY > buttons[i].y && mouseY < buttons[i].y + buttons[i].h) {
        chooseGameMode(buttons[i].text);
      }
    } 
  }
}

void chooseGameMode(String gameMode) {
  switch(gameMode) {
    case "original": 
      gameIndex = 0;
      break;
    case "Raining invaders": 
      gameIndex = 1;
      break;
  }
  if (gameIndex != 100) { // chose a gamemode
    startMenu = false;
    gameList.get(gameIndex).gameSetup();
  }
}

void keyPressed() {
  if (!startMenu) {
    gameList.get(gameIndex).gameKeyPressed(); // game input
    
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
}

void keyReleased() {
  if (!startMenu) {
    gameList.get(gameIndex).gameKeyReleased(); // game input
  }
}
