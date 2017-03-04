void gui() {
  hint(DISABLE_DEPTH_TEST);
  cam.beginHUD();
  cp5.draw();
  cam.endHUD();
  hint(ENABLE_DEPTH_TEST);
  
  if (screenLock == true) {
    cam.setActive(false);
  } else {
    cam.setActive(true);
  }
}

public void LOCK_SCREEN() {
  if (screenLock==true) {
    screenLock = false;
    lockS.setColorBackground(color(90));
  } else {
    screenLock = true;
    lockS.setColorBackground(color(200, 0, 0));
  }
}

public void SELECT() {
  if (selectMode==true) {
    selectMode = false;
    selectB.setColorBackground(color(90));
    selectBox = false;
    startDrawBox = false;
  } else {
    selectMode = true;
    selectB.setColorBackground(color(200, 0, 0));
    timer = millis();
  }
}

public void SIMULATION_RUN() {
  if (simuRun==true) {
    simuRun = false;
    runSimB.setColorBackground(color(90));
  } else {
    simuRun = true;
    runSimB.setColorBackground(color(200, 0, 0));
  }
}


public void DISP_GREEN() {
  if (dispGreen==true) {
    dispGreen = false;
    greenB.setColorBackground(color(90));
  } else {
    dispGreen = true;
    greenB.setColorBackground(color(200, 0, 0));
  }
}

public void RECORD() {
  if (screenRecord==true) {
    screenRecord = false;
    recordScreenB.setColorBackground(color(90));
  } else {
    screenRecord = true;
    recordScreenB.setColorBackground(color(200, 0, 0));
  }
}
  
  public void EXPORT_DXF() {
  if (exportDxf==false) {
    exportDxf = true;
  }
  
}

void button_setup(){
  
    lockS = cp5.addButton("LOCK_SCREEN")
    .setValue(0)
    .setPosition(100, 100)
    .setSize(200, 19)
    ;
  lockS.setColorBackground(color(90)); // default color
  screenLock = false;

  selectB = cp5.addButton("SELECT")
    .setValue(0)
    .setPosition(100, 130)
    .setSize(200, 19)
    ;
  selectB.setColorBackground(color(90)); // default color
  selectMode = false;

  runSimB = cp5.addButton("SIMULATION_RUN")
    .setValue(0)
    .setPosition(100, 160)
    .setSize(200, 19)
    ;
  runSimB.setColorBackground(color(90)); // default color
  simuRun = false;

  greenB = cp5.addButton("DISP_GREEN")
    .setValue(0)
    .setPosition(100, 190)
    .setSize(200, 19)
    ;
  greenB.setColorBackground(color(90)); // default color
  dispGreen = false;
  
  recordScreenB = cp5.addButton("RECORD")
    .setValue(0)
    .setPosition(100, 220)
    .setSize(200, 19)
    ;
  recordScreenB.setColorBackground(color(90)); // default color
  screenRecord = false;
  
  exportDxfB = cp5.addButton("EXPORT_DXF")
    .setValue(0)
    .setPosition(100, 250)
    .setSize(200, 19)
    ;
  exportDxfB.setColorBackground(color(90)); // default color
  exportDxf = false;

  cp5.setAutoDraw(false);
}

void drawSelectBox(float x, float y, float w, float h) {

  translate(0, 0, 0);
  fill(255, 255, 255);
  rect(x, y, w, h);
  translate(0, 0, -0);
}

void check_mouse_input(){
    if ((mousePressed == true) && (mouseButton == LEFT) && (millis()-timer>100)) {
    if ((selectMode == true)&&(startDrawBox==false)) {
      mouseLocX = mouseX;
      mouseLocY = mouseY;
      selectBox = true;
      timer = millis();
      startDrawBox = true;
    }
  }

  if ((selectBox == true)&&(selectMode == true)) {
    //draw in 2d!
    hint(DISABLE_DEPTH_TEST);
    cam.beginHUD();
    drawSelectBox(mouseLocX, mouseLocY, mouseX-mouseLocX, mouseY-mouseLocY);
    cam.endHUD();
    hint(ENABLE_DEPTH_TEST);
    //end draw in 2d

    if ((mousePressed == true) && (mouseButton == LEFT) && (millis()-timer>100)) {
      selectBox = false;
      timer = millis();
      startDrawBox = false;
    }
  }
}