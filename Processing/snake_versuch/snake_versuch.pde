import java.awt.Point;
  int windowSize = 200, snakeWith = 10;
void setup() {
  size(200, 200);
  frameRate(10);
  init();
}
int direction = 0;//0: none, 1: left, 2: right, 3: up, 4: down
ArrayList<Point> snakeArray = new ArrayList();
Point nextHeadPosition, foodPosition;
void draw() {
  if (!coliditonCheck()) {
    moveSnake();
    drawBackground();
    drawSnake();
    drawFood();
  } else {
    exit();
  }
}
void init() {
  snakeArray.add(new Point((windowSize-snakeWith)/2, (windowSize-snakeWith)/2));
  newFood();
}
void drawBackground() {
  background(0);
  fill(255);
  rect(snakeWith, snakeWith, windowSize-2*snakeWith, windowSize-2*snakeWith);
}
void drawFood() {
  fill(200);   
  ellipse(foodPosition.x, foodPosition.y, snakeWith, snakeWith);
}
void drawSnake() {
  fill(0);
  for (Point p : snakeArray) {
    rect(p.x, p.y, snakeWith, snakeWith);
  }
}
void moveSnake() {
  Point newPosition = nextHeadPosition, tempPosition;
  for (int i = 0; i<snakeArray.size(); i++) {
    tempPosition = snakeArray.get(i);
    snakeArray.set(i, newPosition);
    newPosition = tempPosition;
  }
}
void newFood() {
  foodPosition = new Point((int) random(1, ((windowSize-2*snakeWith)+1)/snakeWith) * snakeWith, (int) random(1, ((windowSize-2*snakeWith)+1)/snakeWith) * snakeWith);
}
void eatFood () {
    newFood();
    snakeArray.add(snakeArray.get(snakeArray.size()-1));
}

boolean coliditonCheck() {
  int offsetX = 0, offsetY = 0;
  //in welche Richtung?
  switch (direction) {
  case 1: 
    offsetX = -snakeWith; 
    break;
  case 2:
    offsetX = snakeWith;
    break;
  case 3:
    offsetY = -snakeWith;
    break;
  case 4:
    offsetY = snakeWith;
    break;
  default:
    break;
  }
  //wo ist der Kopf als nächstes?
  nextHeadPosition = new Point(snakeArray.get(0).x+offsetX, snakeArray.get(0).y+offsetY);
  // Kollision mit dem Körper?
  for (Point p : snakeArray) {
    if (nextHeadPosition.x == p.x && nextHeadPosition.y == p.y && direction!=0) {
      return true;
    }
  }
  //Kollision mit der Wand?
  if (nextHeadPosition.x<snakeWith/2 || nextHeadPosition.x>=windowSize-snakeWith/2 || nextHeadPosition.y<snakeWith/2 || nextHeadPosition.y>=windowSize-snakeWith/2 ) {
    return true;
  } 
  //Kollision mit Essen?
  else if (nextHeadPosition.x == foodPosition.x - snakeWith/2 && nextHeadPosition.y == foodPosition.y- snakeWith/2) {
    eatFood();
    return false;
  } else {
    return false;
  }
}
void keyPressed() {
  switch(keyCode) {
  case LEFT:
    direction=1;
    break;
  case RIGHT:
    direction=2;
    break;
  case UP:
    direction=3;
    break;
  case DOWN:
    direction=4;
    break;
  default:
    break;
  }
}