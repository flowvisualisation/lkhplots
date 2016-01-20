ymax=2.3
ymax=4.3

xs=800
ys=600
cgdisplay, xs=xs,ys=ys
top=allqf
bot=top
mea=top

for i=0,nq-1 do begin
a=(*aptr[i])[1:nplots-1]
b=(*bptr[i])[1:nplots-1]
top[i]=max (a/b,/nan)
bot[i]=min (a/b,/nan)
mea[i]=mean(a/b,/nan)



endfor


fname="timeffthist"
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

    xax=findgen(nplots)/nplots*2
  cgplot,allqf, top,ystyle=2 , /nodata, xrange=[0,2], yrange=[1,ymax], $
    pos=[.13,.15,.87,.85],$
    xtitle='Shear rate, q',  $
    ytitle='Aspect ratio of Lorentzian 2d fit'
  cgcolorfill,[allqf,reverse(allqf)],[bot,reverse(top)],/data, color='pink'
  cgloadct,0
  cgplot,allqf, mea,color=0, /overplot





if ( usingps ) then begin
cgps_close, /jpeg,  Width=1100, /nomessage, delete_ps=0
READ_JPEG, fname+'.jpg', a, TRUE=1 & cgimage, a
endif 
endfor






end
