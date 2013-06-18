
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
SliceAtts = SliceAttributes()
SliceAtts.originPoint = (0, 0, 0)
SliceAtts.originIntercept = 0
SliceAtts.originPercent = 0
SliceAtts.originZone = 0
SliceAtts.originNode = 0
SliceAtts.normal = (-1, 0, 0)
SliceAtts.axisType = SliceAtts.ZAxis  # XAxis, YAxis, ZAxis, Arbitrary, ThetaPhi
SliceAtts.upAxis = (0, 1, 0)
SliceAtts.project2d = 0
SliceAtts.interactive = 1
SliceAtts.flip = 0
SliceAtts.originZoneDomain = 0
SliceAtts.originNodeDomain = 0
SliceAtts.meshName = "mesh"
SliceAtts.theta = 90
SliceAtts.phi = 0
SetOperatorOptions(SliceAtts, 0)
#AddOperator("Slice", 0)


AddPlot("Pseudocolor", "cmfe2", 1, 0)
SliceAtts.originPoint = (0, 0, 0)
SliceAtts.originIntercept = 0
SliceAtts.originPercent = 0
SliceAtts.originZone = 0
SliceAtts.originNode = 0
SliceAtts.normal = (-1, 0, 0)
SliceAtts.axisType = SliceAtts.YAxis  # XAxis, YAxis, ZAxis, Arbitrary, ThetaPhi
SliceAtts.upAxis = (0, 1, 0)
SliceAtts.project2d = 0
SliceAtts.interactive = 1
SliceAtts.flip = 0
SliceAtts.originZoneDomain = 0
SliceAtts.originNodeDomain = 0
SliceAtts.meshName = "mesh"
SliceAtts.theta = 90
SliceAtts.phi = 0
SetOperatorOptions(SliceAtts, 0)
AddOperator("Slice", 0)

AddPlot("Pseudocolor", "cmfe3", 1, 0)
SliceAtts.originPoint = (0, 0, 0)
SliceAtts.originIntercept = 0
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
SetOperatorOptions(SliceAtts, 0)
#AddOperator("Slice", 0)


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

DrawPlots()
