//// Declare Variables

//Golf Hole
float xhole;              // Hole x-coords
float yhole;              // Hole y-coords

// Arrow Position
float xposition = 100;      // Base arrow x-coords
int xchanger = 7;         // Distance arrow moves
int rememberxChanger;     // Remember if direction was left or right

// Patchwork Array
int[][] myArray = new int[117][59];

// Launch State
boolean playerMoving = true;      // true = moving player / false = Frozen Player
boolean readyToLaunch = false;     // Ready to Launch?      
boolean launching = false; // Begin drawBall()

// Ball Variables
float[] xballArray = new float [10];  // Store 10 balls' x-coords
float[] yballArray = new float [10];  // Store 10 balls' y-coords
float yposition = 700;     // Base position of ball
float ychanger;            // Distance ball moves
int ballArray = 0;         // Balls fired
int force;                 // Ball Power
int previousForce;         // Previous Ball Power
int bounce = 1;            // Bounce the ball against wall
boolean flip = false;      // Ball already bounced?

// Power Variables
int counter = 0;           // Counting 4 seconds
int direction;             // Counting up or down     
float g = 218;             // Base green color for power
float b = 94;              // Base blue color for power

// Scoreboard
int currentHole = 1;       // Current Golf Hole
int wins;                  // Current Wins
int losses;                // Current Losses

//===================================================================================

void setup() {
  size(1280, 960);         // Size of window

  //Patchwork Colors
  for (int i = 0; i < 117; i++) {
    for (int j = 0; j < 59; j++) {
      color c = color(0, int(random(75, 255)), 0);
      myArray[i][j] = c;  // For each grid, asign a random color
    }
  }

  // Golf Hole Location
  xhole = random(90, 1190);
  yhole = random(165, 685);
}

//===================================================================================

void draw() {
  createBackground();
  drawPlayer();
  drawBall();
}

//===================================================================================

void createBackground() {
  background(127);

  //Beige Outline of Patchwork
  stroke(1);
  fill(250, 250, 202);
  rect(50, 125, 1180, 600, 15);

  // Title
  textSize(60);
  textAlign(CENTER);
  fill(0);
  text(year() + " Comp1000 Golf Championship", width/2, 75);
  textSize(20);
  text("Hole #" + currentHole + ". Wins: " + wins + ". Losses: " + losses + ".", width/2, 110);

  // Help
  textSize(20);
  text("Press a key to line up your shot. Press again to select shot power. Press the mouse to change hole location.", width/2, 915);
  text("Current shot power: " + force + ". Previous shot power: " + previousForce + ".", width/2, 940);

  // Frame Rate
  textSize(10);
  text("ESC to exit", 30, 15);
  text(int(frameRate) + " fps", width - 20, 15);

  // Create grass using setup() array
  noStroke();
  for (int i = 1; i < 117; i++) {
    for (int j = 1; j < 59; j++) {
      fill(myArray[i][j]);
      rect(50+i*10, 125+j*10, 10, 10);
    }
  }

  // Golf Hole + Flag
  fill(0);
  noStroke();
  circle(xhole, yhole, 60);
  stroke(1);
  fill(255);
  rect(xhole-2.5, yhole-50, 5, 50);
  fill(255, 0, 0);
  triangle(xhole-2.5, yhole-55, xhole-2.5, yhole-30, xhole+30, yhole-45);
}

//===================================================================================

void drawPlayer() {
  if (playerMoving == true) { // Moving Player
    noStroke();
    fill(250, 218, 94); //Royal Color
    triangle(xposition-25, 800, xposition+75, 800, xposition+25, 740); //Triangle on arrow
    rect(xposition, 800, 50, 80); //Rectangle on arrow
    xposition = xposition + xchanger;
    if (xposition >= 1180 || xposition <= 50) {    // Boundary for player
      xchanger = xchanger * -1;
    }
  }

  if (playerMoving == false) { // Frozen Player
    noStroke();
    fill(250, g, b); //Royal Color
    triangle(xposition-25, 800, xposition+75, 800, xposition+25, 740); //Triangle on arrow
    rect(xposition, 800, 50, 80); //Rectangle on arrow
    //fill(255);

    // Determine Shot Power
    if (counter <= 0) {
      direction = 1;
    }
    if (counter >= 240) {
      direction = -1;
    }
    counter = counter + direction;
    g = g - direction * 0.57;      //Change green color
    b = b - direction * 0.57;      // Change blue color
    force = counter;
    readyToLaunch = true;
  }
}

//===================================================================================

void drawBall() {
  if (launching == true) { // Ball Moving
    if (force >= 0) {
      stroke(1);
      fill(255);
      circle(xposition+25, yposition, 30);
      yposition = yposition - ychanger;
      ychanger = force * 0.033 * bounce;    //Movement = Force x Gravity x hasBounced?
      force = force - 1;

      if (yposition <= 160 && flip == false) {    // If already flipped, don't again
        bounce = bounce * -1;
        flip = true;
      }

      // Attempt at Collision
      //for (int i = 0; i < 10; i++) {
      //  if (dist(xposition+25, yposition, xballArray[i], yballArray[i]) < 25) {
      //    println("Collision");
      //    yballArray[i] = yballArray[i] + force;
      //  }
      //}
    }

    if (force <= 0) {    //If ball no longer moving, remember the position, reset variables, and check Win/Lose
      xballArray[ballArray] = xposition + 25;
      yballArray[ballArray] = yposition;
      ballArray = ballArray + 1;
      gameWinLose();
      yposition = 700;
      if (bounce == -1) {
        bounce = bounce * -1;
      }

      counter = 0;
      g = 218;
      b = 94;
      launching = false;
      playerMoving = true;
      readyToLaunch = false;
      flip = false;
      xchanger = rememberxChanger;
    }
  }

  // Multiple Balls on screen
  for (int x = 0; x < 10; x++) {
    if (xballArray[x] != 0 && xballArray[x] != 0) {
      fill(255);
      stroke(1);
      circle(xballArray[x], yballArray[x], 30);
    }
  }
}

//===================================================================================

void keyPressed() {
  if (playerMoving == true) {        // first keypress: stop player & begin charging  
    rememberxChanger = xchanger;
    playerMoving = false;
  }

  if (readyToLaunch == true) {      // Second keypress: shoot ball then rest for next shot
    previousForce = force;
    launching = true;
    xchanger = 0;
    playerMoving = true;
  }

  if (key == ESC) {                // Exit game
    exit();
  }
}

//===================================================================================

void gameWinLose() {
  if (dist(xhole, yhole, xposition+25, yposition) <= 30 && force <= 0) {    //If ball stopped and is close enough to all
    ballArray = 0;
    for (int x = 0; x < 10; x++) {
      xballArray[x] = 0;
      yballArray[x] = 0;
    }
    currentHole++;
    wins++;
    setup();
  }

  if (ballArray >= 10) {    //If 10 balls fired, reset
    ballArray = 0;
    for (int x = 0; x < 10; x++) {
      xballArray[x] = 0;
      yballArray[x] = 0;
    }
    currentHole++;
    losses++;
    setup();
  }
}

//===================================================================================

void mousePressed() {    // Change golf hole
  xhole = random(85, 1195);
  yhole = random(160, 690);
}
