import rhinoscriptsyntax as rs
import math
import random

#functions
#to draw points if necessary
def drawPts(PTLIST):
    rs.EnableRedraw(False)
    for i in range(len(PTLIST)):
        for j in range(len(PTLIST[i])):
            rs.AddPoint(PTLIST[i][j])
    rs.EnableRedraw(True)

#identify surface
srf = rs.GetObject("Select surface", 8+16) #specify surface GUID
#identify crvs
crvs = rs.GetObjects("Select polylines", 4) #specify curves GUID

proj_crvs = rs.ProjectCurveToSurface(crvs, srf, (0,0,1))

crvPts = []
for i in range(len(proj_crvs)):
    nowCrv = proj_crvs[i]
    nowCrvPts = rs.CurvePoints(nowCrv)
    crvPts.append(nowCrvPts)


#generate text file
DEM_file = open("170131_PATHtest.txt", "w")

for i in range(len(crvPts)):
    newLine = ""
    for j in range(len(crvPts[i])-1):
        strValue = str(crvPts[i][j])
        newLine = newLine + strValue + ' '
    j = j+1
    strValue = str(crvPts[i][j])
    newLine = newLine + strValue
    newLine = newLine +'\n'
    DEM_file.write(newLine)

DEM_file.close()