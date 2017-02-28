class Cell {
  // A cell object knows about its location in the grid 
  // as well as its size with the variables x,y,w,h
  float x, y;   // x,y location of bottom left corner
  float w, h;   // width and height
  float angle; // angle for oscillating brightness

  boolean selected = false;
  boolean green = false;

  // Cell Constructor
  Cell(float tempX, float tempY, float tempW, float tempH) {
    x = tempX;
    y = tempY;
    w = tempW;
    h = tempH;
  } 

  void display() {
    if (green == true) {
      stroke(50, 200, 100);
      fill(50, 200, 100);
      translate(x, y, h);
      ellipse(0, 0, cellsize/4, cellsize/4);
      translate(-x, -y, -h);
    }
  }
  
}