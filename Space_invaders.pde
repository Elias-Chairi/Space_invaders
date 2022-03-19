boolean paused = false;

OriginalGameMode original = new OriginalGameMode();
String gameMode = "original";

void setup() {
  size(500, 500);
  original.gameSetup();
}

void draw() {
  switch(gameMode) {
    case "original": 
      original.gamePlay();
      break;
    case "anotherOne": 
      break;
    case "menu":
      break;
  }
}

void keyPressed() {
  switch(gameMode) {
    case "original": 
      original.gameKeyPressed();
      break;
    case "anotherOne": 
      break;
    case "menu":
      break;
  }
  
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
  switch(gameMode) {
    case "original": 
      original.gameKeyReleased();
      break;
    case "anotherOne": 
      break;
    case "menu":
      break;
  }
}
