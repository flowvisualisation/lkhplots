cgloadct,0
cgdisplay, wid=1, xpos=100, ypos=800

for nfile=1,nlast do begin
pload,nfile

nx=nx1
ny=nx2
nz=nx3
nseeds=10

qnx=3
qny=3
qnz=4
sx=findgen(qnx)/qnx*nx+nx/8
sy=findgen(qny)/qny*ny+ny/8
sz=findgen(qnz)/qnz*nz+nz/8
sx3d=rebin(reform(sx,qnx,1,1),qnx,qny,qnz)
sy3d=rebin(reform(sy,1,qny,1),qnx,qny,qnz)
sz3d=rebin(reform(sz,1,1,qnz),qnx,qny,qnz)



sx=sx3d
sy=sy3d
sz=sz3d
SCALE3, xr=[0,nx-1], yr=[0,ny-1], zr = [0,nz-1]


cgSurf, dist(30), xr=[0,nx-1], yr=[0,ny-1], zr = [0,nz-1], $ 
   /nodata, xst=1, yst=1 
flow3, bx1, bx2, bx3 , arrowsize=0,  len=1, nsteps=120, nvecs=20, sx=sx,sy=sy,sz=sz



endfor
end
