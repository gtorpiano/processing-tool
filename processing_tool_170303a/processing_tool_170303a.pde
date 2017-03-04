import peasy.*; //<>//
import controlP5.*;
import processing.opengl.*;
import processing.dxf.*;

//general variables
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
String pathGrid = "data/170131_test.txt";
String pathRoad = "data/170131_ROADtest.txt";
String pathPath = "data/170131_PATHtest.txt";

//DEM variables
String[] lines;
int ncols;
int nrows;
float xllcorner;
float yllcorner;
int cellsize;
int NODATA_value;

//simulation variables
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
Boolean screenRecord = false;
Boolean exportDxf = false;
Boolean selectBox = false;
Boolean startDrawBox = false;

int timer = 0;

Button lockS;
Button selectB;
Button runSimB;
Button greenB;
Button recordScreenB;
Button exportDxfB;

void setup() {  
  //import data
  AllCells = import_DEM(pathGrid);
  random_assign_green();
  AllRoads = import_polyline_to_road(pathRoad);
  AllPaths = import_polyline_to_road(pathPath);

  //graphics
  //size(1600, 1000, P3D);
  frameRate(30);
  fullScreen(P3D);
  camera_setup(6000);

  cp5 = new ControlP5(this);
  button_setup();
}



void draw() {
  background(0);
  gui();
  check_mouse_input();
  if (exportDxf == true) {
    beginRaw(DXF, "dxf/output.dxf");
  }
  draw_grid(color(204, 102, 0), color(0, 102, 153), 0.5);
  if (simuRun == true) {
    simulationTest();
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