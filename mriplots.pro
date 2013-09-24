

readcol, "averages.dat", t,dt, b2, bxby, rhou, alpha, bz2

omega=1e-3
tnorm=t*omega
window, xs=1500, ys=1100
!p.multi=[0,1,4]
!p.multi=0
!p.charsize=2
cgplot, tnorm, b2, /ylog, title="b2",xtitle="Time, (orbits)", yrange=[1e-10,1e-4], xrange=[1,40], /xlog, xstyle=1
cgplot, tnorm, bz2(*)/2., /ylog, /overplot, color="red", linestyle=2
;cgplot, tnorm, abs(alpha), /ylog, title="alpha",xtitle="Time, (orbits)"
;cgplot, tnorm, abs(bxby), /ylog, title="bxby",xtitle="Time, (orbits)"
;cgplot, tnorm, abs(rhou),/ylog, title="rho ux",xtitle="Time, (orbits)"
items=[ 'B!DT!N!U2!N/2 , Mag Pres .', $
	'B!DZ!N!U2!N/2 Z Mag .']
linestyle=[0,2]
colors=[cgcolor('black'),cgcolor('red')]
al_legend, items, linestyle=linestyle, colors=colors
!p.multi=0
end
