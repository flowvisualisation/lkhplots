pload,0

psdarr=fltarr(nlast,nx3/2)
for nfile=1,nlast do begin
pload, nfile, /silent
rhoave=total(total(rho,1),1)
vx1ave=total(total(vx1,1),1)
vx2ave=total(total(vx2,1),1)
vx3ave=total(total(vx3,1),1)

absfft=abs(fft(vx1ave))
shiftnx3=shift(absfft,nx3/2)
help, shiftnx3, nx3
sz=size(shiftnx3,/dimensions)
psd=shiftnx3[ sz/2:sz-1]
cgplot, psd, /xlog, /ylog, xrange=[1,64], xstyle=1
psdarr=[[psdarr],[psd]]
endfor
end
