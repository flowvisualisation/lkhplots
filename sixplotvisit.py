OpenDatabase("localhost:./data.*.vtk database", 0)
SetWindowLayout(6)
DefineScalarExpression("v1", "3D_Velocity_Field[0]")
DefineScalarExpression("v2", "3D_Velocity_Field[1]")
DefineScalarExpression("v3", "3D_Velocity_Field[2]")
DefineScalarExpression("b1", "3D_Magnetic_Field[0]")
DefineScalarExpression("b2", "3D_Magnetic_Field[1]")
DefineScalarExpression("b3", "3D_Magnetic_Field[2]")
DefineVectorExpression("curlv", "curl(3D_Velocity_Field)")
DefineScalarExpression("curlvx", "curlv[0]")
DefineScalarExpression("curlvy", "curlv[1]")
DefineScalarExpression("curlvz", "curlv[2]")
AddPlot("Pseudocolor", "v1", 1, 1)
SetActivePlots(0)
SetActivePlots(0)
SetTimeSliderState(3)
DrawPlots()
# Begin spontaneous state
View3DAtts = View3DAttributes()
View3DAtts.viewNormal = (-0.595688, 0.514421, 0.616869)
View3DAtts.focus = (0, 0, 0)
View3DAtts.viewUp = (0.17214, 0.831916, -0.527525)
View3DAtts.viewAngle = 30
View3DAtts.parallelScale = 1.2
View3DAtts.nearPlane = -2.4
View3DAtts.farPlane = 2.4
View3DAtts.imagePan = (0, 0)
View3DAtts.imageZoom = 1
View3DAtts.perspective = 1
View3DAtts.eyeAngle = 2
View3DAtts.centerOfRotationSet = 0
View3DAtts.centerOfRotation = (0, 0, 0)
View3DAtts.axis3DScaleFlag = 0
View3DAtts.axis3DScales = (1, 1, 1)
View3DAtts.shear = (0, 0, 1)
SetView3D(View3DAtts)
# End spontaneous state

SetActiveWindow(2)
SetActiveWindow(2)
AddPlot("Pseudocolor", "v2", 1, 1)
DrawPlots()
# Begin spontaneous state
View3DAtts = View3DAttributes()
View3DAtts.viewNormal = (-0.556645, 0.443156, 0.70268)
View3DAtts.focus = (0, 0, 0)
View3DAtts.viewUp = (0.34082, 0.893199, -0.293321)
View3DAtts.viewAngle = 30
View3DAtts.parallelScale = 1.2
View3DAtts.nearPlane = -2.4
View3DAtts.farPlane = 2.4
View3DAtts.imagePan = (0, 0)
View3DAtts.imageZoom = 1
View3DAtts.perspective = 1
View3DAtts.eyeAngle = 2
View3DAtts.centerOfRotationSet = 0
View3DAtts.centerOfRotation = (0, 0, 0)
View3DAtts.axis3DScaleFlag = 0
View3DAtts.axis3DScales = (1, 1, 1)
View3DAtts.shear = (0, 0, 1)
SetView3D(View3DAtts)
# End spontaneous state

SetActiveWindow(3)
SetActiveWindow(3)
AddPlot("Pseudocolor", "v3", 1, 1)
DrawPlots()
SetActiveWindow(4)
SetActiveWindow(4)
AddPlot("Pseudocolor", "curlvx", 1, 1)
DrawPlots()
# Begin spontaneous state
View3DAtts = View3DAttributes()
View3DAtts.viewNormal = (-0.622637, 0.592584, 0.511046)
View3DAtts.focus = (0, 0, 0)
View3DAtts.viewUp = (0.184057, 0.745667, -0.640393)
View3DAtts.viewAngle = 30
View3DAtts.parallelScale = 1.2
View3DAtts.nearPlane = -2.4
View3DAtts.farPlane = 2.4
View3DAtts.imagePan = (0, 0)
View3DAtts.imageZoom = 1
View3DAtts.perspective = 1
View3DAtts.eyeAngle = 2
View3DAtts.centerOfRotationSet = 0
View3DAtts.centerOfRotation = (0, 0, 0)
View3DAtts.axis3DScaleFlag = 0
View3DAtts.axis3DScales = (1, 1, 1)
View3DAtts.shear = (0, 0, 1)
SetView3D(View3DAtts)
# End spontaneous state

SetActiveWindow(5)
SetActiveWindow(5)
AddPlot("Pseudocolor", "curlvy", 1, 1)
DrawPlots()
# Begin spontaneous state
View3DAtts = View3DAttributes()
View3DAtts.viewNormal = (-0.489695, 0.499501, 0.714632)
View3DAtts.focus = (0, 0, 0)
View3DAtts.viewUp = (0.121362, 0.850702, -0.511446)
View3DAtts.viewAngle = 30
View3DAtts.parallelScale = 1.2
View3DAtts.nearPlane = -2.4
View3DAtts.farPlane = 2.4
View3DAtts.imagePan = (0, 0)
View3DAtts.imageZoom = 1
View3DAtts.perspective = 1
View3DAtts.eyeAngle = 2
View3DAtts.centerOfRotationSet = 0
View3DAtts.centerOfRotation = (0, 0, 0)
View3DAtts.axis3DScaleFlag = 0
View3DAtts.axis3DScales = (1, 1, 1)
View3DAtts.shear = (0, 0, 1)
SetView3D(View3DAtts)
# End spontaneous state

SetActiveWindow(6)
SetActiveWindow(6)
AddPlot("Pseudocolor", "curlvz", 1, 1)
DrawPlots()
# Begin spontaneous state
View3DAtts = View3DAttributes()
View3DAtts.viewNormal = (-0.477381, 0.378525, 0.792985)
View3DAtts.focus = (0, 0, 0)
View3DAtts.viewUp = (0.0693575, 0.915873, -0.395431)
View3DAtts.viewAngle = 30
View3DAtts.parallelScale = 1.2
View3DAtts.nearPlane = -2.4
View3DAtts.farPlane = 2.4
View3DAtts.imagePan = (0, 0)
View3DAtts.imageZoom = 1
View3DAtts.perspective = 1
View3DAtts.eyeAngle = 2
View3DAtts.centerOfRotationSet = 0
View3DAtts.centerOfRotation = (0, 0, 0)
View3DAtts.axis3DScaleFlag = 0
View3DAtts.axis3DScales = (1, 1, 1)
View3DAtts.shear = (0, 0, 1)
SetView3D(View3DAtts)
# End spontaneous state

SetActiveWindow(3)
SetActiveWindow(3)
# Begin spontaneous state
View3DAtts = View3DAttributes()
View3DAtts.viewNormal = (-0.398946, 0.377932, 0.83547)
View3DAtts.focus = (0, 0, 0)
View3DAtts.viewUp = (-0.0515013, 0.900443, -0.431915)
View3DAtts.viewAngle = 30
View3DAtts.parallelScale = 1.2
View3DAtts.nearPlane = -2.4
View3DAtts.farPlane = 2.4
View3DAtts.imagePan = (0, 0)
View3DAtts.imageZoom = 1
View3DAtts.perspective = 1
View3DAtts.eyeAngle = 2
View3DAtts.centerOfRotationSet = 0
View3DAtts.centerOfRotation = (0, 0, 0)
View3DAtts.axis3DScaleFlag = 0
View3DAtts.axis3DScales = (1, 1, 1)
View3DAtts.shear = (0, 0, 1)
SetView3D(View3DAtts)
# End spontaneous state

SetActiveWindow(1)
SetActiveWindow(1)
# The AnimationPlay RPC is not supported in the VisIt module so it will not be logged.
# The AnimationStop RPC is not supported in the VisIt module so it will not be logged.
SetActiveWindow(4)
SetActiveWindow(4)
# The AnimationPlay RPC is not supported in the VisIt module so it will not be logged.
# MAINTENANCE ISSUE: SetSuppressMessagesRPC is not handled in Logging.C. Please contact a VisIt developer.
SaveSession("/homea/gmurphy/.visit/crash_recovery.session")
# MAINTENANCE ISSUE: SetSuppressMessagesRPC is not handled in Logging.C. Please contact a VisIt developer.
# The AnimationStop RPC is not supported in the VisIt module so it will not be logged.

