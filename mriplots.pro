

readcol, "averages.dat", t,dt, b2, bxby, rhou, alpha

omega=1e-3
tnorm=t*omega
window, xs=900, ys=1100
!p.multi=[0,1,4]
!p.charsize=2
cgplot, tnorm, b2, /ylog, title="b2",xtitle="Time, (orbits)"
cgplot, tnorm, abs(alpha), /ylog, title="alpha",xtitle="Time, (orbits)"
cgplot, tnorm, abs(bxby), /ylog, title="bxby",xtitle="Time, (orbits)"
cgplot, tnorm, abs(rhou),/ylog, title="rho ux",xtitle="Time, (orbits)"
!p.multi=0
end
