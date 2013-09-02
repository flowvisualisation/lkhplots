
readcol, "averages.dat", t,dt, b2, bxby, rhou, alpha

!p.multi=[0,1,4]
cgplot, t, b2, /ylog
cgplot, t, alpha
cgplot, t, bxby
cgplot, t, rhou
!p.multi=0
