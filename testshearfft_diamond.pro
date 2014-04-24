

seed=0
nx=100
ny=100
data=randomn(seed,nx,ny)


f=fft(data)


mask=fltarr(nx,ny)
mask(*,*)=1
mask(  nx/3:2*nx/3 ,  * )=0
mask(  * ,  ny/3:2*ny/3 )=0



mf=mask*f


datfil=real_part(fft(mf,-1))


for i=0,20 do begin
mytime=2.0d + i*0.1d
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

x1=findgen(nx)/nx-0.5
ffttot=complexarr(nx,ny)
 shearfft2d, datfil, ffttot, qomegat_Ly,x2d, nx,ny, x1


cgloadct,33
display, abs(shift(ffttot,nx/2,ny/2)), ims=6

wait,1
endfor
end
