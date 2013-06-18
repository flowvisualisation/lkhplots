
OpenDatabase("localhost:/Users/gmurphy/Documents/pluto4/PLUTO/KH/3d/data.*.vtk database", 119)
DefineScalarExpression("unnamed1", "")
DefineScalarExpression("unnamed2", "")
DefineVectorExpression("cmfe0", "pos_cmfe(<[0]i:3D_Velocity_Field>, mesh, 10.000000)")
# MAINTENANCE ISSUE: SetSuppressMessagesRPC is not handled in Logging.C. Please contact a VisIt developer.
SaveSession("/Users/gmurphy/.visit/crash_recovery.session")
# MAINTENANCE ISSUE: SetSuppressMessagesRPC is not handled in Logging.C. Please contact a VisIt developer.
DefineScalarExpression("unnamed1", "")
DefineScalarExpression("unnamed2", "")
DefineVectorExpression("cmfe0", "pos_cmfe(<[0]i:3D_Velocity_Field>, mesh, 10.000000)")
DefineScalarExpression("gmcmfe0", "magnitude(cmfe0)")
AddPlot("Pseudocolor", "gmcmfe0", 1, 0)
DrawPlots()
# Begin spontaneous state
View3DAtts = View3DAttributes()
View3DAtts.viewNormal = (-0.523179, 0.199223, 0.82861)
View3DAtts.focus = (0.00134993, 0, 0.00134993)
View3DAtts.viewUp = (0.14872, 0.978716, -0.141412)
View3DAtts.viewAngle = 30
View3DAtts.parallelScale = 8.16112
View3DAtts.nearPlane = -16.3222
View3DAtts.farPlane = 16.3222
View3DAtts.imagePan = (0, 0)
View3DAtts.imageZoom = 1
View3DAtts.perspective = 1
View3DAtts.eyeAngle = 2
View3DAtts.centerOfRotationSet = 0
View3DAtts.centerOfRotation = (0.00134993, 0, 0.00134993)
View3DAtts.axis3DScaleFlag = 0
View3DAtts.axis3DScales = (1, 1, 1)
View3DAtts.shear = (0, 0, 1)
SetView3D(View3DAtts)
# End spontaneous state

SetTimeSliderState(68)
SetTimeSliderState(45)
SetTimeSliderState(40)
SetTimeSliderState(29)
SetTimeSliderState(27)
SetTimeSliderState(25)
# The AnimationPlay RPC is not supported in the VisIt module so it will not be logged.
# The AnimationStop RPC is not supported in the VisIt module so it will not be logged.
# Begin spontaneous state
View3DAtts = View3DAttributes()
View3DAtts.viewNormal = (-0.523179, 0.199223, 0.82861)
View3DAtts.focus = (0.00134993, 0, 0.00134993)
View3DAtts.viewUp = (0.14872, 0.978716, -0.141412)
View3DAtts.viewAngle = 30
View3DAtts.parallelScale = 8.16112
View3DAtts.nearPlane = -16.3222
View3DAtts.farPlane = 16.3222
View3DAtts.imagePan = (0, 0)
View3DAtts.imageZoom = 1
View3DAtts.perspective = 1
View3DAtts.eyeAngle = 2
View3DAtts.centerOfRotationSet = 0
View3DAtts.centerOfRotation = (0.00134993, 0, 0.00134993)
View3DAtts.axis3DScaleFlag = 0
View3DAtts.axis3DScales = (1, 1, 1)
View3DAtts.shear = (0, 0, 1)
SetView3D(View3DAtts)
# End spontaneous state


