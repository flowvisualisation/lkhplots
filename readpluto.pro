
;readcol,'averages.dat',t,dt,b2,bxby,rhouxduy,alpha,bz2,by2,bx2
readcol,'averages.dat',t,dt,b2,vx2,vy2,vz2,bx2,vy2,vz2

omega=1e-3
tnorm=t*omega

!y.range=[1e-13,10]
cgplot, tnorm, vx2, /ylog
cgplot, tnorm, vy2, /overplot
cgplot, tnorm, vz2, /overplot
cgplot, tnorm, bx2, /overplot
cgplot, tnorm, by2, /overplot
cgplot, tnorm, bz2, /overplot
end
