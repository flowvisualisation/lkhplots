

nfile=16
for nfile=0,25,2 do begin
pload,nfile

vec=vx3(*,*,0)


vx=vx1
vy=vx2
vz=vx3
xx=x1
yy=x2
zz=x3
nx=nx1
ny=nx2
nz=nx3



sbq=1.5
sbomega=1e-3
sba=-0.5*sbq*sbomega
vsh=2*sba
eps=1e-3
lx=2.0

xx3d=rebin(reform(x1,nx1,  1,  1),nx1,nx2,nx3) 
yy3d=rebin(reform(x2,  1,nx2,  1),nx1,nx2,nx3) 
zz3d=rebin(reform(x3,  1,  1,nx3),nx1,nx2,nx3) 
vshear=vsh*xx3d
scrh=lx*sbomega*eps/8.0
vmri=scrh*sin(2*!PI*zz3d)*exp(0.74975229*nfile)
vmri=max(vx)*sin(2*!PI*zz3d)
;; calc vorticity, x,y,z
;vortz=getvort(vx,vy,xx,yy,nx,ny)
;vorty=getvort(vx,vz,xx,zz,nx,nz)
;vortx1getvort(vy,vz,yy,zz,ny,nz)

vx=vx -vmri
vy=vy-vshear -vmri

Lx=2.0
Ly=2.0
x2d=rebin(reform(x1,nx1,1),nx1,nx2)
y2d=rebin(reform(x2,1,nx2),nx1,nx2)
a=dist(nx1)
;vec=sin(10 *2*!PI* (x2d+y2d)/nx1)+ sin( 2*!PI* (x2d+y2d)/nx1  ) 
;vec=sin(2*!PI* (x2d)/nx1 ) 

ffttot=complexarr(nx1,nx2)


x2d=rebin(reform( x1, nx1,1), nx1,nx2)

q=1.5d
omega=1.0d-3
S=q*omega
time=t[nfile] 
time=t[nfile] mod  2000.0d
qomegat_Ly=q*omega*time/Ly

fft3d=complexarr(nx1,nx2,nx3)
fft3d2=complexarr(nx1,nx2,nx3)
datshift=fltarr(nx1,nx2,nx3)
for k=0, nx3-1 do begin

vec=vx3(*,*,k)
;vec=getvort(vx1(*,*,0),vx2(*,*,0),x1,x2,nx1,nx2)
 shearfft2d, vec, ffttot, qomegat_Ly, x2d, nx1,nx2,x1
 fft3d(*,*,k)=ffttot

 datshift(*,*,k)=real_part(fft(ffttot, /inverse))

endfor

for j=0, nx2-1 do begin
for i=0, nx1-1 do begin

fft3d2(i,j,*)=fft(fft3d(i,k,*))
endfor
endfor

fftvec=fft(vec )
ifft=fft(ffttot,  /inverse)
ifftv=fft(fftvec,  /inverse)

shiftfftvec=shift(fftvec , nx/2, ny/2)
cgloadct,33
;display,(abs(shift_fft)), ims=8

window, xs=2300, ys=900

!p.position=0
;!p.multi=[0,7,1]
!p.multi=[0,2,1]
cgloadct,33
cgimage, cgscalevector(vec,1,255)
cgloadct,0, /reverse
cgimage, cgscalevector((abs(shiftfftvec)),1,255)
;cgimage, cgscalevector(imaginary(ffttot),1,255)
;cgimage, cgscalevector(real_part( ifftv),1,255)
;cgimage, cgscalevector(vec,1,255)
;cgimage, cgscalevector(real_part( ifft),1,255)
;cgimage, cgscalevector(real_part( ifft),1,255)
!p.multi=0

im=cgsnapshot(filename="fft_pluto_128_cut_"+STRING(nfile, FORMAT='(I03)'), /jpeg, /nodialog)

endfor


end
