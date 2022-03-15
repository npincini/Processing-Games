float PlayerSize = 50;
float[] BallSize = new float[31];
float[] BallXPosition = new float[31];
float[] BallYPosition = new float[31];
float[] BallGreenColor = new float[31];
float[] BallSpeedX = new float[31];
float[] BallSpeedY = new float[31];
boolean GameLose = false;
int Score;

////////////////////////////////////////////

void setup() {
  size(800, 800);
  Score = 0;
  PlayerSize=  50;

  // Creating the inital balls
  for (int i = 0; i<= 30; i++) {
    BallSize[i] = random(20, 50);
    BallXPosition[i] = random(0+BallSize[i]/2, 800-BallSize[i]/2);
    BallYPosition[i] = random(0+BallSize[i]/2, 800-BallSize[i]/2);
    BallGreenColor[i] = BallSize[i]*2;
  }

  for (int i = 0; i<= 15; i++) {
    BallSpeedX[i] = int(random(1, 3));
    BallSpeedY[i] = BallSpeedX[i];
  }
  for (int i = 15; i<= 30; i++) {
    BallSpeedX[i] = int(random(-1, -3));
    BallSpeedY[i] = BallSpeedX[i];
  }
}

////////////////////////////////////////////

void draw() {

  if (GameLose == false) {
    background(255);
    fill(0);
    textSize(10);
    textAlign(LEFT);
    text("ESC to exit", 10, 15);
    textAlign(RIGHT);
    text(int(frameRate) + " fps", width - 10, 15);
    createPlayer();
    createBalls();
    ballsCollision();
  }

  if (GameLose == true) {
    background(255);
    textSize(10);
    textAlign(LEFT);
    text("ESC to exit", 10, 15);
    textAlign(RIGHT);
    text(int(frameRate) + " fps", width - 10, 15);
    textAlign(CENTER, CENTER);
    fill(0);
    textSize(30);
    text("You Lose", 400, 350);
    text("You survived for: " + Score/60 + " seconds", 400, 400);
    text("Click to restart", 400, 450);
    if (mousePressed == true) {
      setup();
      GameLose = false;
    }
  }
}

////////////////////////////////////////////

void createPlayer() {
  fill(227, 113, 100);
  circle(mouseX, mouseY, PlayerSize);
  PlayerSize = PlayerSize + 0.0625;
  Score = Score + 1;
  fill(0);
  textSize(10);
  textAlign(CENTER);
  text(Score/60, mouseX - 2.75, mouseY - 5);
}

////////////////////////////////////////////

void createBalls() {
  for (int i = 0; i<= 30; i++) {
    fill(0, BallGreenColor[i], 0);
    circle(BallXPosition[i], BallYPosition[i], BallSize[i]);
    BallXPosition[i] = BallXPosition[i] + BallSpeedX[i];
    BallYPosition[i] = BallYPosition[i] + BallSpeedY[i];

    if (BallXPosition[i] > 800-BallSize[i]/2 || BallXPosition[i] < 0+BallSize[i]/2) {
      BallSpeedX[i] = BallSpeedX[i] * -1;
    }

    if (BallYPosition[i] > 800-BallSize[i]/2 || BallYPosition[i] < 0+BallSize[i]/2) {
      BallSpeedY[i] = BallSpeedY[i] * -1;
    }
  }
}

////////////////////////////////////////////

void ballsCollision() {
  for (int i = 0; i<= 30; i++) {
    if (dist(mouseX, mouseY, BallXPosition[i], BallYPosition[i]) < PlayerSize/2 + BallSize[i]/2) {
      GameLose = true;
    }
  }
}

////////////////////////////////////////////
