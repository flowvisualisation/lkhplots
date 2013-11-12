
SetActivePlots((0, 1))
SetActivePlots((0, 1))
SetActivePlots(1)
SliceAtts = SliceAttributes()
SliceAtts.originType = SliceAtts.Intercept  # Point, Intercept, Percent, Zone, Node
SliceAtts.originPoint = (0, 0, 0)
SliceAtts.originIntercept = 0
SliceAtts.originPercent = 0
SliceAtts.originZone = 0
SliceAtts.originNode = 0
SliceAtts.normal = (0, -1, 0)
SliceAtts.axisType = SliceAtts.YAxis  # XAxis, YAxis, ZAxis, Arbitrary, ThetaPhi
SliceAtts.upAxis = (0, 0, 1)
SliceAtts.project2d = 0
SliceAtts.interactive = 1
SliceAtts.flip = 0
SliceAtts.originZoneDomain = 0
SliceAtts.originNodeDomain = 0
SliceAtts.meshName = "mesh"
SliceAtts.theta = 0
SliceAtts.phi = 0
SetOperatorOptions(SliceAtts, 0)
DrawPlots()
SliceAtts = SliceAttributes()
SliceAtts.originType = SliceAtts.Intercept  # Point, Intercept, Percent, Zone, Node
SliceAtts.originPoint = (0, 0, 0)
SliceAtts.originIntercept = 0
SliceAtts.originPercent = 0
SliceAtts.originZone = 0
SliceAtts.originNode = 0
SliceAtts.normal = (0, 0, 1)
SliceAtts.axisType = SliceAtts.ZAxis  # XAxis, YAxis, ZAxis, Arbitrary, ThetaPhi
SliceAtts.upAxis = (0, 1, 0)
SliceAtts.project2d = 0
SliceAtts.interactive = 1
SliceAtts.flip = 0
SliceAtts.originZoneDomain = 0
SliceAtts.originNodeDomain = 0
SliceAtts.meshName = "mesh"
SliceAtts.theta = 0
SliceAtts.phi = 90
SetOperatorOptions(SliceAtts, 0)
AddOperator("Transform", 0)
TransformAtts = TransformAttributes()
TransformAtts.doRotate = 0
TransformAtts.rotateOrigin = (0, 0, 0)
TransformAtts.rotateAxis = (0, 0, 1)
TransformAtts.rotateAmount = 0
TransformAtts.rotateType = TransformAtts.Deg  # Deg, Rad
TransformAtts.doScale = 0
TransformAtts.scaleOrigin = (0, 0, 0)
TransformAtts.scaleX = 1
TransformAtts.scaleY = 1
TransformAtts.scaleZ = 1
TransformAtts.doTranslate = 1
TransformAtts.translateX = 0
TransformAtts.translateY = 0
TransformAtts.translateZ = -3
TransformAtts.transformType = TransformAtts.Similarity  # Similarity, Coordinate, Linear
TransformAtts.inputCoordSys = TransformAtts.Cartesian  # Cartesian, Cylindrical, Spherical
TransformAtts.outputCoordSys = TransformAtts.Spherical  # Cartesian, Cylindrical, Spherical
TransformAtts.m00 = 1
TransformAtts.m01 = 0
TransformAtts.m02 = 0
TransformAtts.m03 = 0
TransformAtts.m10 = 0
TransformAtts.m11 = 1
TransformAtts.m12 = 0
TransformAtts.m13 = 0
TransformAtts.m20 = 0
TransformAtts.m21 = 0
TransformAtts.m22 = 1
TransformAtts.m23 = 0
TransformAtts.m30 = 0
TransformAtts.m31 = 0
TransformAtts.m32 = 0
TransformAtts.m33 = 1
TransformAtts.invertLinearTransform = 0
TransformAtts.vectorTransformMethod = TransformAtts.AsDirection  # None, AsPoint, AsDisplacement, AsDirection
TransformAtts.transformVectors = 1
SetOperatorOptions(TransformAtts, 0)
# Begin spontaneous state
View3DAtts = View3DAttributes()
View3DAtts.viewNormal = (0.370021, 0.464365, 0.804643)
View3DAtts.focus = (0.00134993, 0, 0.00134993)
View3DAtts.viewUp = (-0.146301, 0.884436, -0.443136)
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

DrawPlots()
TransformAtts = TransformAttributes()
TransformAtts.doRotate = 0
TransformAtts.rotateOrigin = (0, 0, 0)
TransformAtts.rotateAxis = (0, 0, 1)
TransformAtts.rotateAmount = 0
TransformAtts.rotateType = TransformAtts.Deg  # Deg, Rad
TransformAtts.doScale = 0
TransformAtts.scaleOrigin = (0, 0, 0)
TransformAtts.scaleX = 1
TransformAtts.scaleY = 1
TransformAtts.scaleZ = 1
TransformAtts.doTranslate = 1
TransformAtts.translateX = 0
TransformAtts.translateY = 0
TransformAtts.translateZ = -6
TransformAtts.transformType = TransformAtts.Similarity  # Similarity, Coordinate, Linear
TransformAtts.inputCoordSys = TransformAtts.Cartesian  # Cartesian, Cylindrical, Spherical
TransformAtts.outputCoordSys = TransformAtts.Spherical  # Cartesian, Cylindrical, Spherical
TransformAtts.m00 = 1
TransformAtts.m01 = 0
TransformAtts.m02 = 0
TransformAtts.m03 = 0
TransformAtts.m10 = 0
TransformAtts.m11 = 1
TransformAtts.m12 = 0
TransformAtts.m13 = 0
TransformAtts.m20 = 0
TransformAtts.m21 = 0
TransformAtts.m22 = 1
TransformAtts.m23 = 0
TransformAtts.m30 = 0
TransformAtts.m31 = 0
TransformAtts.m32 = 0
TransformAtts.m33 = 1
TransformAtts.invertLinearTransform = 0
TransformAtts.vectorTransformMethod = TransformAtts.AsDirection  # None, AsPoint, AsDisplacement, AsDirection
TransformAtts.transformVectors = 1
SetOperatorOptions(TransformAtts, 0)
TransformAtts = TransformAttributes()
TransformAtts.doRotate = 0
TransformAtts.rotateOrigin = (0, 0, 0)
TransformAtts.rotateAxis = (0, 0, 1)
TransformAtts.rotateAmount = 0
TransformAtts.rotateType = TransformAtts.Deg  # Deg, Rad
TransformAtts.doScale = 0
TransformAtts.scaleOrigin = (0, 0, 0)
TransformAtts.scaleX = 1
TransformAtts.scaleY = 1
TransformAtts.scaleZ = 1
TransformAtts.doTranslate = 1
TransformAtts.translateX = 0
TransformAtts.translateY = 0
TransformAtts.translateZ = -10
TransformAtts.transformType = TransformAtts.Similarity  # Similarity, Coordinate, Linear
TransformAtts.inputCoordSys = TransformAtts.Cartesian  # Cartesian, Cylindrical, Spherical
TransformAtts.outputCoordSys = TransformAtts.Spherical  # Cartesian, Cylindrical, Spherical
TransformAtts.m00 = 1
TransformAtts.m01 = 0
TransformAtts.m02 = 0
TransformAtts.m03 = 0
TransformAtts.m10 = 0
TransformAtts.m11 = 1
TransformAtts.m12 = 0
TransformAtts.m13 = 0
TransformAtts.m20 = 0
TransformAtts.m21 = 0
TransformAtts.m22 = 1
TransformAtts.m23 = 0
TransformAtts.m30 = 0
TransformAtts.m31 = 0
TransformAtts.m32 = 0
TransformAtts.m33 = 1
TransformAtts.invertLinearTransform = 0
TransformAtts.vectorTransformMethod = TransformAtts.AsDirection  # None, AsPoint, AsDisplacement, AsDirection
TransformAtts.transformVectors = 1
SetOperatorOptions(TransformAtts, 0)
SetTimeSliderState(89)
SetTimeSliderState(102)
SetActivePlots(1)
SetActivePlots(1)
# Begin spontaneous state
View3DAtts = View3DAttributes()
View3DAtts.viewNormal = (0.370021, 0.464365, 0.804643)
View3DAtts.focus = (0.00134993, 0, -4.99865)
View3DAtts.viewUp = (-0.146301, 0.884436, -0.443136)
View3DAtts.viewAngle = 30
View3DAtts.parallelScale = 12.036
View3DAtts.nearPlane = -24.0719
View3DAtts.farPlane = 24.0719
View3DAtts.imagePan = (0, 0)
View3DAtts.imageZoom = 1
View3DAtts.perspective = 1
View3DAtts.eyeAngle = 2
View3DAtts.centerOfRotationSet = 0
View3DAtts.centerOfRotation = (0.00134993, 0, -4.99865)
View3DAtts.axis3DScaleFlag = 0
View3DAtts.axis3DScales = (1, 1, 1)
View3DAtts.shear = (0, 0, 1)
SetView3D(View3DAtts)
# End spontaneous state

TransformAtts = TransformAttributes()
TransformAtts.doRotate = 0
TransformAtts.rotateOrigin = (0, 0, 0)
TransformAtts.rotateAxis = (0, 0, 1)
TransformAtts.rotateAmount = 0
TransformAtts.rotateType = TransformAtts.Deg  # Deg, Rad
TransformAtts.doScale = 0
TransformAtts.scaleOrigin = (0, 0, 0)
TransformAtts.scaleX = 1
TransformAtts.scaleY = 1
TransformAtts.scaleZ = 1
TransformAtts.doTranslate = 1
TransformAtts.translateX = 0
TransformAtts.translateY = 0
TransformAtts.translateZ = -15
TransformAtts.transformType = TransformAtts.Similarity  # Similarity, Coordinate, Linear
TransformAtts.inputCoordSys = TransformAtts.Cartesian  # Cartesian, Cylindrical, Spherical
TransformAtts.outputCoordSys = TransformAtts.Spherical  # Cartesian, Cylindrical, Spherical
TransformAtts.m00 = 1
TransformAtts.m01 = 0
TransformAtts.m02 = 0
TransformAtts.m03 = 0
TransformAtts.m10 = 0
TransformAtts.m11 = 1
TransformAtts.m12 = 0
TransformAtts.m13 = 0
TransformAtts.m20 = 0
TransformAtts.m21 = 0
TransformAtts.m22 = 1
TransformAtts.m23 = 0
TransformAtts.m30 = 0
TransformAtts.m31 = 0
TransformAtts.m32 = 0
TransformAtts.m33 = 1
TransformAtts.invertLinearTransform = 0
TransformAtts.vectorTransformMethod = TransformAtts.AsDirection  # None, AsPoint, AsDisplacement, AsDirection
TransformAtts.transformVectors = 1
SetOperatorOptions(TransformAtts, 0)
ContourAtts = ContourAttributes()
ContourAtts.defaultPalette.GetControlPoints(0).colors = (255, 0, 0, 255)
ContourAtts.defaultPalette.GetControlPoints(0).position = 0
ContourAtts.defaultPalette.GetControlPoints(1).colors = (0, 255, 0, 255)
ContourAtts.defaultPalette.GetControlPoints(1).position = 0.034
ContourAtts.defaultPalette.GetControlPoints(2).colors = (0, 0, 255, 255)
ContourAtts.defaultPalette.GetControlPoints(2).position = 0.069
ContourAtts.defaultPalette.GetControlPoints(3).colors = (0, 255, 255, 255)
ContourAtts.defaultPalette.GetControlPoints(3).position = 0.103
ContourAtts.defaultPalette.GetControlPoints(4).colors = (255, 0, 255, 255)
ContourAtts.defaultPalette.GetControlPoints(4).position = 0.138
ContourAtts.defaultPalette.GetControlPoints(5).colors = (255, 255, 0, 255)
ContourAtts.defaultPalette.GetControlPoints(5).position = 0.172
ContourAtts.defaultPalette.GetControlPoints(6).colors = (255, 135, 0, 255)
ContourAtts.defaultPalette.GetControlPoints(6).position = 0.207
ContourAtts.defaultPalette.GetControlPoints(7).colors = (255, 0, 135, 255)
ContourAtts.defaultPalette.GetControlPoints(7).position = 0.241
ContourAtts.defaultPalette.GetControlPoints(8).colors = (168, 168, 168, 255)
ContourAtts.defaultPalette.GetControlPoints(8).position = 0.276
ContourAtts.defaultPalette.GetControlPoints(9).colors = (255, 68, 68, 255)
ContourAtts.defaultPalette.GetControlPoints(9).position = 0.31
ContourAtts.defaultPalette.GetControlPoints(10).colors = (99, 255, 99, 255)
ContourAtts.defaultPalette.GetControlPoints(10).position = 0.345
ContourAtts.defaultPalette.GetControlPoints(11).colors = (99, 99, 255, 255)
ContourAtts.defaultPalette.GetControlPoints(11).position = 0.379
ContourAtts.defaultPalette.GetControlPoints(12).colors = (40, 165, 165, 255)
ContourAtts.defaultPalette.GetControlPoints(12).position = 0.414
ContourAtts.defaultPalette.GetControlPoints(13).colors = (255, 99, 255, 255)
ContourAtts.defaultPalette.GetControlPoints(13).position = 0.448
ContourAtts.defaultPalette.GetControlPoints(14).colors = (255, 255, 99, 255)
ContourAtts.defaultPalette.GetControlPoints(14).position = 0.483
ContourAtts.defaultPalette.GetControlPoints(15).colors = (255, 170, 99, 255)
ContourAtts.defaultPalette.GetControlPoints(15).position = 0.517
ContourAtts.defaultPalette.GetControlPoints(16).colors = (170, 79, 255, 255)
ContourAtts.defaultPalette.GetControlPoints(16).position = 0.552
ContourAtts.defaultPalette.GetControlPoints(17).colors = (150, 0, 0, 255)
ContourAtts.defaultPalette.GetControlPoints(17).position = 0.586
ContourAtts.defaultPalette.GetControlPoints(18).colors = (0, 150, 0, 255)
ContourAtts.defaultPalette.GetControlPoints(18).position = 0.621
ContourAtts.defaultPalette.GetControlPoints(19).colors = (0, 0, 150, 255)
ContourAtts.defaultPalette.GetControlPoints(19).position = 0.655
ContourAtts.defaultPalette.GetControlPoints(20).colors = (0, 109, 109, 255)
ContourAtts.defaultPalette.GetControlPoints(20).position = 0.69
ContourAtts.defaultPalette.GetControlPoints(21).colors = (150, 0, 150, 255)
ContourAtts.defaultPalette.GetControlPoints(21).position = 0.724
ContourAtts.defaultPalette.GetControlPoints(22).colors = (150, 150, 0, 255)
ContourAtts.defaultPalette.GetControlPoints(22).position = 0.759
ContourAtts.defaultPalette.GetControlPoints(23).colors = (150, 84, 0, 255)
ContourAtts.defaultPalette.GetControlPoints(23).position = 0.793
ContourAtts.defaultPalette.GetControlPoints(24).colors = (160, 0, 79, 255)
ContourAtts.defaultPalette.GetControlPoints(24).position = 0.828
ContourAtts.defaultPalette.GetControlPoints(25).colors = (255, 104, 28, 255)
ContourAtts.defaultPalette.GetControlPoints(25).position = 0.862
ContourAtts.defaultPalette.GetControlPoints(26).colors = (0, 170, 81, 255)
ContourAtts.defaultPalette.GetControlPoints(26).position = 0.897
ContourAtts.defaultPalette.GetControlPoints(27).colors = (68, 255, 124, 255)
ContourAtts.defaultPalette.GetControlPoints(27).position = 0.931
ContourAtts.defaultPalette.GetControlPoints(28).colors = (0, 130, 255, 255)
ContourAtts.defaultPalette.GetControlPoints(28).position = 0.966
ContourAtts.defaultPalette.GetControlPoints(29).colors = (130, 0, 255, 255)
ContourAtts.defaultPalette.GetControlPoints(29).position = 1
ContourAtts.defaultPalette.smoothing = ContourAtts.defaultPalette.None  # None, Linear, CubicSpline
ContourAtts.defaultPalette.equalSpacingFlag = 1
ContourAtts.defaultPalette.discreteFlag = 1
ContourAtts.defaultPalette.externalFlag = 0
ContourAtts.changedColors = (1, 2, 0, 3)
ContourAtts.colorType = ContourAtts.ColorByMultipleColors  # ColorBySingleColor, ColorByMultipleColors, ColorByColorTable
ContourAtts.colorTableName = "contoured"
ContourAtts.invertColorTable = 0
ContourAtts.legendFlag = 1
ContourAtts.lineStyle = ContourAtts.SOLID  # SOLID, DASH, DOT, DOTDASH
ContourAtts.lineWidth = 0
ContourAtts.singleColor = (255, 0, 0, 255)
ContourAtts.SetMultiColor(0, (51, 102, 255, 255))
ContourAtts.SetMultiColor(1, (0, 255, 0, 87))
ContourAtts.SetMultiColor(2, (0, 0, 255, 79))
ContourAtts.SetMultiColor(3, (255, 0, 0, 255))
ContourAtts.SetMultiColor(4, (255, 0, 255, 255))
ContourAtts.SetMultiColor(5, (255, 255, 0, 255))
ContourAtts.SetMultiColor(6, (255, 135, 0, 255))
ContourAtts.SetMultiColor(7, (255, 0, 135, 255))
ContourAtts.SetMultiColor(8, (168, 168, 168, 255))
ContourAtts.SetMultiColor(9, (255, 68, 68, 255))
ContourAtts.contourNLevels = 4
ContourAtts.contourValue = ()
ContourAtts.contourPercent = ()
ContourAtts.contourMethod = ContourAtts.Level  # Level, Value, Percent
ContourAtts.minFlag = 0
ContourAtts.maxFlag = 0
ContourAtts.min = 0
ContourAtts.max = 1
ContourAtts.scaling = ContourAtts.Linear  # Linear, Log
ContourAtts.wireframe = 0
SetPlotOptions(ContourAtts)
# MAINTENANCE ISSUE: SetSuppressMessagesRPC is not handled in Logging.C. Please contact a VisIt developer.
SaveSession("/Users/gmurphy/.visit/crash_recovery.session")
# MAINTENANCE ISSUE: SetSuppressMessagesRPC is not handled in Logging.C. Please contact a VisIt developer.
ContourAtts = ContourAttributes()
ContourAtts.defaultPalette.GetControlPoints(0).colors = (255, 0, 0, 255)
ContourAtts.defaultPalette.GetControlPoints(0).position = 0
ContourAtts.defaultPalette.GetControlPoints(1).colors = (0, 255, 0, 255)
ContourAtts.defaultPalette.GetControlPoints(1).position = 0.034
ContourAtts.defaultPalette.GetControlPoints(2).colors = (0, 0, 255, 255)
ContourAtts.defaultPalette.GetControlPoints(2).position = 0.069
ContourAtts.defaultPalette.GetControlPoints(3).colors = (0, 255, 255, 255)
ContourAtts.defaultPalette.GetControlPoints(3).position = 0.103
ContourAtts.defaultPalette.GetControlPoints(4).colors = (255, 0, 255, 255)
ContourAtts.defaultPalette.GetControlPoints(4).position = 0.138
ContourAtts.defaultPalette.GetControlPoints(5).colors = (255, 255, 0, 255)
ContourAtts.defaultPalette.GetControlPoints(5).position = 0.172
ContourAtts.defaultPalette.GetControlPoints(6).colors = (255, 135, 0, 255)
ContourAtts.defaultPalette.GetControlPoints(6).position = 0.207
ContourAtts.defaultPalette.GetControlPoints(7).colors = (255, 0, 135, 255)
ContourAtts.defaultPalette.GetControlPoints(7).position = 0.241
ContourAtts.defaultPalette.GetControlPoints(8).colors = (168, 168, 168, 255)
ContourAtts.defaultPalette.GetControlPoints(8).position = 0.276
ContourAtts.defaultPalette.GetControlPoints(9).colors = (255, 68, 68, 255)
ContourAtts.defaultPalette.GetControlPoints(9).position = 0.31
ContourAtts.defaultPalette.GetControlPoints(10).colors = (99, 255, 99, 255)
ContourAtts.defaultPalette.GetControlPoints(10).position = 0.345
ContourAtts.defaultPalette.GetControlPoints(11).colors = (99, 99, 255, 255)
ContourAtts.defaultPalette.GetControlPoints(11).position = 0.379
ContourAtts.defaultPalette.GetControlPoints(12).colors = (40, 165, 165, 255)
ContourAtts.defaultPalette.GetControlPoints(12).position = 0.414
ContourAtts.defaultPalette.GetControlPoints(13).colors = (255, 99, 255, 255)
ContourAtts.defaultPalette.GetControlPoints(13).position = 0.448
ContourAtts.defaultPalette.GetControlPoints(14).colors = (255, 255, 99, 255)
ContourAtts.defaultPalette.GetControlPoints(14).position = 0.483
ContourAtts.defaultPalette.GetControlPoints(15).colors = (255, 170, 99, 255)
ContourAtts.defaultPalette.GetControlPoints(15).position = 0.517
ContourAtts.defaultPalette.GetControlPoints(16).colors = (170, 79, 255, 255)
ContourAtts.defaultPalette.GetControlPoints(16).position = 0.552
ContourAtts.defaultPalette.GetControlPoints(17).colors = (150, 0, 0, 255)
ContourAtts.defaultPalette.GetControlPoints(17).position = 0.586
ContourAtts.defaultPalette.GetControlPoints(18).colors = (0, 150, 0, 255)
ContourAtts.defaultPalette.GetControlPoints(18).position = 0.621
ContourAtts.defaultPalette.GetControlPoints(19).colors = (0, 0, 150, 255)
ContourAtts.defaultPalette.GetControlPoints(19).position = 0.655
ContourAtts.defaultPalette.GetControlPoints(20).colors = (0, 109, 109, 255)
ContourAtts.defaultPalette.GetControlPoints(20).position = 0.69
ContourAtts.defaultPalette.GetControlPoints(21).colors = (150, 0, 150, 255)
ContourAtts.defaultPalette.GetControlPoints(21).position = 0.724
ContourAtts.defaultPalette.GetControlPoints(22).colors = (150, 150, 0, 255)
ContourAtts.defaultPalette.GetControlPoints(22).position = 0.759
ContourAtts.defaultPalette.GetControlPoints(23).colors = (150, 84, 0, 255)
ContourAtts.defaultPalette.GetControlPoints(23).position = 0.793
ContourAtts.defaultPalette.GetControlPoints(24).colors = (160, 0, 79, 255)
ContourAtts.defaultPalette.GetControlPoints(24).position = 0.828
ContourAtts.defaultPalette.GetControlPoints(25).colors = (255, 104, 28, 255)
ContourAtts.defaultPalette.GetControlPoints(25).position = 0.862
ContourAtts.defaultPalette.GetControlPoints(26).colors = (0, 170, 81, 255)
ContourAtts.defaultPalette.GetControlPoints(26).position = 0.897
ContourAtts.defaultPalette.GetControlPoints(27).colors = (68, 255, 124, 255)
ContourAtts.defaultPalette.GetControlPoints(27).position = 0.931
ContourAtts.defaultPalette.GetControlPoints(28).colors = (0, 130, 255, 255)
ContourAtts.defaultPalette.GetControlPoints(28).position = 0.966
ContourAtts.defaultPalette.GetControlPoints(29).colors = (130, 0, 255, 255)
ContourAtts.defaultPalette.GetControlPoints(29).position = 1
ContourAtts.defaultPalette.smoothing = ContourAtts.defaultPalette.None  # None, Linear, CubicSpline
ContourAtts.defaultPalette.equalSpacingFlag = 1
ContourAtts.defaultPalette.discreteFlag = 1
ContourAtts.defaultPalette.externalFlag = 0
ContourAtts.changedColors = (1, 2, 0, 3)
ContourAtts.colorType = ContourAtts.ColorByMultipleColors  # ColorBySingleColor, ColorByMultipleColors, ColorByColorTable
ContourAtts.colorTableName = "contoured"
ContourAtts.invertColorTable = 0
ContourAtts.legendFlag = 1
ContourAtts.lineStyle = ContourAtts.SOLID  # SOLID, DASH, DOT, DOTDASH
ContourAtts.lineWidth = 0
ContourAtts.singleColor = (255, 0, 0, 255)
ContourAtts.SetMultiColor(0, (51, 102, 255, 255))
ContourAtts.SetMultiColor(1, (0, 255, 255, 87))
ContourAtts.SetMultiColor(2, (255, 255, 0, 79))
ContourAtts.SetMultiColor(3, (255, 0, 0, 255))
ContourAtts.SetMultiColor(4, (255, 0, 255, 255))
ContourAtts.SetMultiColor(5, (255, 255, 0, 255))
ContourAtts.SetMultiColor(6, (255, 135, 0, 255))
ContourAtts.SetMultiColor(7, (255, 0, 135, 255))
ContourAtts.SetMultiColor(8, (168, 168, 168, 255))
ContourAtts.SetMultiColor(9, (255, 68, 68, 255))
ContourAtts.contourNLevels = 4
ContourAtts.contourValue = ()
ContourAtts.contourPercent = ()
ContourAtts.contourMethod = ContourAtts.Level  # Level, Value, Percent
ContourAtts.minFlag = 0
ContourAtts.maxFlag = 0
ContourAtts.min = 0
ContourAtts.max = 1
ContourAtts.scaling = ContourAtts.Linear  # Linear, Log
ContourAtts.wireframe = 0
SetPlotOptions(ContourAtts)
# Begin spontaneous state
View3DAtts = View3DAttributes()
View3DAtts.viewNormal = (0.38319, 0.499583, 0.776905)
View3DAtts.focus = (0.00134993, 0, -7.49865)
View3DAtts.viewUp = (-0.141026, 0.86289, -0.485317)
View3DAtts.viewAngle = 30
View3DAtts.parallelScale = 14.2389
View3DAtts.nearPlane = -28.4777
View3DAtts.farPlane = 28.4777
View3DAtts.imagePan = (0, 0)
View3DAtts.imageZoom = 1
View3DAtts.perspective = 1
View3DAtts.eyeAngle = 2
View3DAtts.centerOfRotationSet = 0
View3DAtts.centerOfRotation = (0.00134993, 0, -7.49865)
View3DAtts.axis3DScaleFlag = 0
View3DAtts.axis3DScales = (1, 1, 1)
View3DAtts.shear = (0, 0, 1)
SetView3D(View3DAtts)
# End spontaneous state

# Begin spontaneous state
View3DAtts = View3DAttributes()
View3DAtts.viewNormal = (0.38319, 0.499583, 0.776905)
View3DAtts.focus = (0.00134993, 0, -7.49865)
View3DAtts.viewUp = (-0.141026, 0.86289, -0.485317)
View3DAtts.viewAngle = 30
View3DAtts.parallelScale = 14.2389
View3DAtts.nearPlane = -28.4777
View3DAtts.farPlane = 28.4777
View3DAtts.imagePan = (0, 0)
View3DAtts.imageZoom = 1
View3DAtts.perspective = 1
View3DAtts.eyeAngle = 2
View3DAtts.centerOfRotationSet = 0
View3DAtts.centerOfRotation = (0.00134993, 0, -7.49865)
View3DAtts.axis3DScaleFlag = 0
View3DAtts.axis3DScales = (1, 1, 1)
View3DAtts.shear = (0, 0, 1)
SetView3D(View3DAtts)
# End spontaneous state

# Begin spontaneous state
View3DAtts = View3DAttributes()
View3DAtts.viewNormal = (0.401175, 0.53448, 0.743902)
View3DAtts.focus = (0.00134993, 0, -7.49865)
View3DAtts.viewUp = (-0.153676, 0.839879, -0.520563)
View3DAtts.viewAngle = 30
View3DAtts.parallelScale = 14.2389
View3DAtts.nearPlane = -28.4777
View3DAtts.farPlane = 28.4777
View3DAtts.imagePan = (0, 0)
View3DAtts.imageZoom = 1
View3DAtts.perspective = 1
View3DAtts.eyeAngle = 2
View3DAtts.centerOfRotationSet = 0
View3DAtts.centerOfRotation = (0.00134993, 0, -7.49865)
View3DAtts.axis3DScaleFlag = 0
View3DAtts.axis3DScales = (1, 1, 1)
View3DAtts.shear = (0, 0, 1)
SetView3D(View3DAtts)
# End spontaneous state

# Begin spontaneous state
View3DAtts = View3DAttributes()
View3DAtts.viewNormal = (0.46304, 0.517068, 0.719885)
View3DAtts.focus = (0.00134993, 0, -7.49865)
View3DAtts.viewUp = (-0.153011, 0.846641, -0.509693)
View3DAtts.viewAngle = 30
View3DAtts.parallelScale = 14.2389
View3DAtts.nearPlane = -28.4777
View3DAtts.farPlane = 28.4777
View3DAtts.imagePan = (0, 0)
View3DAtts.imageZoom = 1
View3DAtts.perspective = 1
View3DAtts.eyeAngle = 2
View3DAtts.centerOfRotationSet = 0
View3DAtts.centerOfRotation = (0.00134993, 0, -7.49865)
View3DAtts.axis3DScaleFlag = 0
View3DAtts.axis3DScales = (1, 1, 1)
View3DAtts.shear = (0, 0, 1)
SetView3D(View3DAtts)
# End spontaneous state

# Begin spontaneous state
View3DAtts = View3DAttributes()
View3DAtts.viewNormal = (0.536075, 0.544046, 0.645475)
View3DAtts.focus = (0.00134993, 0, -7.49865)
View3DAtts.viewUp = (-0.174165, 0.819455, -0.546041)
View3DAtts.viewAngle = 30
View3DAtts.parallelScale = 14.2389
View3DAtts.nearPlane = -28.4777
View3DAtts.farPlane = 28.4777
View3DAtts.imagePan = (0, 0)
View3DAtts.imageZoom = 1
View3DAtts.perspective = 1
View3DAtts.eyeAngle = 2
View3DAtts.centerOfRotationSet = 0
View3DAtts.centerOfRotation = (0.00134993, 0, -7.49865)
View3DAtts.axis3DScaleFlag = 0
View3DAtts.axis3DScales = (1, 1, 1)
View3DAtts.shear = (0, 0, 1)
SetView3D(View3DAtts)
# End spontaneous state

# Begin spontaneous state
View3DAtts = View3DAttributes()
View3DAtts.viewNormal = (0.531578, 0.546217, 0.647358)
View3DAtts.focus = (0.00134993, 0, -7.49865)
View3DAtts.viewUp = (-0.174011, 0.81841, -0.547655)
View3DAtts.viewAngle = 30
View3DAtts.parallelScale = 14.2389
View3DAtts.nearPlane = -28.4777
View3DAtts.farPlane = 28.4777
View3DAtts.imagePan = (0, 0)
View3DAtts.imageZoom = 1
View3DAtts.perspective = 1
View3DAtts.eyeAngle = 2
View3DAtts.centerOfRotationSet = 0
View3DAtts.centerOfRotation = (0.00134993, 0, -7.49865)
View3DAtts.axis3DScaleFlag = 0
View3DAtts.axis3DScales = (1, 1, 1)
View3DAtts.shear = (0, 0, 1)
SetView3D(View3DAtts)
# End spontaneous state

RecenterView()
# Begin spontaneous state
View3DAtts = View3DAttributes()
View3DAtts.viewNormal = (0.419764, 0.514367, 0.747814)
View3DAtts.focus = (0.00134993, 0, -7.49865)
View3DAtts.viewUp = (-0.196575, 0.855881, -0.478357)
View3DAtts.viewAngle = 30
View3DAtts.parallelScale = 14.2389
View3DAtts.nearPlane = -28.4777
View3DAtts.farPlane = 28.4777
View3DAtts.imagePan = (0, 0)
View3DAtts.imageZoom = 1
View3DAtts.perspective = 1
View3DAtts.eyeAngle = 2
View3DAtts.centerOfRotationSet = 0
View3DAtts.centerOfRotation = (0.00134993, 0, -7.49865)
View3DAtts.axis3DScaleFlag = 0
View3DAtts.axis3DScales = (1, 1, 1)
View3DAtts.shear = (0, 0, 1)
SetView3D(View3DAtts)
# End spontaneous state

# Begin spontaneous state
View3DAtts = View3DAttributes()
View3DAtts.viewNormal = (0.487565, 0.459505, 0.742385)
View3DAtts.focus = (0.00134993, 0, -7.49865)
View3DAtts.viewUp = (-0.164368, 0.883404, -0.43884)
View3DAtts.viewAngle = 30
View3DAtts.parallelScale = 14.2389
View3DAtts.nearPlane = -28.4777
View3DAtts.farPlane = 28.4777
View3DAtts.imagePan = (0, 0)
View3DAtts.imageZoom = 1
View3DAtts.perspective = 1
View3DAtts.eyeAngle = 2
View3DAtts.centerOfRotationSet = 0
View3DAtts.centerOfRotation = (0.00134993, 0, -7.49865)
View3DAtts.axis3DScaleFlag = 0
View3DAtts.axis3DScales = (1, 1, 1)
View3DAtts.shear = (0, 0, 1)
SetView3D(View3DAtts)
# End spontaneous state

# Begin spontaneous state
View3DAtts = View3DAttributes()
View3DAtts.viewNormal = (0.458196, 0.405159, 0.79114)
View3DAtts.focus = (0.00134993, 0, -7.49865)
View3DAtts.viewUp = (-0.14326, 0.912096, -0.384132)
View3DAtts.viewAngle = 30
View3DAtts.parallelScale = 14.2389
View3DAtts.nearPlane = -28.4777
View3DAtts.farPlane = 28.4777
View3DAtts.imagePan = (0, 0)
View3DAtts.imageZoom = 1
View3DAtts.perspective = 1
View3DAtts.eyeAngle = 2
View3DAtts.centerOfRotationSet = 0
View3DAtts.centerOfRotation = (0.00134993, 0, -7.49865)
View3DAtts.axis3DScaleFlag = 0
View3DAtts.axis3DScales = (1, 1, 1)
View3DAtts.shear = (0, 0, 1)
SetView3D(View3DAtts)
# End spontaneous state

# Begin spontaneous state
View3DAtts = View3DAttributes()
View3DAtts.viewNormal = (0.495537, 0.384605, 0.778795)
View3DAtts.focus = (0.00134993, 0, -7.49865)
View3DAtts.viewUp = (-0.130883, 0.919449, -0.370788)
View3DAtts.viewAngle = 30
View3DAtts.parallelScale = 14.2389
View3DAtts.nearPlane = -28.4777
View3DAtts.farPlane = 28.4777
View3DAtts.imagePan = (0, 0)
View3DAtts.imageZoom = 1
View3DAtts.perspective = 1
View3DAtts.eyeAngle = 2
View3DAtts.centerOfRotationSet = 0
View3DAtts.centerOfRotation = (0.00134993, 0, -7.49865)
View3DAtts.axis3DScaleFlag = 0
View3DAtts.axis3DScales = (1, 1, 1)
View3DAtts.shear = (0, 0, 1)
SetView3D(View3DAtts)
# End spontaneous state

# Begin spontaneous state
View3DAtts = View3DAttributes()
View3DAtts.viewNormal = (0.452666, 0.446257, 0.771977)
View3DAtts.focus = (0.00134993, 0, -7.49865)
View3DAtts.viewUp = (-0.114208, 0.887641, -0.446151)
View3DAtts.viewAngle = 30
View3DAtts.parallelScale = 14.2389
View3DAtts.nearPlane = -28.4777
View3DAtts.farPlane = 28.4777
View3DAtts.imagePan = (0, 0)
View3DAtts.imageZoom = 1
View3DAtts.perspective = 1
View3DAtts.eyeAngle = 2
View3DAtts.centerOfRotationSet = 0
View3DAtts.centerOfRotation = (0.00134993, 0, -7.49865)
View3DAtts.axis3DScaleFlag = 0
View3DAtts.axis3DScales = (1, 1, 1)
View3DAtts.shear = (0, 0, 1)
SetView3D(View3DAtts)
# End spontaneous state


