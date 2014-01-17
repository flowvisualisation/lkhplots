
varfile='VAR0'
for i=0,8,2 do begin
varfile='VAR'+strtrim(i,2)
pc_read_var, obj=f0, varfile=varfile, /trimall, /bb
;display, cgscalevector(f0.uu[*,*,0,2],2,254), ims=5
fftu=fft(f0.uu[*,*,0,2])
shiftfft=shift(fftu,(mx-6)/2,(my-6)/2)
abshift=abs(shiftfft)
logabs=alog10(abshift+1e-6)
d=abshift
d=logabs
imin=min(d)
imax=max(d)
r=cgscalevector(d,2,254)

;display, r, ims=10, /hbar
p=[0.1,0.2,0.9,0.9]
cgloadct,0, /reverse
cgimage,r, position=p
cgcontour, r, /nodata, /noerase, position=p
cgcolorbar, Position=[p[0], p[1]-0.08, p[2], p[1]-0.06], range=[imin,imax], format='(E9.2)', charsize=cbarchar

im=cgsnapshot(filename="pencilfft"+String(i,format='(I03)') , /nodialog,/jpeg)
endfor


end
