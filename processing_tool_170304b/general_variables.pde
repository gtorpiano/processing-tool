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