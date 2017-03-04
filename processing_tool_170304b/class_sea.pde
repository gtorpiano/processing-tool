class Sea {

  PVector[] planPts;

  // Building Constructor
  Sea() {
  } 
  
  void display(color fillc, float seaH) {
    strokeWeight(0);
    fill(fillc);
    beginShape();
    for (int i = 0; i < planPts.length; i = i+1) {
      vertex(planPts[i].x-yllcorner, planPts[i].y-xllcorner, planPts[i].z+seaH);
    }
    endShape();
  }
} 