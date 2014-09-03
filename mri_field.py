

import math
DeleteActivePlots()
OpenDatabase("localhost:./v*.vtk database", 4)
#SetWindowArea(800, 100 ,2200, 800)
DefineScalarExpression("x", "coord(mesh)[0]")
DefineScalarExpression("y", "coord(mesh)[1]")
DefineScalarExpression("z", "coord(mesh)[2]")
DefineScalarExpression("amp", "24.33")
DefineScalarExpression("pi", "3.141592741012573242187500")
#defn = "%f  *  conn_cmfe(volume(<[0]i:mesh_3d>), mesh_3d)" %(t1)
#DefineScalarExpression("vtmri", "0.25*exp(timestep()*0.75/10.)*sin(2*pi*z)")
DefineScalarExpression("vtmri", "exp(cycle()*0.075)*0.25*sin(2*pi*z)")
DefineScalarExpression("amp", "10.33")
DefineScalarExpression("vxmri", "amp*sin(2*pi*z)")
DefineScalarExpression("amp2", "10.6")
DefineScalarExpression("vymri", "amp2*sin(2*pi*z)")
DefineScalarExpression("bxamp", "33.86")
DefineScalarExpression("bxmri", "bxamp*cos(2*pi*z)")
DefineScalarExpression("byamp", "31.10")
DefineScalarExpression("bymri", "-byamp*cos(2*pi*z)")

DefineScalarExpression("dvx", "vx-vxmri")
DefineScalarExpression("dvy", "vy-vymri")
DefineScalarExpression("dbx", "bx-bxmri")
DefineScalarExpression("dby", "by-bymri")
DefineTensorExpression("tnesor", "{{vx*vx, vx*vy, vx*vz}, {vy*vx, vy*vy, vy*vz}, {vz*vx, vz*vy, vz*vz}}")
#DefineTensorExpression("reyanisten", "{{rey1, rey2, rey3}, {rey2, rey4, rey5}, {rey3, rey5, rey6}}")



DefineVectorExpression("vel", "{dvx,dvy,vz}")
DefineVectorExpression("vort", "curl(vel)")
DefineScalarExpression("vort1", "vort[0]")
DefineScalarExpression("vort2", "vort[1]")
DefineScalarExpression("vort3", "vort[2]")
DefineVectorExpression("magorig", "{bx,by,bz}")
DefineVectorExpression("mag", "{dbx,dby,bz}")
DefineVectorExpression("cur", "curl(mag)")
DefineScalarExpression("cur1", "cur[0]")
DefineScalarExpression("cur2", "cur[1]")
DefineScalarExpression("cur3", "cur[2]")

DefineScalarExpression("theta", "pi/4.0")
DefineScalarExpression("cos_theta", "cos(theta)*point_constant(mesh, 1.)")
DefineScalarExpression("sin_theta", "sin(theta)*point_constant(mesh, 1.)")
DefineScalarExpression("kz", "0*point_constant(mesh, 1.)")
DefineVectorExpression("kh", "{cos_theta,sin_theta,kz}")
DefineVectorExpression("kperp", "{-sin_theta,cos_theta,kz}")
DefineScalarExpression("vortproj", "dot(vort,kperp)")
DefineScalarExpression("uhp", "dot(vel,kh)")
DefineScalarExpression("vhp", "dot(vel,kperp)")
DefineVectorExpression("velproj", "{uhp,vhp,vz}")
DefineScalarExpression("testvortproj", "curl(velproj)")


DefineScalarExpression("curproj", "dot(cur,kh)")
DefineScalarExpression("cur1hp", "dot(cur,kh)")
DefineScalarExpression("cur1hp", "dot(cur,kperp)")




AddPlot("Pseudocolor", "vx", 1, 1)


AddOperator("Slice",1 )
SetActivePlots((0,1))
SliceAtts = SliceAttributes()
SliceAtts.originType = SliceAtts.Intercept  # Point, Intercept, Percent, Zone, Node
SliceAtts.originPoint = (0, 0, 0)
SliceAtts.originIntercept = 0.99
SliceAtts.originPercent = 0
SliceAtts.originZone = 0
SliceAtts.originNode = 0
SliceAtts.normal = (-1, 0, 0)
SliceAtts.axisType = SliceAtts.XAxis  # XAxis, YAxis, ZAxis, Arbitrary, ThetaPhi
SliceAtts.upAxis = (0, 1, 0)
SliceAtts.project2d = 0
SliceAtts.interactive = 1
SliceAtts.flip = 0
SliceAtts.originZoneDomain = 0
SliceAtts.originNodeDomain = 0
SliceAtts.meshName = "mesh"
SliceAtts.theta = 90
SliceAtts.phi = 0
SetOperatorOptions(SliceAtts, 1)


AddPlot("Streamline", "magorig", 1, 0)

StreamlineAtts = StreamlineAttributes()
StreamlineAtts.sourceType = StreamlineAtts.SpecifiedLine  # SpecifiedPoint, SpecifiedPointList, SpecifiedLine, SpecifiedCircle, SpecifiedPlane, SpecifiedSphere, SpecifiedBox, Selection
StreamlineAtts.pointSource = (0, 0, 0)
StreamlineAtts.lineStart = (-1, 1, 0.5)
StreamlineAtts.lineEnd = (1, -1, -0.5)
StreamlineAtts.planeOrigin = (0, 0, 0)
StreamlineAtts.planeNormal = (-1, 1, 0)
StreamlineAtts.planeUpAxis = (0, 1, 0)
StreamlineAtts.radius = 1
StreamlineAtts.sphereOrigin = (0, 0, 0)
StreamlineAtts.boxExtents = (0, 1, 0, 1, 0, 1)
StreamlineAtts.useWholeBox = 1
StreamlineAtts.pointList = (0, 0, 0, 1, 0, 0, 0, 1, 0)
StreamlineAtts.sampleDensity0 = 19
StreamlineAtts.sampleDensity1 = 2
StreamlineAtts.sampleDensity2 = 2
StreamlineAtts.coloringMethod = StreamlineAtts.Solid  # Solid, ColorBySpeed, ColorByVorticity, ColorByLength, ColorByTime, ColorBySeedPointID, ColorByVariable, ColorByCorrelationDistance
StreamlineAtts.colorTableName = "Default"
StreamlineAtts.singleColor = (0, 0, 0, 255)
StreamlineAtts.legendFlag = 1
StreamlineAtts.lightingFlag = 1
StreamlineAtts.integrationDirection = StreamlineAtts.Both  # Forward, Backward, Both
StreamlineAtts.maxSteps = 1000
StreamlineAtts.terminateByDistance = 0
StreamlineAtts.termDistance = 10
StreamlineAtts.terminateByTime = 0
StreamlineAtts.termTime = 10
StreamlineAtts.maxStepLength = 0.05
StreamlineAtts.limitMaximumTimestep = 0
StreamlineAtts.maxTimeStep = 0.1
StreamlineAtts.relTol = 0.0001
StreamlineAtts.absTolSizeType = StreamlineAtts.FractionOfBBox  # Absolute, FractionOfBBox
StreamlineAtts.absTolAbsolute = 1e-06
StreamlineAtts.absTolBBox = 1e-06
StreamlineAtts.fieldType = StreamlineAtts.Default  # Default, FlashField, M3DC12DField, M3DC13DField, Nek5000Field, NIMRODField
StreamlineAtts.fieldConstant = 1
StreamlineAtts.velocitySource = (0, 0, 0)
StreamlineAtts.integrationType = StreamlineAtts.RK4  # Euler, Leapfrog, DormandPrince, AdamsBashforth, RK4, M3DC12DIntegrator
StreamlineAtts.parallelizationAlgorithmType = StreamlineAtts.VisItSelects  # LoadOnDemand, ParallelStaticDomains, MasterSlave, VisItSelects
StreamlineAtts.maxProcessCount = 10
StreamlineAtts.maxDomainCacheSize = 3
StreamlineAtts.workGroupSize = 32
StreamlineAtts.pathlines = 0
StreamlineAtts.pathlinesOverrideStartingTimeFlag = 0
StreamlineAtts.pathlinesOverrideStartingTime = 0
StreamlineAtts.pathlinesCMFE = StreamlineAtts.POS_CMFE  # CONN_CMFE, POS_CMFE
StreamlineAtts.coordinateSystem = StreamlineAtts.AsIs  # AsIs, CylindricalToCartesian, CartesianToCylindrical
StreamlineAtts.phiScalingFlag = 0
StreamlineAtts.phiScaling = 1
StreamlineAtts.coloringVariable = ""
StreamlineAtts.legendMinFlag = 0
StreamlineAtts.legendMaxFlag = 0
StreamlineAtts.legendMin = 0
StreamlineAtts.legendMax = 1
StreamlineAtts.displayBegin = 0
StreamlineAtts.displayEnd = 1
StreamlineAtts.displayBeginFlag = 0
StreamlineAtts.displayEndFlag = 0
StreamlineAtts.referenceTypeForDisplay = StreamlineAtts.Distance  # Distance, Time, Step
StreamlineAtts.displayMethod = StreamlineAtts.Lines  # Lines, Tubes, Ribbons
StreamlineAtts.tubeSizeType = StreamlineAtts.FractionOfBBox  # Absolute, FractionOfBBox
StreamlineAtts.tubeRadiusAbsolute = 0.125
StreamlineAtts.tubeRadiusBBox = 0.005
StreamlineAtts.ribbonWidthSizeType = StreamlineAtts.FractionOfBBox  # Absolute, FractionOfBBox
StreamlineAtts.ribbonWidthAbsolute = 0.125
StreamlineAtts.ribbonWidthBBox = 0.01
StreamlineAtts.lineWidth = 2
StreamlineAtts.showSeeds = 0
StreamlineAtts.seedRadiusSizeType = StreamlineAtts.FractionOfBBox  # Absolute, FractionOfBBox
StreamlineAtts.seedRadiusAbsolute = 1
StreamlineAtts.seedRadiusBBox = 0.015
StreamlineAtts.showHeads = 0
StreamlineAtts.headDisplayType = StreamlineAtts.Sphere  # Sphere, Cone
StreamlineAtts.headRadiusSizeType = StreamlineAtts.FractionOfBBox  # Absolute, FractionOfBBox
StreamlineAtts.headRadiusAbsolute = 0.25
StreamlineAtts.headRadiusBBox = 0.02
StreamlineAtts.headHeightRatio = 2
StreamlineAtts.opacityType = StreamlineAtts.FullyOpaque  # FullyOpaque, Constant, Ramp, VariableRange
StreamlineAtts.opacityVariable = ""
StreamlineAtts.opacity = 1
StreamlineAtts.opacityVarMin = 0
StreamlineAtts.opacityVarMax = 1
StreamlineAtts.opacityVarMinFlag = 0
StreamlineAtts.opacityVarMaxFlag = 0
StreamlineAtts.tubeDisplayDensity = 10
StreamlineAtts.geomDisplayQuality = StreamlineAtts.Medium  # Low, Medium, High, Super
StreamlineAtts.sampleDistance0 = 1
StreamlineAtts.sampleDistance1 = 1
StreamlineAtts.sampleDistance2 = 10
StreamlineAtts.fillInterior = 1
StreamlineAtts.randomSamples = 0
StreamlineAtts.randomSeed = 0
StreamlineAtts.numberOfRandomSamples = 19
StreamlineAtts.forceNodeCenteredData = 0
StreamlineAtts.issueTerminationWarnings = 1
StreamlineAtts.issueStiffnessWarnings = 1
StreamlineAtts.issueCriticalPointsWarnings = 1
StreamlineAtts.criticalPointThreshold = 0.001
StreamlineAtts.varyTubeRadius = StreamlineAtts.None  # None, Scalar
StreamlineAtts.varyTubeRadiusFactor = 10
StreamlineAtts.varyTubeRadiusVariable = ""
StreamlineAtts.correlationDistanceAngTol = 5
StreamlineAtts.correlationDistanceMinDistAbsolute = 1
StreamlineAtts.correlationDistanceMinDistBBox = 0.005
StreamlineAtts.correlationDistanceMinDistType = StreamlineAtts.FractionOfBBox  # Absolute, FractionOfBBox
StreamlineAtts.selection = ""
SetPlotOptions(StreamlineAtts)


# Begin spontaneous state
View3DAtts = View3DAttributes()
View3DAtts.viewNormal = (-0.801957, -0.580306, 0.141)
View3DAtts.focus = (-0.00390625, -0.00390625, -0.00390625)
View3DAtts.viewUp = (0.209887, -0.0514604, 0.97637)
View3DAtts.viewAngle = 30
View3DAtts.parallelScale = 1.49349
View3DAtts.nearPlane = -2.98698
View3DAtts.farPlane = 2.98698
View3DAtts.imagePan = (0, 0)
View3DAtts.imageZoom = 1
View3DAtts.perspective = 1
View3DAtts.eyeAngle = 2
View3DAtts.centerOfRotationSet = 0
View3DAtts.centerOfRotation = (-0.00390625, -0.00390625, -0.00390625)
View3DAtts.axis3DScaleFlag = 0
View3DAtts.axis3DScales = (1, 1, 1)
View3DAtts.shear = (0, 0, 1)
SetView3D(View3DAtts)
# End spontaneous state


# Logging for SetAnnotationObjectOptions is not implemented yet.
AnnotationAtts = AnnotationAttributes()
AnnotationAtts.axes2D.visible = 0
AnnotationAtts.axes2D.autoSetTicks = 1
AnnotationAtts.axes2D.autoSetScaling = 1
AnnotationAtts.axes2D.lineWidth = 0
AnnotationAtts.axes2D.tickLocation = AnnotationAtts.axes2D.Outside  # Inside, Outside, Both
AnnotationAtts.axes2D.tickAxes = AnnotationAtts.axes2D.BottomLeft  # Off, Bottom, Left, BottomLeft, All
AnnotationAtts.axes2D.xAxis.title.visible = 1
AnnotationAtts.axes2D.xAxis.title.font.font = AnnotationAtts.axes2D.xAxis.title.font.Courier  # Arial, Courier, Times
AnnotationAtts.axes2D.xAxis.title.font.scale = 1
AnnotationAtts.axes2D.xAxis.title.font.useForegroundColor = 1
AnnotationAtts.axes2D.xAxis.title.font.color = (0, 0, 0, 255)
AnnotationAtts.axes2D.xAxis.title.font.bold = 1
AnnotationAtts.axes2D.xAxis.title.font.italic = 1
AnnotationAtts.axes2D.xAxis.title.userTitle = 0
AnnotationAtts.axes2D.xAxis.title.userUnits = 0
AnnotationAtts.axes2D.xAxis.title.title = "X-Axis"
AnnotationAtts.axes2D.xAxis.title.units = ""
AnnotationAtts.axes2D.xAxis.label.visible = 1
AnnotationAtts.axes2D.xAxis.label.font.font = AnnotationAtts.axes2D.xAxis.label.font.Courier  # Arial, Courier, Times
AnnotationAtts.axes2D.xAxis.label.font.scale = 1
AnnotationAtts.axes2D.xAxis.label.font.useForegroundColor = 1
AnnotationAtts.axes2D.xAxis.label.font.color = (0, 0, 0, 255)
AnnotationAtts.axes2D.xAxis.label.font.bold = 1
AnnotationAtts.axes2D.xAxis.label.font.italic = 1
AnnotationAtts.axes2D.xAxis.label.scaling = 0
AnnotationAtts.axes2D.xAxis.tickMarks.visible = 1
AnnotationAtts.axes2D.xAxis.tickMarks.majorMinimum = 0
AnnotationAtts.axes2D.xAxis.tickMarks.majorMaximum = 1
AnnotationAtts.axes2D.xAxis.tickMarks.minorSpacing = 0.02
AnnotationAtts.axes2D.xAxis.tickMarks.majorSpacing = 0.2
AnnotationAtts.axes2D.xAxis.grid = 0
AnnotationAtts.axes2D.yAxis.title.visible = 1
AnnotationAtts.axes2D.yAxis.title.font.font = AnnotationAtts.axes2D.yAxis.title.font.Courier  # Arial, Courier, Times
AnnotationAtts.axes2D.yAxis.title.font.scale = 1
AnnotationAtts.axes2D.yAxis.title.font.useForegroundColor = 1
AnnotationAtts.axes2D.yAxis.title.font.color = (0, 0, 0, 255)
AnnotationAtts.axes2D.yAxis.title.font.bold = 1
AnnotationAtts.axes2D.yAxis.title.font.italic = 1
AnnotationAtts.axes2D.yAxis.title.userTitle = 0
AnnotationAtts.axes2D.yAxis.title.userUnits = 0
AnnotationAtts.axes2D.yAxis.title.title = "Y-Axis"
AnnotationAtts.axes2D.yAxis.title.units = ""
AnnotationAtts.axes2D.yAxis.label.visible = 1
AnnotationAtts.axes2D.yAxis.label.font.font = AnnotationAtts.axes2D.yAxis.label.font.Courier  # Arial, Courier, Times
AnnotationAtts.axes2D.yAxis.label.font.scale = 1
AnnotationAtts.axes2D.yAxis.label.font.useForegroundColor = 1
AnnotationAtts.axes2D.yAxis.label.font.color = (0, 0, 0, 255)
AnnotationAtts.axes2D.yAxis.label.font.bold = 1
AnnotationAtts.axes2D.yAxis.label.font.italic = 1
AnnotationAtts.axes2D.yAxis.label.scaling = 0
AnnotationAtts.axes2D.yAxis.tickMarks.visible = 1
AnnotationAtts.axes2D.yAxis.tickMarks.majorMinimum = 0
AnnotationAtts.axes2D.yAxis.tickMarks.majorMaximum = 1
AnnotationAtts.axes2D.yAxis.tickMarks.minorSpacing = 0.02
AnnotationAtts.axes2D.yAxis.tickMarks.majorSpacing = 0.2
AnnotationAtts.axes2D.yAxis.grid = 0
AnnotationAtts.axes3D.visible = 0
AnnotationAtts.axes3D.autoSetTicks = 1
AnnotationAtts.axes3D.autoSetScaling = 1
AnnotationAtts.axes3D.lineWidth = 0
AnnotationAtts.axes3D.tickLocation = AnnotationAtts.axes3D.Inside  # Inside, Outside, Both
AnnotationAtts.axes3D.axesType = AnnotationAtts.axes3D.ClosestTriad  # ClosestTriad, FurthestTriad, OutsideEdges, StaticTriad, StaticEdges
AnnotationAtts.axes3D.triadFlag = 1
AnnotationAtts.axes3D.bboxFlag = 1
AnnotationAtts.axes3D.xAxis.title.visible = 1
AnnotationAtts.axes3D.xAxis.title.font.font = AnnotationAtts.axes3D.xAxis.title.font.Arial  # Arial, Courier, Times
AnnotationAtts.axes3D.xAxis.title.font.scale = 1
AnnotationAtts.axes3D.xAxis.title.font.useForegroundColor = 1
AnnotationAtts.axes3D.xAxis.title.font.color = (0, 0, 0, 255)
AnnotationAtts.axes3D.xAxis.title.font.bold = 0
AnnotationAtts.axes3D.xAxis.title.font.italic = 0
AnnotationAtts.axes3D.xAxis.title.userTitle = 0
AnnotationAtts.axes3D.xAxis.title.userUnits = 0
AnnotationAtts.axes3D.xAxis.title.title = "X-Axis"
AnnotationAtts.axes3D.xAxis.title.units = ""
AnnotationAtts.axes3D.xAxis.label.visible = 1
AnnotationAtts.axes3D.xAxis.label.font.font = AnnotationAtts.axes3D.xAxis.label.font.Arial  # Arial, Courier, Times
AnnotationAtts.axes3D.xAxis.label.font.scale = 1
AnnotationAtts.axes3D.xAxis.label.font.useForegroundColor = 1
AnnotationAtts.axes3D.xAxis.label.font.color = (0, 0, 0, 255)
AnnotationAtts.axes3D.xAxis.label.font.bold = 0
AnnotationAtts.axes3D.xAxis.label.font.italic = 0
AnnotationAtts.axes3D.xAxis.label.scaling = 0
AnnotationAtts.axes3D.xAxis.tickMarks.visible = 1
AnnotationAtts.axes3D.xAxis.tickMarks.majorMinimum = 0
AnnotationAtts.axes3D.xAxis.tickMarks.majorMaximum = 1
AnnotationAtts.axes3D.xAxis.tickMarks.minorSpacing = 0.02
AnnotationAtts.axes3D.xAxis.tickMarks.majorSpacing = 0.2
AnnotationAtts.axes3D.xAxis.grid = 0
AnnotationAtts.axes3D.yAxis.title.visible = 1
AnnotationAtts.axes3D.yAxis.title.font.font = AnnotationAtts.axes3D.yAxis.title.font.Arial  # Arial, Courier, Times
AnnotationAtts.axes3D.yAxis.title.font.scale = 1
AnnotationAtts.axes3D.yAxis.title.font.useForegroundColor = 1
AnnotationAtts.axes3D.yAxis.title.font.color = (0, 0, 0, 255)
AnnotationAtts.axes3D.yAxis.title.font.bold = 0
AnnotationAtts.axes3D.yAxis.title.font.italic = 0
AnnotationAtts.axes3D.yAxis.title.userTitle = 0
AnnotationAtts.axes3D.yAxis.title.userUnits = 0
AnnotationAtts.axes3D.yAxis.title.title = "Y-Axis"
AnnotationAtts.axes3D.yAxis.title.units = ""
AnnotationAtts.axes3D.yAxis.label.visible = 1
AnnotationAtts.axes3D.yAxis.label.font.font = AnnotationAtts.axes3D.yAxis.label.font.Arial  # Arial, Courier, Times
AnnotationAtts.axes3D.yAxis.label.font.scale = 1
AnnotationAtts.axes3D.yAxis.label.font.useForegroundColor = 1
AnnotationAtts.axes3D.yAxis.label.font.color = (0, 0, 0, 255)
AnnotationAtts.axes3D.yAxis.label.font.bold = 0
AnnotationAtts.axes3D.yAxis.label.font.italic = 0
AnnotationAtts.axes3D.yAxis.label.scaling = 0
AnnotationAtts.axes3D.yAxis.tickMarks.visible = 1
AnnotationAtts.axes3D.yAxis.tickMarks.majorMinimum = 0
AnnotationAtts.axes3D.yAxis.tickMarks.majorMaximum = 1
AnnotationAtts.axes3D.yAxis.tickMarks.minorSpacing = 0.02
AnnotationAtts.axes3D.yAxis.tickMarks.majorSpacing = 0.2
AnnotationAtts.axes3D.yAxis.grid = 0
AnnotationAtts.axes3D.zAxis.title.visible = 1
AnnotationAtts.axes3D.zAxis.title.font.font = AnnotationAtts.axes3D.zAxis.title.font.Arial  # Arial, Courier, Times
AnnotationAtts.axes3D.zAxis.title.font.scale = 1
AnnotationAtts.axes3D.zAxis.title.font.useForegroundColor = 1
AnnotationAtts.axes3D.zAxis.title.font.color = (0, 0, 0, 255)
AnnotationAtts.axes3D.zAxis.title.font.bold = 0
AnnotationAtts.axes3D.zAxis.title.font.italic = 0
AnnotationAtts.axes3D.zAxis.title.userTitle = 0
AnnotationAtts.axes3D.zAxis.title.userUnits = 0
AnnotationAtts.axes3D.zAxis.title.title = "Z-Axis"
AnnotationAtts.axes3D.zAxis.title.units = ""
AnnotationAtts.axes3D.zAxis.label.visible = 1
AnnotationAtts.axes3D.zAxis.label.font.font = AnnotationAtts.axes3D.zAxis.label.font.Arial  # Arial, Courier, Times
AnnotationAtts.axes3D.zAxis.label.font.scale = 1
AnnotationAtts.axes3D.zAxis.label.font.useForegroundColor = 1
AnnotationAtts.axes3D.zAxis.label.font.color = (0, 0, 0, 255)
AnnotationAtts.axes3D.zAxis.label.font.bold = 0
AnnotationAtts.axes3D.zAxis.label.font.italic = 0
AnnotationAtts.axes3D.zAxis.label.scaling = 0
AnnotationAtts.axes3D.zAxis.tickMarks.visible = 1
AnnotationAtts.axes3D.zAxis.tickMarks.majorMinimum = 0
AnnotationAtts.axes3D.zAxis.tickMarks.majorMaximum = 1
AnnotationAtts.axes3D.zAxis.tickMarks.minorSpacing = 0.02
AnnotationAtts.axes3D.zAxis.tickMarks.majorSpacing = 0.2
AnnotationAtts.axes3D.zAxis.grid = 0
AnnotationAtts.axes3D.setBBoxLocation = 0
AnnotationAtts.axes3D.bboxLocation = (0, 1, 0, 1, 0, 1)
AnnotationAtts.userInfoFlag = 0
AnnotationAtts.userInfoFont.font = AnnotationAtts.userInfoFont.Arial  # Arial, Courier, Times
AnnotationAtts.userInfoFont.scale = 1
AnnotationAtts.userInfoFont.useForegroundColor = 1
AnnotationAtts.userInfoFont.color = (0, 0, 0, 255)
AnnotationAtts.userInfoFont.bold = 0
AnnotationAtts.userInfoFont.italic = 0
AnnotationAtts.databaseInfoFlag = 0
AnnotationAtts.timeInfoFlag = 1
AnnotationAtts.databaseInfoFont.font = AnnotationAtts.databaseInfoFont.Arial  # Arial, Courier, Times
AnnotationAtts.databaseInfoFont.scale = 1
AnnotationAtts.databaseInfoFont.useForegroundColor = 1
AnnotationAtts.databaseInfoFont.color = (0, 0, 0, 255)
AnnotationAtts.databaseInfoFont.bold = 0
AnnotationAtts.databaseInfoFont.italic = 0
AnnotationAtts.databaseInfoExpansionMode = AnnotationAtts.File  # File, Directory, Full, Smart, SmartDirectory
AnnotationAtts.databaseInfoTimeScale = 1
AnnotationAtts.databaseInfoTimeOffset = 0
AnnotationAtts.legendInfoFlag = 0
AnnotationAtts.backgroundColor = (255, 255, 255, 255)
AnnotationAtts.foregroundColor = (0, 0, 0, 255)
AnnotationAtts.gradientBackgroundStyle = AnnotationAtts.Radial  # TopToBottom, BottomToTop, LeftToRight, RightToLeft, Radial
AnnotationAtts.gradientColor1 = (0, 0, 255, 255)
AnnotationAtts.gradientColor2 = (0, 0, 0, 255)
AnnotationAtts.backgroundMode = AnnotationAtts.Solid  # Solid, Gradient, Image, ImageSphere
AnnotationAtts.backgroundImage = ""
AnnotationAtts.imageRepeatX = 1
AnnotationAtts.imageRepeatY = 1
AnnotationAtts.axesArray.visible = 1
AnnotationAtts.axesArray.ticksVisible = 1
AnnotationAtts.axesArray.autoSetTicks = 1
AnnotationAtts.axesArray.autoSetScaling = 1
AnnotationAtts.axesArray.lineWidth = 0
AnnotationAtts.axesArray.axes.title.visible = 1
AnnotationAtts.axesArray.axes.title.font.font = AnnotationAtts.axesArray.axes.title.font.Arial  # Arial, Courier, Times
AnnotationAtts.axesArray.axes.title.font.scale = 1
AnnotationAtts.axesArray.axes.title.font.useForegroundColor = 1
AnnotationAtts.axesArray.axes.title.font.color = (0, 0, 0, 255)
AnnotationAtts.axesArray.axes.title.font.bold = 0
AnnotationAtts.axesArray.axes.title.font.italic = 0
AnnotationAtts.axesArray.axes.title.userTitle = 0
AnnotationAtts.axesArray.axes.title.userUnits = 0
AnnotationAtts.axesArray.axes.title.title = ""
AnnotationAtts.axesArray.axes.title.units = ""
AnnotationAtts.axesArray.axes.label.visible = 1
AnnotationAtts.axesArray.axes.label.font.font = AnnotationAtts.axesArray.axes.label.font.Arial  # Arial, Courier, Times
AnnotationAtts.axesArray.axes.label.font.scale = 1
AnnotationAtts.axesArray.axes.label.font.useForegroundColor = 1
AnnotationAtts.axesArray.axes.label.font.color = (0, 0, 0, 255)
AnnotationAtts.axesArray.axes.label.font.bold = 0
AnnotationAtts.axesArray.axes.label.font.italic = 0
AnnotationAtts.axesArray.axes.label.scaling = 0
AnnotationAtts.axesArray.axes.tickMarks.visible = 1
AnnotationAtts.axesArray.axes.tickMarks.majorMinimum = 0
AnnotationAtts.axesArray.axes.tickMarks.majorMaximum = 1
AnnotationAtts.axesArray.axes.tickMarks.minorSpacing = 0.02
AnnotationAtts.axesArray.axes.tickMarks.majorSpacing = 0.2
AnnotationAtts.axesArray.axes.grid = 0
SetAnnotationAttributes(AnnotationAtts)

# Begin spontaneous state
View3DAtts = View3DAttributes()
View3DAtts.viewNormal = (0.571916, -0.805417, 0.155614)
View3DAtts.focus = (-0.00390625, -0.00390625, -0.00390625)
View3DAtts.viewUp = (-0.0345551, 0.165878, 0.985541)
View3DAtts.viewAngle = 30
View3DAtts.parallelScale = 1.49349
View3DAtts.nearPlane = -2.98698
View3DAtts.farPlane = 2.98698
View3DAtts.imagePan = (0, 0)
View3DAtts.imageZoom = 1
View3DAtts.perspective = 1
View3DAtts.eyeAngle = 2
View3DAtts.centerOfRotationSet = 0
View3DAtts.centerOfRotation = (-0.00390625, -0.00390625, -0.00390625)
View3DAtts.axis3DScaleFlag = 0
View3DAtts.axis3DScales = (1, 1, 1)
View3DAtts.shear = (0, 0, 1)
SetView3D(View3DAtts)
# End spontaneous state
View3DAtts = View3DAttributes()
View3DAtts.viewNormal = (-0.801957, -0.580306, 0.141)
View3DAtts.focus = (-0.00390625, -0.00390625, -0.00390625)
View3DAtts.viewUp = (0.209887, -0.0514604, 0.97637)
View3DAtts.viewAngle = 30
View3DAtts.parallelScale = 1.49349
View3DAtts.nearPlane = -2.98698
View3DAtts.farPlane = 2.98698
View3DAtts.imagePan = (0, 0)
View3DAtts.imageZoom = 1
View3DAtts.perspective = 1
View3DAtts.eyeAngle = 2
View3DAtts.centerOfRotationSet = 0
View3DAtts.centerOfRotation = (-0.00390625, -0.00390625, -0.00390625)
View3DAtts.axis3DScaleFlag = 0
View3DAtts.axis3DScales = (1, 1, 1)
View3DAtts.shear = (0, 0, 1)
SetView3D(View3DAtts)
ViewAxisArrayAtts = ViewAxisArrayAttributes()
ViewAxisArrayAtts.domainCoords = (0, 1)
ViewAxisArrayAtts.rangeCoords = (0, 1)
ViewAxisArrayAtts.viewportCoords = (0.15, 0.9, 0.1, 0.85)
SetViewAxisArray(ViewAxisArrayAtts)


DrawPlots()
