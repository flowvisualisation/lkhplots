
OpenDatabase("localhost:./reyanis*.vtk database", 0)

DefineTensorExpression("rey", "{{rey1, rey2, rey3}, {rey2, rey4, rey5}, {rey3, rey5, rey6}}")


DeleteActivePlots()
HideActivePlots()
DeleteActivePlots()
AddPlot("Tensor", "rey", 1, 1)
SetActivePlots(0)
SetActivePlots(0)
AddOperator("Slice", 1)
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
SliceAtts.project2d = 1
SliceAtts.interactive = 1
SliceAtts.flip = 0
SliceAtts.originZoneDomain = 0
SliceAtts.originNodeDomain = 0
SliceAtts.meshName = "mesh"
SliceAtts.theta = 0
SliceAtts.phi = 90
SetOperatorOptions(SliceAtts, 1)
DrawPlots()

