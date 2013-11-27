
OpenDatabase("localhost:/Users/gmurphy/Documents/pluto4/PLUTO/KH/3d/data.*.vtk database", 100)
DefineScalarExpression("gmv1", "3D_Velocity_Field[0]")
DefineScalarExpression("gmv2", "3D_Velocity_Field[1]")
DefineScalarExpression("gmv3", "3D_Velocity_Field[2]")

DefineVectorExpression("cmfe0", "3D_Velocity_Field-pos_cmfe(<[0]i:3D_Velocity_Field>, mesh, 0.000000)")
DefineScalarExpression("gmcmfe0", "magnitude(cmfe0)")
DefineScalarExpression("cmfe1", "gmv1-pos_cmfe(<[0]i:gmv1>, mesh, 0.000000)")
DefineScalarExpression("cmfe2", "gmv2-pos_cmfe(<[0]i:gmv2>, mesh, 0.000000)")
DefineScalarExpression("cmfe3", "gmv3-pos_cmfe(<[0]i:gmv2>, mesh, 0.000000)")

AddPlot("Pseudocolor", "cmfe1", 1, 0)
AddOperator("Slice", 0)
SliceAtts = SliceAttributes()
SliceAtts.axisType = SliceAtts.ZAxis  # XAxis, YAxis, ZAxis, Arbitrary, ThetaPhi
SliceAtts.project2d = 0
SetOperatorOptions(SliceAtts, 0)

AddPlot("Pseudocolor", "cmfe2", 1, 0)
AddOperator("Slice", 0)
SliceAtts = SliceAttributes()
SliceAtts.axisType = SliceAtts.YAxis  # XAxis, YAxis, ZAxis, Arbitrary, ThetaPhi
SliceAtts.project2d = 0
SetOperatorOptions(SliceAtts, 0)

AddPlot("Pseudocolor", "cmfe3", 1, 0)
AddOperator("Slice", 0)
SliceAtts = SliceAttributes()
SliceAtts.axisType = SliceAtts.XAxis  # XAxis, YAxis, ZAxis, Arbitrary, ThetaPhi
SliceAtts.project2d = 0
SetOperatorOptions(SliceAtts, 0)


View3DAtts = View3DAttributes()
View3DAtts.viewNormal = (0.742137, 0.402375, 0.536029)
View3DAtts.focus = (0.00134993, 0, 0.00134993)
View3DAtts.viewUp = (-0.0575226, 0.835033, -0.547185)
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

AddPlot("Streamline", "cmfe0", 1, 0)

StreamlineAtts = StreamlineAttributes()
StreamlineAtts.sourceType = StreamlineAtts.SpecifiedSphere  # SpecifiedPoint, SpecifiedPointList, SpecifiedLine, SpecifiedCircle, SpecifiedPlane, SpecifiedSphere, SpecifiedBox, Selection
StreamlineAtts.pointSource = (0, 0, 0)
StreamlineAtts.lineStart = (-3, -3, -3)
StreamlineAtts.lineEnd = (3, 3, 3)
StreamlineAtts.planeOrigin = (0, 0, 0)
StreamlineAtts.planeNormal = (0, 0, 1)
StreamlineAtts.planeUpAxis = (0, 1, 0)
StreamlineAtts.radius = 3
StreamlineAtts.sphereOrigin = (0, 0, 0)
StreamlineAtts.boxExtents = (0, 1, 0, 1, 0, 1)
StreamlineAtts.useWholeBox = 1
StreamlineAtts.pointList = (0, 0, 0, 1, 0, 0, 0, 1, 0)
StreamlineAtts.sampleDensity0 = 21
StreamlineAtts.sampleDensity1 = 7
StreamlineAtts.sampleDensity2 = 3
StreamlineAtts.coloringMethod = StreamlineAtts.ColorByTime  # Solid, ColorBySpeed, ColorByVorticity, ColorByLength, ColorByTime, ColorBySeedPointID, ColorByVariable, ColorByCorrelationDistance
StreamlineAtts.colorTableName = "Default"
StreamlineAtts.singleColor = (0, 0, 0, 255)
StreamlineAtts.legendFlag = 1
StreamlineAtts.lightingFlag = 1
StreamlineAtts.streamlineDirection = StreamlineAtts.Both  # Forward, Backward, Both
StreamlineAtts.maxSteps = 1000
StreamlineAtts.terminateByDistance = 0
StreamlineAtts.termDistance = 10
StreamlineAtts.terminateByTime = 0
StreamlineAtts.termTime = 10
StreamlineAtts.maxStepLength = 0.1
StreamlineAtts.limitMaximumTimestep = 0
StreamlineAtts.maxTimeStep = 0.1
StreamlineAtts.relTol = 0.0001
StreamlineAtts.absTolSizeType = StreamlineAtts.FractionOfBBox  # Absolute, FractionOfBBox
StreamlineAtts.absTolAbsolute = 1e-06
StreamlineAtts.absTolBBox = 1e-06
StreamlineAtts.fieldType = StreamlineAtts.Default  # Default, M3DC12DField, M3DC13DField, NIMRODField, FlashField
StreamlineAtts.fieldConstant = 1
StreamlineAtts.velocitySource = (0, 0, 0)
StreamlineAtts.integrationType = StreamlineAtts.DormandPrince  # Euler, Leapfrog, DormandPrince, AdamsBashforth, RK4, M3DC12DIntegrator
StreamlineAtts.streamlineAlgorithmType = StreamlineAtts.VisItSelects  # LoadOnDemand, ParallelStaticDomains, MasterSlave, VisItSelects
StreamlineAtts.maxStreamlineProcessCount = 10
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
StreamlineAtts.sampleDistance0 = 10
StreamlineAtts.sampleDistance1 = 10
StreamlineAtts.sampleDistance2 = 10
StreamlineAtts.fillInterior = 1
StreamlineAtts.randomSamples = 0
StreamlineAtts.randomSeed = 0
StreamlineAtts.numberOfRandomSamples = 1
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


DrawPlots()
