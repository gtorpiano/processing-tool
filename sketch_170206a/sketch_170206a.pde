import peasy.*;
import controlP5.*;
import processing.opengl.*;

PeasyCam cam;
ControlP5 cp5;

int buttonValue = 1;

int myColor = color(255, 0, 0);

int BoxSize = 30;
int distance = 10;

float mouseLocX = 0;
float mouseLocY = 0;

FloatList allHeights = new FloatList();

//Paths
String pathGrid = "C:/Users/Giancarlo/Desktop/LU_DEM_Test/170131_test.txt";
String pathRoad = "C:/Users/Giancarlo/Desktop/LU_DEM_Test/170131_ROADtest.txt";
String pathPath = "C:/Users/Giancarlo/Desktop/LU_DEM_Test/170131_PATHtest.txt";

//Read DEM
String[] lines;
int ncols;
int nrows;
int xllcorner;
int yllcorner;
int cellsize;
int NODATA_value;

int simChanceInfluence = 50;
int simChanceDeath = 50;

String[] txtData;


float[][] DEM_data;
Cell[][] AllCells;
Road[] AllRoads;
Road[] AllPaths;

Boolean screenLock = false;
Boolean selectMode = false;
Boolean simuRun = false;
Boolean dispGreen = false;
Boolean selectBox = false;
Boolean startDrawBox = false;

int timer = 0;

Button lockS;
Button selectB;
Button runSimB;
Button greenB;


void setup() {
  frameRate(30);

  //initial DEM data reading
  lines = loadStrings(pathGrid);
  txtData = split(lines[0], ' ');
  ncols = int(txtData[txtData.length -1]);
  txtData = split(lines[1], ' ');
  nrows = int(txtData[txtData.length -1]);
  txtData = split(lines[2], ' ');
  xllcorner = int(txtData[txtData.length -1]);
  txtData = split(lines[3], ' ');
  yllcorner = int(txtData[txtData.length -1]);
  txtData = split(lines[4], ' ');
  cellsize = int(txtData[txtData.length -1]);
  txtData = split(lines[5], ' ');
  NODATA_value = int(txtData[txtData.length -1]);

  println ("ncols = ", ncols);
  println ("nrows = ", nrows);
  println ("xllcorner = ", xllcorner);
  println ("yllcorner = ", yllcorner);
  println ("cellsize = ", cellsize);
  println ("NODATA_value = ", NODATA_value);

  DEM_data = new float[nrows][ncols];
  AllCells = new Cell[nrows][ncols];

  for (int i = 6; i < lines.length; i = i+1) {
    DEM_data[i-6] = float(split(lines[i], " "));
    //println(float(split(lines[i], " ")));
  }

  for (int i = 0; i < nrows; i = i+1) {
    for (int j = 0; j < ncols; j = j+1) {
      //println(i, j);
      AllCells[i][j] = new Cell(i*cellsize, j*cellsize, cellsize, DEM_data[i][j]);
      allHeights.append(DEM_data[i][j]);
      //println(DEM_data[i][j]);
    }
  }

  //randomly assign some cells to green
  randomSeed(10);
  for (int i = 0; i < nrows; i = i+1) {
    for (int j = 0; j < ncols; j = j+1) {
      float randNum = random(100);
      if (randNum>90) {
        AllCells[i][j].green = true;
      }
    }
  }

  //initial polyline data reading
  lines = loadStrings(pathRoad);

  String[] nowString;
  float[] nowVECFloat;
  AllRoads = new Road[lines.length];

  for (int i = 0; i < lines.length; i = i+1) {   
    nowString = split(lines[i], " ");
    Road nowRoad = new Road();
    nowRoad.roadPts = new PVector[nowString.length];
    for (int j = 0; j < nowString.length; j = j+1) { 
      nowVECFloat = float(split(nowString[j], ","));
      nowRoad.roadPts[j] = new PVector(nowVECFloat[1], nowVECFloat[0], nowVECFloat[2]);
    }
    AllRoads[i] = nowRoad;
  }


  //initial polyline data reading
  lines = loadStrings(pathPath);

  AllPaths = new Road[lines.length];

  for (int i = 0; i < lines.length; i = i+1) {   
    nowString = split(lines[i], " ");
    Road nowPath = new Road();
    nowPath.roadPts = new PVector[nowString.length];
    for (int j = 0; j < nowString.length; j = j+1) { 
      nowVECFloat = float(split(nowString[j], ","));
      nowPath.roadPts[j] = new PVector(nowVECFloat[1], nowVECFloat[0], nowVECFloat[2]);
    }
    AllPaths[i] = nowPath;
  }


  //graphics
  size(1600, 1000, P3D);
  cam = new PeasyCam(this, 5000);
  cam.setSuppressRollRotationMode();

  cp5 = new ControlP5(this);

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

  /*
  cp5.addSlider("BoxSize")
   .setPosition(100, 25)
   .setRange(0, 100)
   ;
   cp5.addSlider("distance")
   .setPosition(100, 50)
   .setRange(0, 20)
   ;
   */

  cp5.setAutoDraw(false);
}



void draw() {

  background(0);

  if (screenLock == true) {
    cam.setActive(false);
  } else {
    cam.setActive(true);
  }


  /*
  if ((mousePressed == true) && (mouseButton == LEFT)) {

    println (mouseX, mouseY);
  }
  */

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


  /*
  for (int i = 0; i < nrows; i = i+1) {
   for (int j = 0; j < ncols; j = j+1) {
   
   float circleX = screenX(AllCells[i][j].x, AllCells[i][j].y, AllCells[i][j].h);
   float circleY = screenY(AllCells[i][j].x, AllCells[i][j].y, AllCells[i][j].h);
   //float circleZ = screenZ(AllCells[i][j].x, AllCells[i][j].y, AllCells[i][j].h);
   
   //if ((AllCells[i][j].x >= mouseLocX-5)  && (AllCells[i][j].x <= mouseLocX+5) && (AllCells[i][j].y >= mouseLocY-5) & (AllCells[i][j].y <= mouseLocY+5) ) {
   if ((circleX >= mouseLocX-5)  && (circleX <= mouseLocX+5) && (circleY >= mouseLocY-5) && (circleY <= mouseLocY+5) ) {
   
   if (AllCells[i][j].selected == false) {
   AllCells[i][j].selected = true;
   } else {
   AllCells[i][j].selected = false;
   }
   //AllCells[i][j].selected = true;
   mouseLocX = 0;
   mouseLocY = 0;
   }
   
   AllCells[i][j].display();
   }
   }
   */



  gui();

  draw_grid();

  if (simuRun == true) {
    simulationTest();
  }

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


void gui() {
  hint(DISABLE_DEPTH_TEST);
  cam.beginHUD();
  cp5.draw();
  cam.endHUD();
  hint(ENABLE_DEPTH_TEST);
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

void button(float theValue) {
  myColor = color(255, 255, 255);
  //println("a button event. "+theValue);
}