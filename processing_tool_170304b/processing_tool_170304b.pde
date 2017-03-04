import peasy.*; //<>//
import controlP5.*;
import processing.opengl.*;
import processing.dxf.*;

void setup() {  
  //import data
  import_all_data();
  
  //graphics
  //size(1600, 1000, P3D);
  frameRate(30);
  fullScreen(P3D);
  camera_setup(20000);

  cp5 = new ControlP5(this);
  button_setup();
}


void draw() {
  background(BACKGROUNDCOLOUR);
  gui();
  check_mouse_input();
  if (exportDxf == true) {
    beginRaw(DXF, "dxf/output.dxf");
  }
  
   draw_everything();
   
   if (screenRecord == true) {
    saveFrame("recording/img-######.tif");
  }
  if (exportDxf == true) {
    endRaw();
    exportDxf = false;
  }
}