
OpenDatabase("localhost:./CylNewtZ8.*.vtk database", 0)
DefineScalarExpression("v1", "momentum[0]/density")
DefineScalarExpression("v2", "momentum[1]/density")
DefineScalarExpression("v3", "momentum[2]/density")
DefineVectorExpression("vel", "momentum/density")
DefineScalarExpression("b1", "cell_centered_B[0]")
DefineScalarExpression("b2", "cell_centered_B[1]")
DefineScalarExpression("b3", "cell_centered_B[2]")

AddPlot("Vector","cell_centered_B")
AddPlot("Vector","vel")
AddPlot("Pseudocolor", "v1")



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
TransformAtts.doTranslate = 0
TransformAtts.translateX = 0
TransformAtts.translateY = 0
TransformAtts.translateZ = 0
TransformAtts.transformType = TransformAtts.Coordinate  # Similarity, Coordinate, Linear
TransformAtts.inputCoordSys = TransformAtts.Cylindrical  # Cartesian, Cylindrical, Spherical
TransformAtts.outputCoordSys = TransformAtts.Cartesian  # Cartesian, Cylindrical, Spherical
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

