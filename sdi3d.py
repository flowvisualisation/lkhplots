
OpenDatabase("localhost:./data.0000.dbl.h5", 0)
DefineVectorExpression("b", "{<vars/bx1>,<vars/bx2>,<vars/bx3>}")
DefineVectorExpression("v", "{<vars/vx1>,<vars/vx2>,<vars/vx3>}")

DefineScalarExpression("x", "coord(mesh_104x104x104)[0]")
DefineScalarExpression("y", "coord(mesh_104x104x104)[1]")
DefineScalarExpression("z", "coord(mesh_104x104x104)[2]")
DefineScalarExpression("rc", "sqrt(x*x+y*y)")
DefineScalarExpression("rs", "sqrt(x*x+y*y+z*z)")
DefineScalarExpression("th", "acos(z/rs)")
DefineScalarExpression("phi", "atan2(y,x)")
DefineScalarExpression("r3", "rs*rs*rs")
DefineScalarExpression("bmag", "sqrt(2./125.)")
DefineScalarExpression("br", "2.0*bmag*cos(th)/r3")
DefineScalarExpression("bth", "bmag*sin(th)/r3")
DefineScalarExpression("bx", "br*sin(th)*cos(phi)+bth*cos(th)*cos(phi)")
DefineScalarExpression("by", "br*sin(th)*sin(phi)+bth*cos(th)*sin(phi)")
DefineScalarExpression("bz", "br*cos(th)-bth*sin(th)")

DefineVectorExpression("b", "{<vars/bx1>+bx,<vars/bx2>+by,<vars/bx3>+bz}")
AddPlot("Pseudocolor", "vars/rho", 1, 1)
AddOperator("ThreeSlice")

AddPlot("Vector", "v", 1, 1)
AddPlot("Streamline", "b", 1, 1)



SetActivePlots((0, 1))
SetActivePlots(1)
SetActivePlots((1, 2))
SetActivePlots(2)
PseudocolorAtts = PseudocolorAttributes()
PseudocolorAtts.scaling = PseudocolorAtts.Log  # Linear, Log, Skew
PseudocolorAtts.skewFactor = 1
PseudocolorAtts.limitsMode = PseudocolorAtts.OriginalData  # OriginalData, CurrentPlot
PseudocolorAtts.minFlag = 0
PseudocolorAtts.min = 0
PseudocolorAtts.maxFlag = 0
PseudocolorAtts.max = 1
PseudocolorAtts.centering = PseudocolorAtts.Natural  # Natural, Nodal, Zonal
PseudocolorAtts.colorTableName = "hot"
PseudocolorAtts.invertColorTable = 0
PseudocolorAtts.opacityType = PseudocolorAtts.FullyOpaque  # ColorTable, FullyOpaque, Constant, Ramp, VariableRange
PseudocolorAtts.opacityVariable = ""
PseudocolorAtts.opacity = 1
PseudocolorAtts.opacityVarMin = 0
PseudocolorAtts.opacityVarMax = 1
PseudocolorAtts.opacityVarMinFlag = 0
PseudocolorAtts.opacityVarMaxFlag = 0
PseudocolorAtts.pointSize = 0.05
PseudocolorAtts.pointType = PseudocolorAtts.Point  # Box, Axis, Icosahedron, Octahedron, Tetrahedron, SphereGeometry, Point, Sphere
PseudocolorAtts.pointSizeVarEnabled = 0
PseudocolorAtts.pointSizeVar = "default"
PseudocolorAtts.pointSizePixels = 2
PseudocolorAtts.lineType = PseudocolorAtts.Line  # Line, Tube, Ribbon
PseudocolorAtts.lineStyle = PseudocolorAtts.SOLID  # SOLID, DASH, DOT, DOTDASH
PseudocolorAtts.lineWidth = 0
PseudocolorAtts.tubeDisplayDensity = 10
PseudocolorAtts.tubeRadiusSizeType = PseudocolorAtts.FractionOfBBox  # Absolute, FractionOfBBox
PseudocolorAtts.tubeRadiusAbsolute = 0.125
PseudocolorAtts.tubeRadiusBBox = 0.005
PseudocolorAtts.varyTubeRadius = 0
PseudocolorAtts.varyTubeRadiusVariable = ""
PseudocolorAtts.varyTubeRadiusFactor = 10
PseudocolorAtts.endPointType = PseudocolorAtts.None  # None, Tails, Heads, Both
PseudocolorAtts.endPointStyle = PseudocolorAtts.Spheres  # Spheres, Cones
PseudocolorAtts.endPointRadiusSizeType = PseudocolorAtts.FractionOfBBox  # Absolute, FractionOfBBox
PseudocolorAtts.endPointRadiusAbsolute = 1
PseudocolorAtts.endPointRadiusBBox = 0.005
PseudocolorAtts.endPointRatio = 2
PseudocolorAtts.renderSurfaces = 1
PseudocolorAtts.renderWireframe = 0
PseudocolorAtts.renderPoints = 0
PseudocolorAtts.smoothingLevel = 0
PseudocolorAtts.legendFlag = 1
PseudocolorAtts.lightingFlag = 1
SetPlotOptions(PseudocolorAtts)
# Begin spontaneous state
View3DAtts = View3DAttributes()
View3DAtts.viewNormal = (-0.125533, -0.992031, -0.0107371)
View3DAtts.focus = (0, 0, 0)
View3DAtts.viewUp = (0.113567, -0.0251208, 0.993213)
View3DAtts.viewAngle = 30
View3DAtts.parallelScale = 8.2284
View3DAtts.nearPlane = -16.4568
View3DAtts.farPlane = 16.4568
View3DAtts.imagePan = (0, 0)
View3DAtts.imageZoom = 1
View3DAtts.perspective = 1
View3DAtts.eyeAngle = 2
View3DAtts.centerOfRotationSet = 0
View3DAtts.centerOfRotation = (0, 0, 0)
View3DAtts.axis3DScaleFlag = 0
View3DAtts.axis3DScales = (1, 1, 1)
View3DAtts.shear = (0, 0, 1)
View3DAtts.windowValid = 1
SetView3D(View3DAtts)
# End spontaneous state

DrawPlots()
