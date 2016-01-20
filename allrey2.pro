
alldir=[ $
      0.3,$
      0.5,$
      0.7,$
      0.9,$
      1.1,$
      1.3,$
      1.4,$
      1.5,$
      1.6,$
      1.7,$
      1.8,$
      1.9$
      ]

sz=size(alldir, /dimensions)
nsim=sz(0)
allrey=fltarr(nsim)
mrey=fltarr(nsim)

for i=0,nsim-1 do begin
readcol, 'q'+string(10*alldir[i], format='(I02)')+'/box.dat', time , xmom, ymom, zmom, magx, magy, magz, inten, kinx, kiny, kinz, magenx, mageny, magenz, Rey, Maxw, rmsrho, rmsp, artvisc, shearymom, shearkinen, totkinene, comprwork, thermalfluxx, thermalfluxy, thermalfluxz, normtemptau, Phix, Phiy, Phiz
allrey[i]=mean(rey)
endfor


for i=0,nsim-1 do begin
print, alldir[i], allrey[i]
endfor

end
