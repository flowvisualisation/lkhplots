
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
window, xs=1100,ys=800
!p.multi=0
!x.style=1
!y.style=1
loadct,33
tvlct, 0,0,0,0
tvlct, 255,255,255,1

!p.background=1

xx=findgen(nx)
yy=findgen(nz)



cgcontour, bx, xx,yy,/nodata
cgcontour, bx[0:nx/2,*], xx[0:nx/2],yy, /overplot
cgcontour, by[nx/2:nx-1,*], xx[nx/2:nx-1],yy, /overplot
end
