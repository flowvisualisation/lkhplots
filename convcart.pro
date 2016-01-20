
pload,0, /silent

nx=500
ny=nx
nz=nx

rmax=6
rmin=.35
x1d=findgen(nx)/nx*2*rmax-rmax
y1d=findgen(ny)/ny*2*rmax-rmax
z1d=findgen(nz)/nz*2*rmax-rmax
x3d=rebin(reform(x1d,nx,1,1),nx,ny,nz)
y3d=rebin(reform(y1d,1,ny,1),nx,ny,nz)
z3d=rebin(reform(z1d,1,1,nz),nx,ny,nz)
r3d=sqrt(x3d^2+y3d^2+z3d^2)
th3d=acos(z3d/r3d)
phi3d=atan(y3d,x3d)
print, max(phi3d), min(phi3d)
print, max(th3d), min(th3d)
print, max(r3d), min(r3d)
br=bx1
bth=bx2
bphi=bx3
vr=vx1
vth=vx2
vphi=vx3

x3q=x3;-!DPI
; oops

x13d=rebin(reform(x1,nx1,1,1),nx1,nx2,nx3)
x23d=rebin(reform(x2,1,nx2,1),nx1,nx2,nx3)
x33d=rebin(reform(x3q,1,1,nx3),nx1,nx2,nx3)


bx= sin(x23d) *cos (x33d) * br + cos(x23d) *cos(x33d) *bth ;- sin(x33d)* bphi
by= sin(x23d) *sin (x33d) * br + cos(x23d) *sin(x33d) *bth ;+ cos(x33d)* bphi
bz= cos(x23d) * br - sin(x23d) *bth
vx= sin(x23d) *cos (x33d) * vr + cos(x23d) *cos(x33d) *vx2 - sin(x33d)* vx3
vy= sin(x23d) *sin (x33d) * vr + cos(x23d) *sin(x33d) *vx2 + cos(x33d)* vx3
vz= cos(x23d) * vr - sin(x23d) *vx2

mydat=rho
;mydat=z3d

arr=fltarr(nx,ny,nz)
den=fltarr(nx,ny,nz)
v1=fltarr(nx,ny,nz)
v2=fltarr(nx,ny,nz)
v3=fltarr(nx,ny,nz)
pr=fltarr(nx,ny,nz)
b1=fltarr(nx,ny,nz)
b2=fltarr(nx,ny,nz)
b3=fltarr(nx,ny,nz)

for i=0,nx-1 do begin
for j=0,ny-1 do begin
for k=0,nz-1 do begin

x=x1d[i]
y=y1d[j]
z=z1d[k]

rco  =  r3d[i,j,k]
thco =  th3d[i,j,k]
phico=  phi3d[i,j,k]

ri=where ( x1 ge rco)
thi=where ( x2 ge thco)
phii=where ( x3q ge phico)
den[i,j,k]=interpolate ( rho, ri[0], thi[0], phii[0])
pr[i,j,k]=interpolate ( prs, ri[0], thi[0], phii[0])
v1[i,j,k]=interpolate ( vx, ri[0], thi[0], phii[0])
v2[i,j,k]=interpolate ( vy, ri[0], thi[0], phii[0])
v3[i,j,k]=interpolate ( vz, ri[0], thi[0], phii[0])
b1[i,j,k]=interpolate ( bx, ri[0], thi[0], phii[0])
b2[i,j,k]=interpolate ( by, ri[0], thi[0], phii[0])
b3[i,j,k]=interpolate ( bz, ri[0], thi[0], phii[0])

if (rco ge 5.99) then begin
qsm=1e-9
b1[i,j,k]=qsm
b2[i,j,k]=qsm
b3[i,j,k]=qsm
v1[i,j,k]=qsm
v2[i,j,k]=qsm
v3[i,j,k]=qsm
den[i,j,k]=qsm
pr[i,j,k]=qsm

endif

endfor
endfor
endfor


tag="mydat"
nfile=0
g=plutovtk( tag, nfile, den, v1,v2,v3,b1,b2,b3,pr)

cgloadct,33
vec=b1[*,50,*]
var=alog10(vec)
;display,/hbar,  ims=[600,600], var
my2ddipole,den, b1,b2,b3,x1d,y1d,z1d,nx,ny,nz





end
