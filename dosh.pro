nfile=11
pload,nfile

vec=reform(bx1(*,*,nx3/2))
q=1.9d
time=t(nfile)

ffttot=complexarr(nx1,nx2)
x2d=rebin(reform(nx1,1),nx1,nx2)
myshearfft2d, vec, ffttot, time,x2d, nx1,nx2, x1, x2, q

myf=shift(ffttot,nx1/2,nx2/2)
cgloadct,33
 ;display, alog10(abs(myf)+1e-6), ims=4

pos=cglayout([2,2] , OXMargin=[5,12], OYMargin=[5,5], XGap=0, YGap=2)
;cgdisplay, xs=800,ys=800

nvec=real_part(fft(ffttot))
datptr=ptrarr(12)
datptr[0]=ptr_new(vec)
datptr[1]=ptr_new(vec)
datptr[2]=ptr_new(nvec)
datptr[3]=ptr_new(nvec)

for i=0,3 do begin
;cgimage, *datptr[i], pos=pos[*,i], /noerase
endfor

; display, alog10(abs(fft(vec, /center))+1e-6), ims=4


end




