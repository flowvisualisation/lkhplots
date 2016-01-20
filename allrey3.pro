
;
; plots the normalised stresses with errors
;

alldir=[ $
;      0.1,$
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
trey=allrey
brey=allrey
mrey=fltarr(nsim)

for i=0,nsim-1 do begin
readcol, 'q'+string(10*alldir[i], format='(I02)')+'/box.dat', time , xmom, ymom, zmom, magx, magy, magz, inten, kinx, kiny, kinz, magenx, mageny, magenz, Rey, Maxw, rmsrho, rmsp, artvisc, shearymom, shearkinen, totkinene, comprwork, thermalfluxx, thermalfluxy, thermalfluxz, normtemptau, Phix, Phiy, Phiz
allrey[i]=mean(rey, /nan)
sig=stddev(rey, /nan)
;trey[i]=max(rey, /nan)
;brey[i]=min(rey, /nan)
trey[i]=allrey[i]+sig
brey[i]=allrey[i]-sig
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
  cgcolorfill,[allqf,reverse(allqf)],[bot,reverse(top)],/data, color='grey'
  cgloadct,0
  cgplot,allqf, mea,color=0, /overplot

if ( usingps ) then begin
cgps_close, /jpeg,  Width=1100, /nomessage, delete_ps=0
READ_JPEG, fname+'.jpg', a, TRUE=1 & cgimage, a
endif 
endfor
for i=0,nsim-1 do begin
print, alldir[i], allrey[i]
endfor

print, 'q mean-sig mean +1sig'
for i=0,nsim-1 do begin

print, allqf[i] , bot[i], mea[i], top[i]
endfor


end
