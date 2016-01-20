pro nirvanaread, dens, vx,vy, vz,bx,by,bz, xx3d,yy3d,zz3d,xx,yy,zz,nx,ny,nz,nfile, time

r=h5_read(nfile,/rho, /v,/B)
grd_ctl, model=nfile, g,c
vx=transpose(reform(r.v(0,*,*,*)))
vy=transpose(reform(r.v(1,*,*,*)))
vz=transpose(reform(r.v(2,*,*,*)))
bx=transpose(reform(r.b(0,*,*,*)))
by=transpose(reform(r.b(1,*,*,*)))
bz=transpose(reform(r.b(2,*,*,*)))
dens=transpose(reform(r.rho(*,*,*)))


xx=g.x
yy=g.y
zz=g.z
nx=g.nx
ny=g.ny
nz=g.nz

xx3d=rebin(reform(xx,nx,1,1),nx,ny,nz)
yy3d=rebin(reform(yy,1,ny,1),nx,ny,nz)
zz3d=rebin(reform(zz,1,1,nz),nx,ny,nz)

time=c.time



end

