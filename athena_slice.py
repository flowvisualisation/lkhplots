
OpenDatabase("localhost:./CylNewtZ8.*.vtk database", 0)
DefineScalarExpression("v1", "momentum[0]/density")
DefineScalarExpression("v2", "momentum[1]/density")
DefineScalarExpression("v3", "momentum[2]/density")
DefineVectorExpression("vel", "momentum/density")
DefineScalarExpression("b1", "cell_centered_B[0]")
DefineScalarExpression("b2", "cell_centered_B[1]")
DefineScalarExpression("b3", "cell_centered_B[2]")


SetWindowLayout(6)

n=1
SetActiveWindow(n)
ToggleLockTime()
ToggleLockViewMode()
AddPlot("Pseudocolor", "b1", 1,1)
PseudocolorAtts = PseudocolorAttributes()
PseudocolorAtts.limitsMode = PseudocolorAtts.CurrentPlot 
SetPlotOptions(PseudocolorAtts)
# Begin spontaneous state
View3DAtts = View3DAttributes()
View3DAtts.viewNormal = (-0.0254419, -0.999671, 0.00331183)
View3DAtts.focus = (2, 3.57628e-07, 0)
View3DAtts.viewUp = (0.0506917, 0.00201854, 0.998712)
View3DAtts.viewAngle = 30
View3DAtts.parallelScale = 3.33461
View3DAtts.nearPlane = -6.66921
View3DAtts.farPlane = 6.66921
View3DAtts.imagePan = (0, 0)
View3DAtts.imageZoom = 1
View3DAtts.perspective = 1
View3DAtts.eyeAngle = 2
View3DAtts.centerOfRotationSet = 0
View3DAtts.centerOfRotation = (2, 3.57628e-07, 0)
View3DAtts.axis3DScaleFlag = 0
View3DAtts.axis3DScales = (1, 1, 1)
View3DAtts.shear = (0, 0, 1)
SetView3D(View3DAtts)
DrawPlots()
#AddOperator("Slice", n)


n=2
SetActiveWindow(n)
ToggleLockTime()
ToggleLockViewMode()
AddPlot("Pseudocolor", "b2", 1,1)
PseudocolorAtts = PseudocolorAttributes()
PseudocolorAtts.limitsMode = PseudocolorAtts.CurrentPlot 
SetPlotOptions(PseudocolorAtts)
DrawPlots()

n=3
SetActiveWindow(n)
ToggleLockTime()
ToggleLockViewMode()
AddPlot("Pseudocolor", "b3", 1,1)
PseudocolorAtts = PseudocolorAttributes()
PseudocolorAtts.limitsMode = PseudocolorAtts.CurrentPlot 
SetPlotOptions(PseudocolorAtts)
DrawPlots()

n=4
SetActiveWindow(n)
ToggleLockTime()
ToggleLockViewMode()
AddPlot("Pseudocolor", "v1", 1,1)
PseudocolorAtts = PseudocolorAttributes()
PseudocolorAtts.limitsMode = PseudocolorAtts.CurrentPlot 
SetPlotOptions(PseudocolorAtts)
DrawPlots()

n=5
SetActiveWindow(n)
ToggleLockTime()
ToggleLockViewMode()
AddPlot("Pseudocolor", "v2", 1,1)
PseudocolorAtts = PseudocolorAttributes()
PseudocolorAtts.limitsMode = PseudocolorAtts.CurrentPlot 
SetPlotOptions(PseudocolorAtts)
DrawPlots()

n=6
SetActiveWindow(n)
ToggleLockTime()
ToggleLockViewMode()
AddPlot("Pseudocolor", "v3", 1,1)
PseudocolorAtts = PseudocolorAttributes()
PseudocolorAtts.limitsMode = PseudocolorAtts.CurrentPlot 
SetPlotOptions(PseudocolorAtts)


DrawPlots()

