int PlayerSize = 30;
int PlayerXPos = 300;
int PlayerYPos = 300;
int XMovementAmount = 5;
int YMovementAmount = 5;
int Score = 0;
int BallSize = 15;
int BallXPosition;
int BallYPosition;
int hello = 0;
int Time = 0;

boolean XMovement;
boolean YMovement;
boolean BallMade = false;

/////////////////////////////////////////////////////////////

void setup() {
  size(600, 600);
  background(255);
}

/////////////////////////////////////////////////////////////

void draw() {
  background(255);
  if (PlayerSize < 550) {
  circle(PlayerXPos, PlayerYPos, PlayerSize);
  movement();
  WallCollision();
  CreateBall();
  CollisionSystem();
  }
  else {
   text("You Win", 300, 300); 
  }
}

/////////////////////////////////////////////////////////////

void movement() {
  if (XMovement == true) {
    PlayerXPos = PlayerXPos - XMovementAmount;
  }

  if (XMovement == false) {
    PlayerXPos = PlayerXPos + XMovementAmount;
  }

  if (YMovement == true) {
    PlayerYPos = PlayerYPos - YMovementAmount;
  }

  if (YMovement == false) {
    PlayerYPos = PlayerYPos + YMovementAmount;
  }
}

/////////////////////////////////////////////////////////////

void WallCollision() {
  if (PlayerYPos > 600 - PlayerSize/2) {
    YMovement = true;
  }
  if (PlayerYPos < 0 + PlayerSize/2) {
    YMovement = false;
  }
  if (PlayerXPos > 600 - PlayerSize/2) {
    XMovement = true ;
  }
  if (PlayerXPos < 0 + PlayerSize/2) {
    XMovement = false;
  }
}

/////////////////////////////////////////////////////////////

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      YMovement = true;
    }
    if (keyCode == DOWN) {
      YMovement = false;
    }
    if (keyCode == LEFT) {
      XMovement = true;
    }
    if (keyCode == RIGHT) {
      XMovement = false;
    }
  }
}

/////////////////////////////////////////////////////////////

void CreateBall() {
  if (BallMade == false) {
    BallXPosition = int(random(0+BallSize/2, 600-BallSize/2));
    BallYPosition = int(random(0+BallSize/2, 600-BallSize/2));
    BallMade = true;
  }
  circle(BallXPosition, BallYPosition, BallSize);
  Time = Time + 1;
  if (Time > 100) {
    BallMade = false;
    Time = 0;
  }
}

/////////////////////////////////////////////////////////////

void CollisionSystem() {
  if (dist(PlayerXPos, PlayerYPos, BallXPosition, BallYPosition) < BallSize/2 + PlayerSize/2) {
    PlayerSize = PlayerSize + 5;
    Time = 0;
    BallSize = BallSize + 1;
    BallMade = false;
    println(PlayerSize);
      }
}

/////////////////////////////////////////////////////////////
