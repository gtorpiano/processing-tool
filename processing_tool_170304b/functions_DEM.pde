Cell[][] import_DEM(String NOWPATH) {
  
  String[] lines = loadStrings(NOWPATH);
  String[] txtData;
  Cell[][] NOWCELLS;
  float[][] NOWDEMDATA;
  
  //initial DEM data reading
  lines = loadStrings(NOWPATH);
  txtData = split(lines[0], ' ');
  ncols = int(txtData[txtData.length -1]);
  txtData = split(lines[1], ' ');
  nrows = int(txtData[txtData.length -1]);
  txtData = split(lines[2], ' ');
  xllcorner = float(txtData[txtData.length -1]);
  txtData = split(lines[3], ' ');
  yllcorner = float(txtData[txtData.length -1]);
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

  NOWDEMDATA = new float[nrows][ncols];
  NOWCELLS = new Cell[nrows][ncols];

  for (int i = 6; i < lines.length; i = i+1) {
    NOWDEMDATA[i-6] = float(split(lines[i], " "));
  }
  
  for (int i = 0; i < nrows; i = i+1) {
    for (int j = 0; j < ncols; j = j+1) {
      NOWCELLS[i][j] = new Cell(i*cellsize, j*cellsize, cellsize, NOWDEMDATA[i][j]);
      allHeights.append(NOWDEMDATA[i][j]);
    }
  }  
  
 return NOWCELLS;
}



Road[] import_polyline_to_road(String NOWPATH) {

  //initial polyline data reading
  String[] lines = loadStrings(NOWPATH);
  String[] nowString;
  float[] nowVECFloat;

  Road[] NOWROADS;
  NOWROADS = new Road[lines.length];

  for (int i = 0; i < lines.length; i = i+1) {   
    nowString = split(lines[i], " ");
    Road nowRoad = new Road();
    nowRoad.roadPts = new PVector[nowString.length];
    for (int j = 0; j < nowString.length; j = j+1) { 
      nowVECFloat = float(split(nowString[j], ","));
      nowRoad.roadPts[j] = new PVector(nowVECFloat[1], nowVECFloat[0], nowVECFloat[2]);
    }
    NOWROADS[i] = nowRoad;
  }

  return NOWROADS;
}

Building[] import_polyline_to_building(String NOWPATH) {

  //initial polyline data reading
  String[] lines = loadStrings(NOWPATH);
  String[] nowString;
  float[] nowVECFloat;

  Building[] NOWBUILDINGS;
  NOWBUILDINGS = new Building[lines.length];

  for (int i = 0; i < lines.length; i = i+1) {   
    nowString = split(lines[i], " ");
    Building nowBuilding = new Building();
    nowBuilding.planPts = new PVector[nowString.length-1];
    for (int j = 0; j < nowString.length-1; j = j+1) { 
      nowVECFloat = float(split(nowString[j], ","));
      nowBuilding.planPts[j] = new PVector(nowVECFloat[1], nowVECFloat[0], nowVECFloat[2]);
    }
    NOWBUILDINGS[i] = nowBuilding;
  }

  return NOWBUILDINGS;
}

Sea[] import_polyline_to_sea(String NOWPATH) {

  //initial polyline data reading
  String[] lines = loadStrings(NOWPATH);
  String[] nowString;
  float[] nowVECFloat;

  Sea[] NOWSEAS;
  NOWSEAS = new Sea[lines.length];

  for (int i = 0; i < lines.length; i = i+1) {   
    nowString = split(lines[i], " ");
    Sea nowSea = new Sea();
    nowSea.planPts = new PVector[nowString.length-1];
    for (int j = 0; j < nowString.length-1; j = j+1) { 
      nowVECFloat = float(split(nowString[j], ","));
      nowSea.planPts[j] = new PVector(nowVECFloat[1], nowVECFloat[0], nowVECFloat[2]);
    }
    NOWSEAS[i] = nowSea;
  }

  return NOWSEAS;
}

void random_assign_green(){
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
}