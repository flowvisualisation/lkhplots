
spawn, 'basename $PWD', dirtag


ymin=1e-6

case dirtag OF 
'eps2': begin
ymin=1e-6
end
'eps20': begin
ymin=1e-4
end
'eps40':begin
ymin=1e-2
end
end

fname="timehistory"+dirtag
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet
omega_str='!9W!X'
endif else  begin
set_plot, 'x'
omega_str='!7X!X'
endelse



items=['!9e!X=1e-1', $
    '!9e!X=1e-2',$
    '!9e!X=1e-3',$
    '!9e!X=1e-4',$
    '!9e!X=1e-5',$
    '!9e!X=1e-6']
colors=['red','green', 'blue', 'brown', 'orange','pink']
linestyles=[0,0,0,0,0,0]

xmax=0.2
;xmax=1.0
;xmax=1.6
readcol,'eps1e-1/timevar', t,ev,em,vxmax,vxmin,vymax,vymin,vzmax,vzmin,vxvy,bxmax,bxmin,bymax,bymin,bzmax,bzmin,bxby,thmax,thmin,w2,j2,hm

if ( vxmax(0) gt 20) then begin
xmax=0.2
endif else begin
xmax=1.0
endelse

if  (usingps  eq 0) then begin
al_legend, items, color=colors, linestyle=linestyles, $
     linsize=0.25, corners=corners 
     endif

                          ; BOGUS LEGEND---FIRST TIME TO REPORT CORNERS 
          xydims = [corners[2]-corners[0],corners[3]-corners[1]] 
                      ; SAVE WIDTH AND HEIGHT 
          chdim=[!d.x_ch_size/float(!d.x_size),!d.y_ch_size/float(!d.y_size)] 
                      ; DIMENSIONS OF ONE CHARACTER IN NORMALIZED COORDS 
          posleg = [!x.window[1]-chdim[0]-xydims[0] $ 
                      ,!y.window[0]+chdim[1]+xydims[1]] 



bcr=bxmax(0)/.16437451
title='Comparison of parasite !9e!X values for b!DMRI!N/b!Dz!N='+string(bcr,format='(F5.1)')
cgplot, t, vxmax, /ylog, $
    xrange=[0,xmax], $
    xtitle='time, t', $
    yrange=[ymin,1e2], title=title
cgplot, t, vzmax, /overplot, color=colors[0]

readcol,'eps1e-2/timevar', t,ev,em,vxmax,vxmin,vymax,vymin,vzmax,vzmin,vxvy,bxmax,bxmin,bymax,bymin,bzmax,bzmin,bxby,thmax,thmin,w2,j2,hm
cgplot, t, vzmax, /overplot, color=colors[1]
cgplot, t, vxmax, /overplot

readcol,'eps1e-3/timevar', t,ev,em,vxmax,vxmin,vymax,vymin,vzmax,vzmin,vxvy,bxmax,bxmin,bymax,bymin,bzmax,bzmin,bxby,thmax,thmin,w2,j2,hm
cgplot, t, vzmax, /overplot, color=colors[2]
cgplot, t, vxmax, /overplot

readcol,'eps1e-4/timevar', t,ev,em,vxmax,vxmin,vymax,vymin,vzmax,vzmin,vxvy,bxmax,bxmin,bymax,bymin,bzmax,bzmin,bxby,thmax,thmin,w2,j2,hm
cgplot, t, vzmax, /overplot, color=colors[3]
cgplot, t, vxmax, /overplot

readcol,'eps1e-5/timevar', t,ev,em,vxmax,vxmin,vymax,vymin,vzmax,vzmin,vxvy,bxmax,bxmin,bymax,bymin,bzmax,bzmin,bxby,thmax,thmin,w2,j2,hm
cgplot, t, vzmax, /overplot, color=colors[4]
cgplot, t, vxmax, /overplot

readcol,'eps1e-6/timevar', t,ev,em,vxmax,vxmin,vymax,vymin,vzmax,vzmin,vxvy,bxmax,bxmin,bymax,bymin,bzmax,bzmin,bxby,thmax,thmin,w2,j2,hm


cgplot, t, vzmax, /overplot, color=colors[5]
cgplot, t, vxmax, /overplot


;cgplot, t, exp(exp(4.3*vxmax/vxmax(0))*t)*40e-3/exp(0.), /overplot
;cgplot, t, exp(exp(2.8*vxmax/vxmax(0))*t)*9e-3/exp(0.), /overplot
a=vxmax(0)
;cgplot, t, exp(exp(alog(a*2)*vxmax/a)*t)*a*1e-3/exp(0.), /overplot
cgplot, t, exp(2*a*exp(1.5*t/2)*t)*a*1e-3, /overplot, linestyle=2, color='orange'
;cgplot, t, exp(vxmax(0)*2*exp(vxmax/vxmax(0))*t)*vxmax(0)*1e-3/exp(0.), /overplot

    posleg2=[ xmax*.65,ymin*100]
al_legend, items, color=colors, linestyle=linestyles, $
    pos=[.67,.48], $
    linsize=0.25, /normal

if ( usingps ) then begin
;device,/close
cgps_close, /jpeg,  Width=1100, /nomessage
;set_plot,'x'
endif else begin
;set_plot,'x'
fname2=fname
;im=cgsnapshot(filename=fname2,/nodialog,/jpeg)
endelse

endfor



end
