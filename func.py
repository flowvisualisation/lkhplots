xsize=500
ysize=400
num=3
#SetWindowArea(400, 0, num*(xsize+100), num*ysize)

import math
#OpenDatabase("mri3d.vtk")
OpenDatabase("localhost:./data.*.vtk database", 0)

pi=math.pi
theta=-math.pi/4.0
sliceq1 = math.cos(theta)
sliceq2 = math.sin(theta)
DefineScalarExpression("pi", "3.141592")
DefineScalarExpression("theta", "pi/4.0")





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



n=0
theta=0.0
thetastr="0.0"
titlestr = "vx"
def func (theta,state, unused2):
	thetastr=str(theta)
	thetaanglestr=str(theta*180/math.pi)
	titlestr="Vorticity Projected (h,z) , angle="+thetaanglestr[0:6]+", t=$cycle orbits"
	text = CreateAnnotationObject("Text2D")
	text.visible = 1
	text.active = 1
	text.position = (0.2, 0.88)
	text.text=titlestr
	text.textColor = (0, 0, 0, 255)
	text.useForegroundForTextColor = 1
	text.fontFamily = text.Times  # Arial, Courier, Times
	text.fontBold = 0
	text.fontItalic = 0
	text.fontShadow = 0
	AnnotationAtts = AnnotationAttributes()
	AnnotationAtts.databaseInfoFlag = 0
	AnnotationAtts.userInfoFlag = 0
	SetAnnotationAttributes(AnnotationAtts)
	sliceq1 = math.sin(theta)
	sliceq2 = math.cos(theta)
	DefineScalarExpression("x", "coord(mesh)[0]")
	DefineScalarExpression("y", "coord(mesh)[1]")
	DefineScalarExpression("z", "coord(mesh)[2]")
	DefineScalarExpression("sbq", "1.5")
	DefineScalarExpression("sbomega", "1e-3")
	DefineScalarExpression("sba", "-0.5*sbq*sbomega")
	DefineScalarExpression("vsh", "2.0*sba")
	DefineScalarExpression("vshear", "vsh*x")
	DefineScalarExpression("amp", "5.444e-5*exp(0.75*state*sbomega)")
	amparr = [ ]
	for qq in range(30):
		amparr.append(0)
	amparr[9]=5.444e-5
	amparr[10]=0.0001138
	amparr[11]=0.0002354
	amparr[12]=0.0004782
	print "state", state
	ampdef=math.exp(.75*state)
	DefineScalarExpression("lx","2.0" )
	DefineScalarExpression("eps","1.0e-3" )
	DefineScalarExpression("scrh","lx*eps*sbomega/8.0" )
	DefineScalarExpression("amp",str(ampdef) )
	DefineScalarExpression("vmri", "amp*scrh*sin(2*pi*z)")
	# simulation variables
	DefineScalarExpression("ufull", "3D_Velocity_Field[0]")
	DefineScalarExpression("u", "3D_Velocity_Field[0]-vmri")
	DefineScalarExpression("v", "(3D_Velocity_Field[1]-vshear-vmri)")
	DefineScalarExpression("w", "3D_Velocity_Field[2]")
	DefineVectorExpression("velocity", "{u,v,w}")
	DefineScalarExpression("bx", "3D_Magnetic_Field[0]")
	DefineScalarExpression("by", "3D_Magnetic_Field[1])")
	DefineScalarExpression("bz", "3D_Magnetic_Field[2]")
	DefineVectorExpression("b", "3D_Magnetic_Field")
	# test variables
	#DefineScalarExpression("u", "-cos(pi*z)*sin(pi*x)")
	#DefineScalarExpression("v", "0*sin(pi*z)*cos(pi*x)")
	#DefineScalarExpression("w", "sin(pi*z)*cos(pi*x)")
	#DefineScalarExpression("v", "vshear")
	DefineScalarExpression("vel_mag", "magnitude(velocity)")
	DefineVectorExpression("curlv", "curl(velocity)")
	DefineScalarExpression("curlvx", "curlv[0]")
	DefineScalarExpression("curlvy", "curlv[1]")
	DefineScalarExpression("curlvz", "curlv[2]")
	DefineScalarExpression("phi", "pi/2.0")
	DefineScalarExpression("theta", thetastr)
	DefineScalarExpression("cos_theta", "cos(theta)*point_constant(mesh, 1.)")
	DefineScalarExpression("sin_theta", "sin(theta)*point_constant(mesh, 1.)")
	DefineScalarExpression("kz", "0*point_constant(mesh, 1.)")
	DefineVectorExpression("kh", "{cos_theta,sin_theta,kz}")
	DefineVectorExpression("kperp", "{-sin_theta,cos_theta,kz}")
	DefineScalarExpression("vortproj", "dot(curlv,kperp)")
	DefineScalarExpression("uhp", "dot(velocity,kh)")
	DefineScalarExpression("vhp", "dot(velocity,kperp)")
	DefineVectorExpression("velproj", "{uhp,vhp,w}")
	DefineScalarExpression("testvortproj", "curl(velproj)")
	#AddPlot("Pseudocolor", "vortproj", 1, 1)
	DeleteAllPlots()
	DeleteActivePlots()
	AddPlot("Pseudocolor", "curlvy", 1, 1)
	RemoveLastOperator()
	AddOperator("Slice", 0)
	SliceAtts = SliceAttributes()
	SliceAtts.originType = SliceAtts.Point  # Point, Intercept, Percent, Zone, Node
	SliceAtts.originPoint = (0.0, 0.0, 0.0)
	SliceAtts.originIntercept = 0
	SliceAtts.originPercent = 0
	SliceAtts.originZone = 0
	SliceAtts.originNode = 0
	SliceAtts.normal = (sliceq1,sliceq2 , 0)
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
	SetOperatorOptions(SliceAtts, 1)
	DrawPlots()
	ToggleLockViewMode()
	ToggleLockTime()
	v=0
	AddPlot("Vector", "velproj", 1, 1)
	VectorAtts = VectorAttributes()
	VectorAtts.glyphLocation = VectorAtts.AdaptsToMeshResolution  # AdaptsToMeshResolution, UniformInSpace
	VectorAtts.useStride = 0
	VectorAtts.stride = 1
	VectorAtts.nVectors = 600
	VectorAtts.lineStyle = VectorAtts.SOLID  # SOLID, DASH, DOT, DOTDASH
	VectorAtts.lineWidth = 0
	VectorAtts.scale = 0.25
	VectorAtts.scaleByMagnitude = 1
	VectorAtts.autoScale = 1
	VectorAtts.headSize = 0.25
	VectorAtts.headOn = 1
	VectorAtts.colorByMag = 0
	VectorAtts.useLegend = 1
	VectorAtts.vectorColor = (255, 255, 255, 255)
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
	VectorAtts.nVectors = 400
	SetPlotOptions(VectorAtts)
	DrawPlots()
	return v
	###


incdeg=-math.pi/16.0
unused1=0
unused2=0

SetWindowLayout(4)
SetActiveWindow(1)
theta=4*incdeg
state=0
func (theta,state, unused2)
SetActiveWindow(2)
AddPlot("Pseudocolor", "vmri" )
DrawPlots()
ToggleLockViewMode()
ToggleLockTime()
SetActiveWindow(3)
AddPlot("Pseudocolor", "ufull" )
DrawPlots()
ToggleLockViewMode()
ToggleLockTime()
SetActiveWindow(4)
AddPlot("Pseudocolor", "u" )
DrawPlots()
ToggleLockViewMode()
ToggleLockTime()

for state in range(1,20):
#for state in range(TimeSliderGetNStates()):
	SetTimeSliderState(state)
	DeleteAllPlots()
#	for ywin in range(0,3):
#		for xwin in range(0,3):
#			win=xwin+1+(num)*(ywin+0)
#			print win
#			MoveWindow(win,400+xwin*(xsize),ywin*ysize)
#			ResizeWindow(win, xsize, ysize)
	#AddOperator("Slice", 1)
	SetActiveWindow(1)
	theta=4*incdeg
	func (theta,state, unused2)
	showufull=1

		#SaveWindow()
	sw=SaveWindowAttributes()
	sw.saveTiled=1
	sw.progressive=1
	sw.family = 0
	sw.fileName = "vmri%03d" %(state)
	SetSaveWindowAttributes(sw)
	SaveWindow()

