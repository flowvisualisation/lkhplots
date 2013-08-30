
readcol, "averages.dat", t,dt, b2, bxby, rhou, alpha

window, xs=900, ys=1100
!p.multi=[0,1,4]
!p.charsize=2
cgplot, t, b2, /ylog, title="b2"
cgplot, t, alpha, title="alpha"
cgplot, t, bxby, title="bxby"
cgplot, t, rhou, title="rho ux"
!p.multi=0
end
