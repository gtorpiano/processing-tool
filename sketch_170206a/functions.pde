void draw_grid() {

  strokeWeight(0.5);

  color c1 = color(204, 102, 0);
  color c2 = color(0, 102, 153);
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


void drawSelectBox(float x, float y, float w, float h){
  
  translate(0, 0, 0);
  fill(255, 255, 255);
  rect(x, y, w, h);
  translate(0, 0, -0);
  
}