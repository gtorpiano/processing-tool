class Road {

  // Road points
  PVector[] roadPts;

  // Cell Constructor
  Road() {
  } 

  void display(color c1, int stroke) {

    stroke(c1);
    strokeWeight(stroke);
    for (int i = 0; i < roadPts.length-1; i = i+1) {
      line(roadPts[i].x, roadPts[i].y, roadPts[i].z, roadPts[i+1].x, roadPts[i+1].y, roadPts[i+1].z);
    }
  }
}