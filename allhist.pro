
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
       colors=[ $
        'red', 'blue', 'green', 'orange', 'turquoise', 'black' , $
        'red', 'blue', 'green', 'orange', 'turquoise', 'black'  $
       ]

sz=size(alldir, /dimensions)
nsim=sz(0)
allrey=fltarr(nsim)
mrey=fltarr(nsim)

reyhist=ptrarr(12)
treyhist=ptrarr(12)

for i=0,nsim-1 do begin
readcol, 'q'+string(10*alldir[i], format='(I02)')+'/box.dat', time , xmom, ymom, zmom, magx, magy, magz, inten, kinx, kiny, kinz, magenx, mageny, magenz, Rey, Maxw, rmsrho, rmsp, artvisc, shearymom, shearkinen, totkinene, comprwork, thermalfluxx, thermalfluxy, thermalfluxz, normtemptau, Phix, Phiy, Phiz
allrey[i]=mean(maxw-rey)
reyhist[i]=ptr_new(rey)
treyhist[i]=ptr_new(time)
endfor


cgplot, time/2/!DPI, rey, /nodata, /ylog, yrange=[1e-6,1e-1], xtitle='time (orbits)', ytitle='reynolds stress'
for i=0,nsim-1 do begin
cgplot, *treyhist[i]/2./!DPI, smooth(*reyhist[i], 20), /overplot, color=colors[i], linestyle=i
endfor

end
