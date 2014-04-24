

import math
DeleteActivePlots()
OpenDatabase("localhost:./v*.vtk database", 62)
DefineScalarExpression("x", "coord(mesh)[0]")
DefineScalarExpression("y", "coord(mesh)[1]")
DefineScalarExpression("z", "coord(mesh)[2]")
DefineScalarExpression("amp", "24.33")
DefineScalarExpression("pi", "3.141592741012573242187500")
#defn = "%f  *  conn_cmfe(volume(<[0]i:mesh_3d>), mesh_3d)" %(t1)
#DefineScalarExpression("vtmri", "0.25*exp(timestep()*0.75/10.)*sin(2*pi*z)")
DefineScalarExpression("vtmri", "exp(cycle()*0.075)*0.25*sin(2*pi*z)")
DefineScalarExpression("amp", "24.33")
DefineScalarExpression("vxmri", "amp*sin(2*pi*z)")
DefineScalarExpression("amp2", "26.45")
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
DefineVectorExpression("velproj", "{uhp,vhp,w}")
DefineScalarExpression("testvortproj", "curl(velproj)")


DefineScalarExpression("curproj", "dot(cur,kh)")
DefineScalarExpression("cur1hp", "dot(cur,kh)")
DefineScalarExpression("cur1hp", "dot(cur,kperp)")



AddPlot("Pseudocolor", "curproj", 11, 1)
DrawPlots()
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

#ChangeActivePlotsVar("vort2")
#ChangeActivePlotsVar("vort2")
#ChangeActivePlotsVar("vort1")

