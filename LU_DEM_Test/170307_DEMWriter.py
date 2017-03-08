import rhinoscriptsyntax as rs

srf=rs.ObjectsByLayer("surface")
bboxpts=rs.BoundingBox(srf)
#print len(bboxpts)

xlist=[]
ylist=[]
zlist=[]

for i in range (len(bboxpts)):
    #print bboxpts[i][0]
    xlist.append(bboxpts[i][0])
    ylist.append(bboxpts[i][1])
    zlist.append(bboxpts[i][2])

xleng=(max(xlist)-min(xlist))

yleng=(max(ylist)-min(ylist))

cellsize = 50

stepsy=int(yleng/cellsize)+1
stepsx=int(xleng/cellsize)+1

print stepsy, stepsx
rs.EnableRedraw(False)
ptlist=[]
for i in range (stepsy):
    rows=[]
    for j in range (stepsx):
        nowpt=[j*cellsize+min(xlist),i*cellsize+min(ylist),min(zlist)]
        ptonsrf=rs.ProjectPointToSurface(nowpt,srf,[0,0,1])
        if len(ptonsrf)>0:
            rs.AddPoints(ptonsrf)
            rows.append(ptonsrf[0])
        else:
            rows.append(nowpt)
            rs.AddPoint(nowpt)
    ptlist.append(rows)
print len(ptlist), len(rows)

#assign variables for text file

#write to text file
line1 = 'ncols         '+str(ncols) +'\n'
textfile.write(line1)
line2 = 'nrows         '+str(nrows) +'\n'
textfile.write(line2)
line3 = 'xllcorner     '+str(xllcorner) +'\n'
textfile.write(line3)
line4 = 'yllcorner     '+str(yllcorner) +'\n'
textfile.write(line4)
line5 = 'cellsize      '+str(cellsize) +'\n'
textfile.write(line5)
line6 = 'NODATA_value  '+str(NODATA_value) +'\n'


for i in range(len(ptlist)):
    nowline= ""
    row = ptlist[i]
    for j in range(len(row)):
        strvalue=str("{0:.3f}".format(row[j][2]))
        nowline=nowline + strvalue + ' '
    nowline=nowline+'\n'
    textfile.write(nowline)
    
textfile.close()

"""
for row in rows:
    print row[2]
"""
rs.EnableRedraw(True)
