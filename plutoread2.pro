pro plutoread2,dens, vx,vy, vz,bx,by,bz, xx3d,yy3d,zz3d,xx,yy,zz,nx,ny,nz,nfile, time;, vx1,vx2,vx3, bx1,bx2,bx3,x1,x2,x3,nx1,nx2,nx3,t

 COMMON PLUTO_GRID
 COMMON PLUTO_VAR
 COMMON PLUTO_RUN



pload,nfile, /silent

rho=rho
vx=vx1
vy=vx2
vz=vx3
;bx=bx1
;by=bx2
;bz=bx3
xx=x1
yy=x2
zz=x3
nx=nx1
ny=nx2
nz=nx3


xx3d=rebin(reform(xx,nx,  1,  1),nx,ny,nz) 
yy3d=rebin(reform(yy,  1,ny,  1),nx,ny,nz) 
zz3d=rebin(reform(zz,  1,  1,nz),nx,ny,nz) 

time=t(nfile)
end
