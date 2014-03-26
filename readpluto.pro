
readcol,'averages.dat',t,dt,b2,bxby,rhouxduy,alpha,bz2,by2,bx2


cgplot, t, by2, /ylog
cgplot, t, rhouxduy, /overplot
;cgplot, t, alpha, /overplot
cgplot, t, b2-1.187e-8, /overplot
;cgplot, t, bz2, /overplot
;cgplot, t, by2, /overplot
end
