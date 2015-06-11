
OpenDatabase("localhost:./reyanis*.vtk database", 0)

DefineTensorExpression("rey", "{{rey1, rey2, rey3}, {rey2, rey4, rey5}, {rey3, rey5, rey6}}")


DeleteActivePlots()
AddPlot("Tensor", "rey", 1, 1)
SetActivePlots(0)
AddOperator("ThreeSlice", 1)
ThreeSliceAtts = ThreeSliceAttributes()
ThreeSliceAtts.x = 0
ThreeSliceAtts.y = 63
ThreeSliceAtts.z = 31
ThreeSliceAtts.interactive = 1
SetOperatorOptions(ThreeSliceAtts, 1)
DrawPlots()

