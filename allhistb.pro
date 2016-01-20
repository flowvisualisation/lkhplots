
nsim=12
ls=findgen(nsim)
charsize=cgdefcharsize()


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

items=strarr(nsim)
for i=0,nsim-1 do begin

items[i]='q='+string(alldir[i], format='(F4.1)')
endfor
       cl=[ $
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
reyhist[i]=ptr_new(maxw)
treyhist[i]=ptr_new(time)
endfor


cgplot, time/2/!DPI, rey, /nodata, /ylog, xrange=[0,20], yrange=[1e-6,1], xtitle='time (orbits)', ytitle='Maxwell stress'
for i=0,nsim-1 do begin
cgplot, *treyhist[i]/2./!DPI, smooth(*reyhist[i], 20), /overplot, color=cl[i], linestyle=i
endfor



al_legend, items, lines=ls, colors=cl,  $
    ;/bottom, $
    pos=[10,5e-3], $
     charsize=charsize, linsize=.25


end
