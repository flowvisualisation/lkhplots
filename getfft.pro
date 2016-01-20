
getlast, nfile

r=h5_read( nfile, /v, /remap)

vx=reform(r.v[0,*,*,0])

a=congrid(logfft(vx),480,480)


nx=480
y=smooth(a[*,nx/2], 10)
kx=findgen(nx)-nx/2 

yfit=mpfitpeak(kx, y,aa, /lorentzian)


cgplot, kx, y
cgplot, kx, yfit, /overplot

end
