
readcol,"allrey.txt" , allqf,  bot, mea, top
readcol,"anisotropy.txt" , allqf1,  bot1, mea1, top1

for i=0, 10 do begin
print, allqf[i], mea[i], mea1[i]
endfor


usingps=0
spawn, 'basename $PWD', dirtag
fname="stressabq"+dirtag
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



color='grey'


pos=cglayout([1,2], ygap=0, oymargin=[9,1])

ymax=max(top)
ymin=min(bot)
  cgplot,allqf, top,ystyle=2 , /nodata, xrange=[0,2],  yrange=[ymin, ymax], $
    xtickformat='(A1)',$
    ;xtitle='Shear rate, q',  $
    ytitle='Normalised stress', pos=pos[*,0]
  cgcolorfill,[allqf,reverse(allqf)],[bot,reverse(top)],/data, color=color
  cgloadct,0
  cgplot,allqf, mea,color=0, /overplot


x=alog(allqf[2:11])
y=alog(mea[2:11])

result=linfit(x,y)

cgplot, (allqf), exp(result[1]*alog(allqf)+result[0] ), /overplot, color='green'

ymax=max(top1)
ymin=min(bot1)
  cgplot,allqf1, top1,ystyle=2 , /nodata, xrange=[0,2],  yrange=[ymin, ymax], $
    xtitle='Shear rate, q',  $
    ytitle='Anisotropy', pos=pos[*,1], /noerase
  cgcolorfill,[allqf1,reverse(allqf1)],[bot1,reverse(top1)],/data, color=color
  cgloadct,0
  cgplot,allqf1, mea1,color=0, /overplot



if ( usingps ) then begin
cgps_close, /jpeg,  Width=1100, /nomessage, delete_ps=0
READ_JPEG, fname+'.jpg', a, TRUE=1 & cgimage, a
endif 
endfor


  end
