
cgloadct,33
pload,0
fftarg=vx1^2+vx2^2
qtot=fltarr(1)
vx0=total(vx1^2)
qtot(0)=total(vx2^2)/vx0

for nfile=1,nlast do begin
pload,nfile
fftarg=vx1^2+vx2^2
qtot=[qtot, total(vx2^2)/vx0]
k1=findgen(nx1)-nx1/2
k2=findgen(nx2)-nx2/2
fftarg=fftarg-mean(fftarg)
a=alog10(abs(fft(fftarg, /center)))
a=a+1e-6
;display, a, x1=k1,x2=k2,ims=1, title=string(t(nfile)), /hbar

pos = cglayout([1,3] , OXMargin=[5,12], OYMargin=[5,5], XGap=7, YGap=2)
cgimage, a, pos=pos[*,0]
cgimage, cgscalevector(vx1^2+vx2^2,1,254), pos=pos[*,1], /noerase
cgplot, t, qtot, pos=pos[*,2], /noerase

im=cgsnapshot(filename='ftkh'+string(nfile, format='(I04)'), /jpeg, /nodialog)
endfor
end
