class Building {

  PVector[] planPts;
  Float buildH;

  // Building Constructor
  Building() {
  } 
  
  void display(color fillc) {
    strokeWeight(0);
    fill(fillc);
    beginShape();
    for (int i = 0; i < planPts.length; i = i+1) {
      vertex(planPts[i].x-yllcorner, planPts[i].y-xllcorner, planPts[i].z);
    }
    endShape();
  }
} 