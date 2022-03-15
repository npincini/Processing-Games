int xposition;
int yposition;

int xchanger = 5;
int ychanger = 5;

int a = int(random(0, 255));
int b = int(random(0, 255));
int c = int(random(0, 255));

int abackground;
int bbackground;
int cbackground;

float[] xpositionArray = new float[11];
float[] ypositionArray = new float[11];
int[] xchangerArray = new int[11];
int[] ychangerArray = new int[11];

float[] acolor = new float[11];
float[] bcolor = new float[11];
float[] ccolor = new float[11];

void setup() {
  size(1440, 850);
  abackground = (int(random(0, 255)));
  bbackground = (int(random(0, 255)));
  cbackground = (int(random(0, 255)));

  for (int i = 0; i <= 10; i++) {
    xpositionArray[i] = int(random(201, width-201));
    ypositionArray[i] = int(random(201, height-201));
    xchangerArray[i] = int(random(1, 3));
    ychangerArray[i] = int(random(1, 3));
    acolor[i] = int(random(0, 255));
    bcolor[i] = int(random(0, 255));
    ccolor[i] = int(random(0, 255));
  }

  for (int z = 0; z <= 300; z++) {
    for (int i = 0; i <= 10; i++) {
      for (int j = 0; j <= 10; j++) {
        if ((xpositionArray[i] != xpositionArray[j]) && (ypositionArray[i] != ypositionArray[j]) && (dist(xpositionArray[i], ypositionArray[i], xpositionArray[j], ypositionArray[j]) <= 200)) {
          xpositionArray[i] = int(random(100, width-100));
          ypositionArray[i] = int(random(100, height-100));
        }
      }
    }
  }
}

void draw() {
  noStroke();
  //background(abackground, bbackground, cbackground);
  background(255);
  makePlayer();
  collision();
}

void makePlayer() {

  for (int i = 0; i <= 10; i++) {
    fill(acolor[i], bcolor[i], ccolor[i]);
    circle(xpositionArray[i], ypositionArray[i], 200);
    xpositionArray[i] = xpositionArray[i] + xchangerArray[i];
    ypositionArray[i] = ypositionArray[i] + ychangerArray[i];

    if (xpositionArray[i] >= width-100 || xpositionArray[i] <= 100) {
      xchangerArray[i] = xchangerArray[i] * -1; 
      acolor[i] = int(random(0, 255));
      bcolor[i] = int(random(0, 255));
      ccolor[i] = int(random(0, 255));
    }
    if (ypositionArray[i] >= height-100 || ypositionArray[i] <= 100) {
      ychangerArray[i] = ychangerArray[i] * -1;
      acolor[i] = int(random(0, 255));
      bcolor[i] = int(random(0, 255));
      ccolor[i] = int(random(0, 255));
    }
  }
}

void collision() {
  for (int i = 0; i <= 10; i++) {
    for (int j = 0; j <= 10; j++) {
      if ((xpositionArray[i] != xpositionArray[j]) && (ypositionArray[i] != ypositionArray[j]) && (dist(xpositionArray[i], ypositionArray[i], xpositionArray[j], ypositionArray[j]) <= 201)) {
        xchangerArray[i] = xchangerArray[i] * -1;
        ychangerArray[i] = ychangerArray[i] * -1;
        acolor[i] = int(random(0, 255));
        bcolor[i] = int(random(0, 255));
        ccolor[i] = int(random(0, 255));
        abackground = (int(random(0, 255)));
        bbackground = (int(random(0, 255)));
        cbackground = (int(random(0, 255)));
      }
    }
  }
}
