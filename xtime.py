OpenDatabase("localhost:./data.*.vtk database", 0)

DefineScalarExpression("x", "coord(mesh)[0]")
DefineScalarExpression("y", "coord(mesh)[1]")
DefineScalarExpression("z", "coord(mesh)[2]")
DefineScalarExpression("t", "0.0*coord(mesh)[2]")

import math
testvar=math.pi
DefineScalarExpression("growthrate", "0.74975229")
DefineScalarExpression("pi", "%f" %testvar)
DefineScalarExpression("sbq", "1.5")
DefineScalarExpression("sbomega", "1e-3")
DefineScalarExpression("sba", "-0.5*sbq*sbomega")
DefineScalarExpression("vsh", "2.0*sba")
DefineScalarExpression("vshear", "vsh*x")

DefineScalarExpression("lx","2.0" )
DefineScalarExpression("eps","1.0e-3" )
DefineScalarExpression("scrh","lx*eps*sbomega/8.0" )
DefineScalarExpression("vmri", "exp(growthrate*t)*scrh*sin(2*pi*z)")

SetWindowLayout(6)

# Begin spontaneous state
View3DAtts = View3DAttributes()
View3DAtts.viewNormal = (0.596332, -0.781887, 0.181771)
View3DAtts.focus = (1, 1, 1)
View3DAtts.viewUp = (-0.145957, 0.117053, 0.982342)
View3DAtts.viewAngle = 30
View3DAtts.parallelScale = 1.73205
View3DAtts.nearPlane = -3.4641
View3DAtts.farPlane = 3.4641
View3DAtts.imagePan = (0, 0)
View3DAtts.imageZoom = 1
View3DAtts.perspective = 1
View3DAtts.eyeAngle = 2
View3DAtts.centerOfRotationSet = 0
View3DAtts.centerOfRotation = (1, 1, 1)
View3DAtts.axis3DScaleFlag = 0
View3DAtts.axis3DScales = (1, 1, 1)
View3DAtts.shear = (0, 0, 1)
SetView3D(View3DAtts)
# End spontaneous state


DefineScalarExpression("ufull", "3D_Velocity_Field[0]")
DefineScalarExpression("u", "3D_Velocity_Field[0]-vmri")
DefineScalarExpression("v", "(3D_Velocity_Field[1]-vshear-vmri)")
DefineScalarExpression("w", "3D_Velocity_Field[2]")
DefineVectorExpression("velocity", "{u,v,w}")
DefineVectorExpression("vel2d", "{u,0.0*v,w}")
DefineVectorExpression("curlv", "curl(velocity)")
DefineScalarExpression("curlvx", "curlv[0]")
DefineScalarExpression("curlvy", "curlv[1]")
DefineScalarExpression("curlvz", "curlv[2]")




SetActiveWindow(1)
ToggleLockViewMode()
ToggleLockTime()
AddPlot("Pseudocolor", "t")
DrawPlots()

SetActiveWindow(2)
ToggleLockViewMode()
ToggleLockTime()
AddPlot("Pseudocolor", "vmri")
DrawPlots()

SetActiveWindow(3)
ToggleLockViewMode()
ToggleLockTime()
AddPlot("Pseudocolor", "u")
DrawPlots()

SetActiveWindow(4)
ToggleLockViewMode()
ToggleLockTime()
AddPlot("Pseudocolor", "ufull")
DrawPlots()



SetActiveWindow(5)
ToggleLockViewMode()
ToggleLockTime()
AddPlot("Pseudocolor", "curlvy")
AddOperator("Slice", 0)
SliceAtts = SliceAttributes()
SliceAtts.originType = SliceAtts.Point  # Point, Intercept, Percent, Zone, Node
SliceAtts.originPoint = (0, 0, 0)
SliceAtts.originIntercept = 0
SliceAtts.originPercent = 0
SliceAtts.originZone = 0
SliceAtts.originNode = 0
SliceAtts.normal = (0, -1, 0)
SliceAtts.axisType = SliceAtts.Arbitrary  # XAxis, YAxis, ZAxis, Arbitrary, ThetaPhi
SliceAtts.upAxis = (0, 0, 1)
SliceAtts.project2d = 0
SliceAtts.interactive = 1
SliceAtts.flip = 0
SliceAtts.originZoneDomain = 0
SliceAtts.originNodeDomain = 0
SliceAtts.meshName = "mesh"
SliceAtts.theta = 0
SliceAtts.phi = 0
SetOperatorOptions(SliceAtts, 1)
AddPlot("Vector", "vel2d")
VectorAtts = VectorAttributes()
VectorAtts.glyphLocation = VectorAtts.AdaptsToMeshResolution  # AdaptsToMeshResolution, UniformInSpace
VectorAtts.useStride = 0
VectorAtts.stride = 1
VectorAtts.nVectors = 400
VectorAtts.lineStyle = VectorAtts.SOLID  # SOLID, DASH, DOT, DOTDASH
VectorAtts.lineWidth = 0
VectorAtts.scale = 0.25
VectorAtts.scaleByMagnitude = 1
VectorAtts.autoScale = 1
VectorAtts.headSize = 0.25
VectorAtts.headOn = 1
VectorAtts.colorByMag = 1
VectorAtts.useLegend = 1
VectorAtts.vectorColor = (0, 0, 0, 255)
VectorAtts.colorTableName = "Default"
VectorAtts.invertColorTable = 0
VectorAtts.vectorOrigin = VectorAtts.Tail  # Head, Middle, Tail
VectorAtts.minFlag = 0
VectorAtts.maxFlag = 0
VectorAtts.limitsMode = VectorAtts.OriginalData  # OriginalData, CurrentPlot
VectorAtts.min = 0
VectorAtts.max = 1
VectorAtts.lineStem = 1
VectorAtts.geometryQuality = VectorAtts.Fast  # Fast, High
VectorAtts.stemWidth = 0.08
VectorAtts.origOnly = 1
VectorAtts.glyphType = VectorAtts.Arrow  # Arrow, Ellipsoid
SetPlotOptions(VectorAtts)

DrawPlots()

SetActiveWindow(6)
ToggleLockViewMode()
ToggleLockTime()
AddPlot("Pseudocolor", "w")
DrawPlots()
#SetActiveWindow(3)
#SetActiveWindow(4)


def update_time_slider(newState):
	DefineScalarExpression("t", "0.0*coord(mesh)[2] + 1+ %f " % newState)
	DefineScalarExpression("vmri", "exp(growthrate*t)*scrh*sin(2*pi*z)")
	#DefineScalarExpression("vmri", "exp(growthrate*t)*scrh*sin(2*pi*z)")
	DefineScalarExpression("u", "3D_Velocity_Field[0]-vmri")
	DefineScalarExpression("v", "(3D_Velocity_Field[1]-vshear)")
	DefineScalarExpression("w", "3D_Velocity_Field[2]")
	DefineVectorExpression("velocity", "{u,v,w}")
	DefineVectorExpression("curlv", "curl(velocity)")
	DefineScalarExpression("curlvx", "curlv[0]")
	DefineScalarExpression("curlvy", "curlv[1]")
	DefineScalarExpression("curlvz", "curlv[2]")
	DefineVectorExpression("vel2d", "{u,0.0*v,w}")





for state in range(0,12):
#for state in range(TimeSliderGetNStates()):
	SetTimeSliderState(state)
	update_time_slider(state)
	DrawPlots()
	sw=SaveWindowAttributes()
	sw.saveTiled=1
	sw.progressive=1
	sw.format = sw.JPEG
	sw.family = 0
	sw.quality = 100
	sw.width = 2048
	sw.height = 2048
	sw.fileName = "vmri%03d" %(state)
	SetSaveWindowAttributes(sw)
	SaveWindow()
