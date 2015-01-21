pload, 46


fftarr=complexarr(nx1,nx2,nx3)

b2=bx1^2+bx2^2+bx3^2
for k=0,nx3-1 do begin


;fftarr(*,*,k)=fft(b2(*,*,k),/center)
fftarr(*,*,k)=fft(b2(*,*,k))

endfor


cgloadct,33
;display, alog10(abs(fftarr(nx1/2,*,*))),ims=[400,1200]
;display, alog10(abs(fftarr(*,nx2/2,*))),ims=[400,1200]


n=1

spawn, 'basename $PWD', dirtag

qq=0
for qq=0,1 do begin


data=reform( alog10(abs(fftarr(0:nx1/2-1,0,*))))
xx1=findgen(nx1/2);-nx1/2
xtit1='k!Dx!N'
varname='kx'+dirtag

if ( qq eq 1) then begin
xx1=findgen(nx2/2);-nx2/2
data=reform( alog10(abs(fftarr(0,0:nx2/2-1,*))))
xtit1='k!Dy!N'
varname='ky'+dirtag
endif

xx2=x3
title='log!D10!N|B!U2!N('+xtit1+',z)|'
ytit1='z'

dispgenps3, n, varname, data, n1,n2,xx1,xx2, title, xtit1, ytit1
 
 endfor


end
