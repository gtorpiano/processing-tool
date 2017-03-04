//Paths
String pathGrid = "data_1/170304_DEM.txt";
String pathRoad = "data_1/170304_roads.txt";
String pathPath = "data_1/170304_border.txt";
String pathBuildings = "data_1/170304_build.txt";
String pathOcean = "data_1/170304_ocean.txt";

color BACKGROUNDCOLOUR = color(255, 255, 255);

Cell[][] AllCells;
Road[] AllRoads;
Road[] AllPaths;
Building[] AllBuildings;
Sea[] AllSeas;


void import_all_data() {
  AllCells = import_DEM(pathGrid);
  random_assign_green();
  AllRoads = import_polyline_to_road(pathRoad);
  AllPaths = import_polyline_to_road(pathPath);
  AllBuildings = import_polyline_to_building(pathBuildings);
  AllSeas = import_polyline_to_sea(pathOcean);
}

void draw_everything() {

  if (dispGrid==true) {
    draw_grid(color(0, 102, 153), color(204, 102, 0), 0.5);
  }
  if (simuRun == true) {
    simulationTest();
  }

  for (int i = 0; i < AllRoads.length; i = i+1) {
    AllRoads[i].display(color(255, 255, 0), 2, 0);
  }

  for (int i = 0; i < AllPaths.length; i = i+1) {
    AllPaths[i].display(color(255, 0, 255), 1, 0);
  }

  if (dispBuilding == true) {
    for (int i = 0; i < AllBuildings.length; i = i+1) {
      AllBuildings[i].display(color(127));
    }
  }

  if (drawSea == true) {
    for (int i = 0; i < AllSeas.length; i = i+1) {
      AllSeas[i].display(color(39, 44, 53), -50);
    }
  }
  
  if (dispGreen == true) {
    for (int i = 0; i < nrows; i = i+1) {
      for (int j = 0; j < ncols; j = j+1) {
        AllCells[i][j].display();
      }
    }
  }
}