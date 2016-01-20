OpenDatabase("localhost:./HKDisk.*.vtk database", 0)

AddPlot("Pseudocolor", "density", 1, 1)

SetActivePlots(0)

AddOperator("Transform", 1)
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
TransformAtts.doTranslate = 0
TransformAtts.translateX = 0
TransformAtts.translateY = 0
TransformAtts.translateZ = 0
TransformAtts.transformType = TransformAtts.Coordinate  # Similarity, Coordinate, Linear
TransformAtts.inputCoordSys = TransformAtts.Cylindrical  # Cartesian, Cylindrical, Spherical
TransformAtts.outputCoordSys = TransformAtts.Cartesian  # Cartesian, Cylindrical, Spherical
TransformAtts.continuousPhi = 0
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
SetOperatorOptions(TransformAtts, 1)
AddOperator("ThreeSlice", 1)
# Begin spontaneous state
View3DAtts = View3DAttributes()
View3DAtts.viewNormal = (0.346119, -0.708613, 0.614874)
View3DAtts.focus = (23.4142, 2.86102e-06, 0)
View3DAtts.viewUp = (-0.083738, 0.629433, 0.772529)
View3DAtts.viewAngle = 30
View3DAtts.parallelScale = 42.3294
View3DAtts.nearPlane = -84.6587
View3DAtts.farPlane = 84.6587
View3DAtts.imagePan = (0, 0)
View3DAtts.imageZoom = 1
View3DAtts.perspective = 1
View3DAtts.eyeAngle = 2
View3DAtts.centerOfRotationSet = 0
View3DAtts.centerOfRotation = (23.4142, 2.86102e-06, 0)
View3DAtts.axis3DScaleFlag = 0
View3DAtts.axis3DScales = (1, 1, 1)
View3DAtts.shear = (0, 0, 1)
View3DAtts.windowValid = 1
SetView3D(View3DAtts)
# End spontaneous state

# Begin spontaneous state
View3DAtts = View3DAttributes()
View3DAtts.viewNormal = (0.331325, -0.922701, -0.197096)
View3DAtts.focus = (23.4142, 2.86102e-06, 0)
View3DAtts.viewUp = (0.261019, -0.111105, 0.958919)
View3DAtts.viewAngle = 30
View3DAtts.parallelScale = 42.3294
View3DAtts.nearPlane = -84.6587
View3DAtts.farPlane = 84.6587
View3DAtts.imagePan = (0, 0)
View3DAtts.imageZoom = 1
View3DAtts.perspective = 1
View3DAtts.eyeAngle = 2
View3DAtts.centerOfRotationSet = 0
View3DAtts.centerOfRotation = (23.4142, 2.86102e-06, 0)
View3DAtts.axis3DScaleFlag = 0
View3DAtts.axis3DScales = (1, 1, 1)
View3DAtts.shear = (0, 0, 1)
View3DAtts.windowValid = 1
SetView3D(View3DAtts)
# End spontaneous state

# Begin spontaneous state
View3DAtts = View3DAttributes()
View3DAtts.viewNormal = (-0.1857, -0.954124, 0.234868)
View3DAtts.focus = (23.4142, 2.86102e-06, 0)
View3DAtts.viewUp = (0.244609, 0.186613, 0.951495)
View3DAtts.viewAngle = 30
View3DAtts.parallelScale = 42.3294
View3DAtts.nearPlane = -84.6587
View3DAtts.farPlane = 84.6587
View3DAtts.imagePan = (0, 0)
View3DAtts.imageZoom = 1
View3DAtts.perspective = 1
View3DAtts.eyeAngle = 2
View3DAtts.centerOfRotationSet = 0
View3DAtts.centerOfRotation = (23.4142, 2.86102e-06, 0)
View3DAtts.axis3DScaleFlag = 0
View3DAtts.axis3DScales = (1, 1, 1)
View3DAtts.shear = (0, 0, 1)
View3DAtts.windowValid = 1
SetView3D(View3DAtts)
# End spontaneous state

# Begin spontaneous state
View3DAtts = View3DAttributes()
View3DAtts.viewNormal = (-0.679905, -0.700197, 0.217837)
View3DAtts.focus = (23.4142, 2.86102e-06, 0)
View3DAtts.viewUp = (0.175536, 0.13302, 0.975445)
View3DAtts.viewAngle = 30
View3DAtts.parallelScale = 42.3294
View3DAtts.nearPlane = -84.6587
View3DAtts.farPlane = 84.6587
View3DAtts.imagePan = (0, 0)
View3DAtts.imageZoom = 1
View3DAtts.perspective = 1
View3DAtts.eyeAngle = 2
View3DAtts.centerOfRotationSet = 0
View3DAtts.centerOfRotation = (23.4142, 2.86102e-06, 0)
View3DAtts.axis3DScaleFlag = 0
View3DAtts.axis3DScales = (1, 1, 1)
View3DAtts.shear = (0, 0, 1)
View3DAtts.windowValid = 1
SetView3D(View3DAtts)
# End spontaneous state

# Begin spontaneous state
View3DAtts = View3DAttributes()
View3DAtts.viewNormal = (-0.635492, -0.758789, 0.14279)
View3DAtts.focus = (23.4142, 2.86102e-06, 0)
View3DAtts.viewUp = (0.135009, 0.0728817, 0.98816)
View3DAtts.viewAngle = 30
View3DAtts.parallelScale = 42.3294
View3DAtts.nearPlane = -84.6587
View3DAtts.farPlane = 84.6587
View3DAtts.imagePan = (0, 0)
View3DAtts.imageZoom = 1
View3DAtts.perspective = 1
View3DAtts.eyeAngle = 2
View3DAtts.centerOfRotationSet = 0
View3DAtts.centerOfRotation = (23.4142, 2.86102e-06, 0)
View3DAtts.axis3DScaleFlag = 0
View3DAtts.axis3DScales = (1, 1, 1)
View3DAtts.shear = (0, 0, 1)
View3DAtts.windowValid = 1
SetView3D(View3DAtts)
# End spontaneous state

DrawPlots()
