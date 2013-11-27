
; take fft in flow  shear wise direction

timearr=fltarr(1)
maxfftvzarr=fltarr(1)
for nfile=0,400 do begin

ll=6
zero=''
nts=strcompress(string(nfile),/remove_all)
lnt=strlen(nts)
for j=1,ll-lnt do zero=zero+'0'
;           fname='ebvd_'+qtag+zero+nts
;f=rf(nfile)
varfile='VAR1'
tag=zero+nts+'.dat'
varfile='fields-'+tag
path='Data/'

if (  file_test(path+varfile)  ne 1 ) then begin
print, varfile+' does not exist, exiting'
break
endif

little_endian=1
   IF (little_endian) THEN $
f=rf(nfile) ELSE $
f=rf(nfile, /swap_endian)

nx=f.s.gn[0]
ny=f.s.gn[2]
velx=reform(f.v(*,0,*,2,1))
fftarr=complexarr(nx,ny)


for i=0,ny-1 do begin
fftarr(*,i) = fft(velx (*,i))
endfor



;; average it in transverse direction
fft_tot=fltarr(ny)

for i=0,ny-1 do begin
fft_tot=fft_Tot+ fftarr(*,i) 
endfor


!p.charsize=1.1
pos=[0.2,0.2,0.9,0.9]
a=(abs(fft_tot[0:nx/2])) 
maxloc=where( a eq max(a))
print, max(alog10(a)), (maxloc)


time=f.s.time
timearr=[timearr, time]
maxfftvzarr=[maxfftvzarr,max(a)]




cgplot, a,/xlog, /ylog, xrange=[1,200], $
   yrange=[1e-4,1e2], $  xstyle=1, $
   position=pos, $
   xtitle="wavenumber, k"
;wait,1
endfor


cgplot, timearr, maxfftvzarr, xtitle="Time", ytitle="max(fft(vz))", /ylog, yrange=[1e-3,max(maxfftvzarr)], ystyle=1

end
