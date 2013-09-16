

readcol, "averages.dat", t,dt, b2, bxby, rhou, alpha

omega=1e-3
tnorm=t*omega
;window, xs=900, ys=1100
!p.multi=[0]
!p.charsize=2
growth=.75
InitialAmplitude=1e-4
InitialTransient=25
bnorm=sqrt(b2)
cgplot, tnorm, bnorm, title="b2",xtitle="Time, (orbits)", xrange=[0,40], /ylog
cgplot, tnorm(*)+InitialTransient, InitialAmplitude*exp(growth*tnorm), /overplot
;cgplot, tnorm, abs(alpha), /ylog, title="alpha",xtitle="Time, (orbits)"
;cgplot, tnorm, abs(bxby), /ylog, title="bxby",xtitle="Time, (orbits)"
;cgplot, tnorm, abs(rhou),/ylog, title="rho ux",xtitle="Time, (orbits)"
!p.multi=0
end
