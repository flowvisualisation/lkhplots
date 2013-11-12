
; take fft in flow  shear wise direction

for nfile=0,3 do begin
f=rf(nfile)
nx=f.s.gn[0]
ny=f.s.gn[2]
velx=reform(f.v(*,0,*,0,0))
fftarr=complexarr(nx,ny)


for i=0,ny-1 do begin
fftarr(*,i) = fft(velx (*,i))
endfor



;; average it in transverse direction
fft_tot=fltarr(ny)

for i=0,ny-1 do begin
fft_tot=fft_Tot+ fftarr(*,i) 
endfor


pos=[0.1,0.2,0.9,0.9]
a=alog10(abs(fft_tot[0:nx/2])) 
print, max(a)
cgplot, a,/xlog, xrange=[1,200], xstyle=1, $
   position=pos, $
   xtitle="wavenumber, k"
wait,1
endfor

end
