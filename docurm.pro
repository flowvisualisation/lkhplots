pload,1,/hdf5
t=fltarr(50)
background=1
hires=1
plotgrowth=0
plotgrowthvortex=1
tag='curbackgr'
doannotation=0
;curmovie, bx1,bx2,vx1,vx2, rho, prs, t , nlast, nx1,nx2,x1,x2, background,dx1,dx2, hires, plotgrowth, plotgrowthvortex, tag, doannotation
plotgrowth=1
plotgrowthvortex=0
tag='growthrate'
;curmovie, bx1,bx2,vx1,vx2, rho, prs, t , nlast, nx1,nx2,x1,x2, background,dx1,dx2, hires, plotgrowth, plotgrowthvortex, tag, doannotation
doannotation=1
plotgrowth=1
plotgrowthvortex=1
tag='curandgrowth'
cmovie, bx1,bx2,vx1,vx2, rho, prs, t , nlast, nx1,nx2,x1,x2, background,dx1,dx2, hires, plotgrowth, plotgrowthvortex, tag, doannotation
