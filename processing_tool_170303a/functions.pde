void draw_grid(color c1, color c2, float weight) {

  strokeWeight(weight);
  color c;
  float inter;
  float avrH;

  int i = 0;
  int j = 0;

  for (i = 0; i < nrows-1; i = i+1) {
    for (j = 0; j < ncols-1; j = j+1) {

      avrH =(AllCells[i][j].h+ AllCells[i+1][j].h)/2;
      inter = (avrH - (allHeights.min()))/((allHeights.max())-(allHeights.min()));
      c = lerpColor(c1, c2, inter);
      stroke(c);

      line(AllCells[i][j].x, AllCells[i][j].y, AllCells[i][j].h, AllCells[i+1][j].x, AllCells[i+1][j].y, AllCells[i+1][j].h);

      avrH =(AllCells[i][j].h+ AllCells[i][j+1].h)/2;
      inter = (avrH - (allHeights.min()))/((allHeights.max())-(allHeights.min()));
      c = lerpColor(c1, c2, inter);
      stroke(c);

      line(AllCells[i][j].x, AllCells[i][j].y, AllCells[i][j].h, AllCells[i][j+1].x, AllCells[i][j+1].y, AllCells[i][j+1].h);
    }
  }

  for (i = 0; i < nrows-1; i = i+1) {

    avrH =(AllCells[i][j].h+ AllCells[i+1][j].h)/2;
    inter = (avrH - (allHeights.min()))/((allHeights.max())-(allHeights.min()));
    c = lerpColor(c1, c2, inter);
    stroke(c);

    line(AllCells[i][j].x, AllCells[i][j].y, AllCells[i][j].h, AllCells[i+1][j].x, AllCells[i+1][j].y, AllCells[i+1][j].h);
  }
  for (j = 0; j < ncols-1; j = j+1) {

    avrH =(AllCells[i][j].h+ AllCells[i][j+1].h)/2;
    inter = (avrH - (allHeights.min()))/((allHeights.max())-(allHeights.min()));
    c = lerpColor(c1, c2, inter);
    stroke(c);

    line(AllCells[i][j].x, AllCells[i][j].y, AllCells[i][j].h, AllCells[i][j+1].x, AllCells[i][j+1].y, AllCells[i][j+1].h);
  }
}

void simulationTest() {
  float randNum;
  for (int i = 1; i < nrows-2; i = i+1) {
    for (int j = 1; j < ncols-2; j = j+1) {

      //kill off
      randNum = random(100);
      if (randNum>simChanceDeath) {
        AllCells[i][j].green =false;
      }

      if (AllCells[i][j].green == true) {
        randNum = random(100);
        if (randNum>simChanceInfluence) {
          AllCells[i-1][j].green =true;
        }
        randNum = random(100);
        if (randNum>simChanceInfluence) {
          AllCells[i][j-1].green =true;
        }
        randNum = random(100);
        if (randNum>simChanceInfluence) {
          AllCells[i][j+1].green =true;
        }
        randNum = random(100);
        if (randNum>simChanceInfluence) {
          AllCells[i+1][j].green =true;
        }
      }
    }
  }
}


void camera_setup(int Z) {
  cam = new PeasyCam(this, Z);
  float fov = PI/3.0;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 
    cameraZ/10.0, cameraZ*10000.0);
  cam.setSuppressRollRotationMode();
}



void draw_everything(){
    for (int i = 0; i < AllRoads.length; i = i+1) {
    AllRoads[i].display(color(255, 255, 0), 2);
  }
  for (int i = 0; i < AllPaths.length; i = i+1) {
    AllPaths[i].display(color(255, 0, 255), 1);
  }
  if (dispGreen == true) {
    for (int i = 0; i < nrows; i = i+1) {
      for (int j = 0; j < ncols; j = j+1) {
        AllCells[i][j].display();
      }
    }
  }
}