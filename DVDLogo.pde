int acolor = int(random(0, 255));
int bcolor = int(random(0, 255));
int ccolor = int(random(0, 255));

float xposition;
float yposition;

float xchanger = 3;
float ychanger = 3; 

int width = 1440;
int height = 850;

void setup() {
  fullScreen();
  xposition = random(1, width-216);
  yposition = random(76, height-1);
}

void draw() {
  background(0);
  fill(acolor, bcolor, ccolor);
  textSize(100);
  text("DVD", xposition, yposition);
  ellipse(xposition+107.5, yposition+35, 200, 40);
  textSize(30);
  fill(0);
  text("V i d e o", xposition+50, yposition+45);
  xposition = xposition + xchanger;
  yposition = yposition + ychanger;

  if (xposition >= width-215 || xposition <= 0) {
    xchanger = xchanger * -1; 
    acolor = int(random(0, 255));
    bcolor = int(random(0, 255));
    ccolor = int(random(0, 255));
  }

  if (yposition >= height || yposition <= 75) {
    ychanger = ychanger * -1;
    acolor = int(random(0, 255));
    bcolor = int(random(0, 255));
    ccolor = int(random(0, 255));
  }
}

void mouseMoved() {
 exit(); 
}
