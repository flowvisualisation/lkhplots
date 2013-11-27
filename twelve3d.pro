
!p.charsize=2
!p.position=0
nx = f.s.gn[0]
nz = f.s.gn[2]
slice= f.s.gn[1]/2

bx=reform(f.bx[*,slice,*],nx,nz)
by=reform(f.by[*,slice,*],nx,nz)
bz=reform(f.bz[*,slice,*],nx,nz)
ex=reform(f.ex[*,slice,*],nx,nz)
ey=reform(f.ey[*,slice,*],nx,nz)
ez=reform(f.ez[*,slice,*],nx,nz)
vix=reform(f.v[*,slice,*,0,1],nx,nz)
viy=reform(f.v[*,slice,*,1,1],nx,nz)
viz=reform(f.v[*,slice,*,2,1],nx,nz)
vex=reform(f.v[*,slice,*,0,0],nx,nz)
vey=reform(f.v[*,slice,*,1,0],nx,nz)
vez=reform(f.v[*,slice,*,2,0],nx,nz)


loadct,0
window, xs=1100,ys=1300
!p.multi=[0,3,4]
!x.style=1
!y.style=1
loadct,33
tvlct, 0,0,0,0
tvlct, 255,255,255,1

!p.background=1

xx=findgen(nx)
yy=findgen(nz)

p1 = !P & x1 = !X & y1 = !Y

r=scale_vector(bx,0,255)
contour, bx,xx,yy,/nodata, title='B!DX!N'
tvimage, r, /overplot
r=scale_vector(by,0,255)
contour, by, xx,yy,/nodata, title='B!DY!N'
tvimage, r, /overplot
r=scale_vector(bz,0,255)
contour, bz, xx,yy,/nodata, title='B!DZ!N'
tvimage, r, /overplot

r=scale_vector(ex,0,255)
contour, ex, xx,yy,/nodata, title='E!DX!N'
tvimage, r, /overplot
r=scale_vector(ey,0,255)
contour, ey, xx,yy,/nodata, title='E!DY!N'
tvimage, r, /overplot
r=scale_vector(ez,0,255)
contour, ez, xx,yy,/nodata, title='E!DZ!N'
tvimage, r, /overplot

r=scale_vector(vix,0,255)
contour, vix, xx,yy,/nodata, title='V!Dion, X!N'
tvimage, r, /overplot



qsm=1
vixsm=smooth(vix,qsm,/edge_wrap)
vizsm=smooth(viz,qsm,/edge_wrap)
var= 0.5*(shift(vixsm,0,-1)-shift(vixsm,0,1) ) - 0.5*(shift(vizsm,-1,0) - shift(vizsm,1,0))
r=scale_vector(var,0,255)
contour, var, xx,yy,/nodata, title='V!Dion, Y!N'
tvimage, r, /overplot
r=scale_vector(viz,0,255)
contour, viz, xx,yy,/nodata, title='V!Dion, Z!N'
tvimage, r, /overplot


r=scale_vector(vex,0,255)
contour, vex, xx,yy,/nodata, title='V!Delec, X!N'
tvimage, r, /overplot

vexsm=smooth(vex,qsm,/edge_wrap)
vezsm=smooth(vez,qsm,/edge_wrap)
var= 0.5*(shift(vexsm,0,-1)-shift(vexsm,0,1) ) - 0.5*(shift(vezsm,-1,0) - shift(vezsm,1,0))
r=scale_vector(var,0,255)
contour, var, xx,yy,/nodata, title='V!Delec, Y!N'
tvimage, r, /overplot

r=scale_vector(vez,0,255)
contour, vez, xx,yy,/nodata, title='V!Delec, Z!N'
tvimage, r, /overplot
!p.position=0
!p.multi=0

end
