
cgdisplay, xs=800,ys=400
r=h5_parse("myfile3.h5", /read)    


h1=r.h1._DATA
h2=r.h2._DATA

sz=size(h1, /dimensions)
x1=findgen(sz(0))/sz(0)*150

fname="height"
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet
omega_str='!9W!X'
pistr='!9p!X'
!p.charsize=2.0
charsize=cgdefcharsize()
endif else  begin
set_plot, 'x'
omega_str='!7X!X'
pistr='!7q!X'
!p.charsize=1.5
charsize=cgdefcharsize()
endelse


cgplot, 2*x1,h1, xrange=[20,140], yrange=[-4,4], xtitle="Orbital time", pos=[.1,.24,.9,.9], ytitle='z'
 cgplot, 2*x1,h2, /overplot


if ( usingps ) then begin
;device,/close
cgps_close, /jpeg,  Width=1900, /nomessage
;set_plot,'x'
endif else begin
;set_plot,'x'
fname2=fname
;im=cgsnapshot(filename=fname2,/nodialog,/jpeg)
endelse

endfor
end
