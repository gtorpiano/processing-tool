class Road {

  // Road points
  PVector[] roadPts;

  // Cell Constructor
  Road() {
  } 

  void display(color c1, float stroke, float displayH) {

    stroke(c1);
    strokeWeight(stroke);
    for (int i = 0; i < roadPts.length-1; i = i+1) {
      line(roadPts[i].x-yllcorner, roadPts[i].y-xllcorner, roadPts[i].z+displayH, roadPts[i+1].x-yllcorner, roadPts[i+1].y-xllcorner, roadPts[i+1].z+displayH);
    }
  }
}