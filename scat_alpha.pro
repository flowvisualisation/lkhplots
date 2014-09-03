

for nfile=0,100 do begin


pload,nfile, /silent

vx=vx1
vy=vx2

bx=bx1
by=bx2
nx=nx1
ny=nx2
nz=nx3

lx=x1(nx1-1)-x1(0)
ly=x2(nx2-1)-x1(0)
lz=x3(nx3-1)-x1(0)
vol=lx*ly*lz
dx=lx/nx1
dy=ly/nx2
dz=lz/nx3
;; compute global alpha


cs=1
alpha=(vx*vy -bx*by) / cs^2/rho

vol=2.*2.*1.

print, total(alpha)/(nx*1.0*ny*nz)*dx*dy*dz

;; compute global or max invii or inviii

;; could just read it in from hdf5 file

;h5_parse, 'inv.h5', /data






endfor





end
