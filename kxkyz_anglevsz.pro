
cgdisplay, xs=800, ys=800

;backup=fftarr
;fftarr=fftarr[182:201,182:201,*]

anglevz=dblarr( nx3)
maj=dblarr(nx3)
min=dblarr(nx3)

cgloadct,33
for i=0, nx3-1 do begin


fftarrz=reform((abs(fftarr(*,*,i))))

sfft=shift(fftarrz, nx1/2, nx2/2)
d=alog10(sfft)


gft=gauss2dfit(d, aa, /tilt)

k1=findgen(nx1)-nx1/2
k2=x2
pos=[0.1,0.1,0.9,0.9]
cgimage, d, pos=pos
ttag='angle= '+string(aa[6]*!RADEG, format='(F8.1)')+', z='+string(x3[i]/sqrt(2), format='(F6.2)')
cgcontour, d,k1,k2, /nodata,/noerase,  pos=pos, title=ttag
imin=min(d)
imax=max(d)
cgcolorbar, range=[imin, imax], pos=[pos[0], pos[1]-0.05, pos[2], pos[1]-0.04]


cgcontour, gft, k1,k2, pos=pos, /noerase, /overplot, color='black'
print, 'gauss',aa[2],aa[3],aa[6]*!RADEG

im=cgsnapshot(filename="fft"+string(i, format='(I06)'), /jpeg, /nodialog)
anglevz[i]=aa[6]
maj[i]=aa[2]
min[i]=aa[3]




endfor


end
