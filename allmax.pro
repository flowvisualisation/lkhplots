
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
;      1.85,$
      1.9$
;      1.95$
      ]

sz=size(alldir, /dimensions)
nsim=sz(0)
allrey=fltarr(nsim)
mrey=fltarr(nsim)
trey=fltarr(nsim)
brey=fltarr(nsim)

for i=0,nsim-1 do begin
readcol, 'q'+string(100*alldir[i], format='(I03)')+'/box.dat', time , xmom, ymom, zmom, magx, magy, magz, inten, kinx, kiny, kinz, magenx, mageny, magenz, Rey, Maxw, rmsrho, rmsp, artvisc, shearymom, shearkinen, totkinene, comprwork, thermalfluxx, thermalfluxy, thermalfluxz, normtemptau, Phix, Phiy, Phiz
stress=rey+maxw
allrey[i]=  mean( stress, /nan)
sig      =stddev( stress, /nan)
trey[i]=allrey[i]+sig
brey[i]=allrey[i]-sig

endfor


for i=0,nsim-1 do begin
print, alldir[i], allrey[i]
endfor




qnorm=allrey[7]


top=trey/qnorm
bot=brey/qnorm
allqf=alldir
mea=allrey/qnorm
ymax=max(top)
ymin=min(bot)

xs=800
ys=600
cgdisplay, xs=xs,ys=ys
fname="alphaqhyd"
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet, font=1
charsize=cgdefcharsize()*.6
omega_str='!9W!X'
endif else  begin
set_plot, 'x'
omega_str='!7X!X'
charsize=cgdefcharsize()*.6
endelse

    ;xax=findgen(nplots)/nplots*2
  cgplot,allqf, top,ystyle=2 , /nodata, xrange=[0,2],  yrange=[ymin, ymax], $
    xtitle='Shear rate, q',  $
    ytitle='Normalised turbulent stress'
  cgcolorfill,[allqf,reverse(allqf)],[bot,reverse(top)],/data, color='pink'
  cgloadct,0
  cgplot,allqf, mea,color=0, /overplot


sq=12
x=alog(allqf[0:11])
y=alog(mea[0:11])

result=linfit(x,y)

print, 'slope ', result[1] 
cgplot, (allqf), exp(result[1]*alog(allqf)+result[0] ), /overplot, color='green'



if ( usingps ) then begin
cgps_close, /jpeg,  Width=1100, /nomessage, delete_ps=0
READ_JPEG, fname+'.jpg', a, TRUE=1 & cgimage, a
endif 
endfor
for i=0,nsim-1 do begin
print, alldir[i], allrey[i]
endfor

end

