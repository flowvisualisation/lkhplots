xsize=500
ysize=400
num=3
#SetWindowArea(400, 0, num*(xsize+100), num*ysize)

import math
#OpenDatabase("mri3d.vtk")
OpenDatabase("localhost:./data.*.vtk database", 0)

DeleteAllPlots()
SetWindowLayout(9)

DefineScalarExpression("x", "coord(mesh)[0]")
DefineScalarExpression("y", "coord(mesh)[1]")
DefineScalarExpression("z", "coord(mesh)[2]")

DefineScalarExpression("sbq", "1.5")
DefineScalarExpression("sbomega", "1e-3")
DefineScalarExpression("sba", "-0.5*sbq*sbomega")
DefineScalarExpression("vsh", "2.0*sba")
DefineScalarExpression("vshear", "vsh*x")


DefineScalarExpression("bx", "3D_Magnetic_Field[0]")
DefineScalarExpression("by", "3D_Magnetic_Field[1]")
DefineScalarExpression("bz", "3D_Magnetic_Field[2]")
DefineScalarExpression("vx", "3D_Velocity_Field[0]")
DefineScalarExpression("vy", "3D_Velocity_Field[1]-vshear")
DefineScalarExpression("vz", "3D_Velocity_Field[2]")

pistr=str(math.pi)

DefineScalarExpression("pi", pistr)

DefineScalarExpression("logbx2", "log10(bx^2)")
DefineScalarExpression("logby2", "log10(by^2)")
DefineScalarExpression("logbz2", "log10(bz^2)")
DefineScalarExpression("logvx2", "log10(vx^2)")
DefineScalarExpression("logvy2", "log10(vy^2,1e-43)")
DefineScalarExpression("logvz2", "log10(vz^2,1e-43)")
DefineScalarExpression("thetaB", "atan(bx/by)*180/pi")
DefineScalarExpression("thetaV", "atan(bx/by)*180/pi")



SetActiveWindow(1)
AddPlot("Pseudocolor", "logbx2" )
ToggleLockViewMode()
ToggleLockTime()
DrawPlots()

SetActiveWindow(2)
AddPlot("Pseudocolor", "logby2" )
ToggleLockViewMode()
ToggleLockTime()
DrawPlots()

SetActiveWindow(3)
AddPlot("Pseudocolor", "logbz2" )
ToggleLockViewMode()
ToggleLockTime()
DrawPlots()

SetActiveWindow(4)
AddPlot("Pseudocolor", "logvx2" )
ToggleLockViewMode()
ToggleLockTime()
DrawPlots()

SetActiveWindow(5)
AddPlot("Pseudocolor", "logvy2" )
ToggleLockViewMode()
ToggleLockTime()
DrawPlots()

SetActiveWindow(6)
AddPlot("Pseudocolor", "logvz2" )
ToggleLockViewMode()
ToggleLockTime()
DrawPlots()

SetActiveWindow(7)
AddPlot("Pseudocolor", "thetaV" )
ToggleLockViewMode()
ToggleLockTime()
DrawPlots()

SetActiveWindow(8)
AddPlot("Pseudocolor", "thetaB" )
ToggleLockViewMode()
ToggleLockTime()
DrawPlots()


doquery=1
dovalues=1
if (doquery == 1 ):
	if (dovalues == 1 ):
		for i in range (1,7):
			SetActiveWindow(i)
			QueryOverTime("Max",end_time=20,  start_time=0, stride=1)
		SetActiveWindow(9)
		CurveAtts = CurveAttributes()
		CurveAtts.showLines = 1
		CurveAtts.lineStyle = CurveAtts.SOLID  # SOLID, DASH, DOT, DOTDASH
		CurveAtts.lineWidth = 2
		CurveAtts.showPoints = 1
		CurveAtts.symbol = CurveAtts.Point  # Point, TriangleUp, TriangleDown, Square, Circle, Plus, X
		CurveAtts.pointSize = 5
		CurveAtts.pointFillMode = CurveAtts.Static  # Static, Dynamic
		CurveAtts.pointStride = 1
		CurveAtts.symbolDensity = 50
		CurveAtts.curveColorSource = CurveAtts.Cycle  # Cycle, Custom
		CurveAtts.curveColor = (255, 255, 0, 255)
		CurveAtts.showLegend = 1
		CurveAtts.showLabels = 1
		CurveAtts.designator = ""
		CurveAtts.doBallTimeCue = 0
		CurveAtts.ballTimeCueColor = (0, 0, 0, 255)
		CurveAtts.timeCueBallSize = 0.01
		CurveAtts.doLineTimeCue = 0
		CurveAtts.lineTimeCueColor = (0, 0, 0, 255)
		CurveAtts.lineTimeCueWidth = 0
		CurveAtts.doCropTimeCue = 0
		CurveAtts.timeForTimeCue = 0
		#SetActivePlots((0,1,2,3,4,5))
		#SetPlotOptions(CurveAtts)
	else:
		for i in range (7,9):
			SetActiveWindow(i)
			QueryOverTime("Max",end_time=20,  start_time=0, stride=1)


doloop=0
if (doloop == 1): 
	for state in range(0,1):
		SetTimeSliderState(state)
		DrawPlots()
	#SaveWindow()
		doplot=1
		if ( doplot == 1 ):
			sw=SaveWindowAttributes()
			sw.saveTiled=1
			sw.progressive=1
			sw.family = 0
			sw.width = 1024
			sw.height = 768
			sw.resConstraint = saveatts.NoConstraint
			sw.outputToCurrentDirectory = 1
			sw.fileName = 'result-susceptibility.png'
			SetSaveWindowAttributes(sw)
			SaveWindow()

