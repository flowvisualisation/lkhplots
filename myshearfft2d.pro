;pro myshearfft2d, vec, ffttot, time,x2d, nx1,nx2, x1,x2, q
nfile=11
pload,nfile

vec=reform(bx1(*,*,nx3/2))
q=1.9d
time=t(nfile)

ffttot=complexarr(nx1,nx2)
x2d=rebin(reform(nx1,1),nx1,nx2)

; shear parameter
; orbital frequency
omega=1.0
; dt is difference in time between this, and the nearest shear periodic point
time=time
;dt=time mod  0.6666666666666666666666d
; 1/q is nearest shearing periodic point
dt=time mod  1.0d/q
; length of y domain
Ly=x2[nx2-1]+x2[0]
Ly=2
qomegat_Ly=q*omega*dt/Ly
print, dt, time, format='(F12.6)'

print, qomegat_Ly

jimag=complex(0.0d,1.0d)

ny=[dindgen(nx2/2), -nx2/2+dindgen(nx2/2)]
ny2d=rebin(reform(ny,1,nx2),nx1,nx2)


cfft1=fft(vec,dimension=2, /double)
yuc=exp ( -jimag * qomegat_Ly *  2.0d *!DPI * ny2d * x2d ) 
cfft1shift=cfft1*yuc
help, ny2d, x2d, exp( -jimag * qomegat_Ly *  2.0d *!DPI * ny2d * x2d ) 
help, cfft1
ffttot=fft(cfft1shift, dimension=1, /double)

pos=cglayout([2,2] , OXMargin=[5,12], OYMargin=[5,5], XGap=0, YGap=2)
cgdisplay, xs=800,ys=800

datptr=ptrarr(12)
datptr[0]=ptr_new(alog10(abs((cfft1))))
datptr[1]=ptr_new(alog10(abs(cfft1shift)))
datptr[2]=ptr_new(alog10(abs(ffttot)+1e-6))
datptr[3]=ptr_new(real_part(yuc))

for i=0,3 do begin
cgimage, *datptr[i], pos=pos[*,i], /noerase
endfor



end
