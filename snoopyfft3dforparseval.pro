; load some sheared data

nfile=68

snoopyread, vx,vy, vz,bx,by,bz, xx3d,yy3d,zz3d,xx,yy,zz,nx,ny,nz,nfile, time
nx1=nx
nx2=ny
nx3=nz
x1=xx
x2=yy
x3=zz

t=findgen(nfile+1)
mytime=time
vec=bx^2+by^2+bz^2
xx=x1
yy=x2
xx2d=rebin(reform(xx,nx1,1),nx1,nx2)
yy2d=rebin(reform(yy,1,nx2),nx1,nx2)
xx3d=rebin(reform(xx,nx1,1,1),nx1,nx2,nx3)
yy3d=rebin(reform(yy,1,nx2,1),nx1,nx2,nx3)

vfft=fft(vec,2)
vfft=abs(vfft)

ky=[findgen(nx2/2), -nx2/2+findgen(nx2/2)]
ky2d=rebin(reform(ky,1,nx2),nx1,nx2)
ky3d=rebin(reform(ky,1,nx2,1),nx1,nx2,nx3)


q=1.5d
omega=1.0
S=q*omega
time=mytime
; dt is difference in time between this, and the nearest shear periodic point
;
dt=mytime mod  2.0d
dt=mytime mod  0.666666666666666666666666666666666666d
time=dt
print, 'time=',time,' dt=',dt
Ly=2.0
qomegat_Ly=q*omega*time/Ly

cfft1=fft(vec,dimension=2)
jimag=complex(0,1)
cfft1shift=cfft1*exp ( -jimag * ky3d * xx3d *2 *!PI *qomegat_Ly ) 
cfft2=fft(cfft1shift, dimension=1)
cfft3=fft(cfft2, dimension=3)


sumfk=total(abs(cfft3*1.d0)^2)
normfk=(1.d0*nx)*(1.d0*ny)*(1.d0*nz)*sumfk
sumfx=total((vec*1.d0)^2) 
 print, 'Sum F(k)'
 print, sumfk , format='(F30.12)'
 print,  'Nx*Ny*Nz* Sum (F(k)'
 print,normfk , format='(F30.12)'
 print, 'Sum (f(x,y,z))' 
 print,sumfx,format='(F30.12)'
 print, 'fk/fx'
 print,normfk /sumfx, format='(F27.24)'


end
