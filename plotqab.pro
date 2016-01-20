
readcol, 'all.dat', q, ab
alpha=ab

cgloadct,33
fname="qab"
cgdisplay, wid=3, xs=800, ys=600
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated,  tt_font='Times', /quiet, font=1
omega_str='!9W!X'
endif else  begin
set_plot, 'x'
omega_str='!7X!X'
endelse



cgplot, q,alpha, xtitle='Shear, q=dln!9W!X/dlnr', ytitle='a/b',  linestyle=0 , yrange=[1,fix(max(alpha))+1], ystyle=0
cgplot, q,alpha, psym=4, /overplot

lines=[1,2]
colors=['black','black']
;cgplot, q,alpha,   linestyle=0, /overplot
qexp=4.5
mystr=string(qexp, format='(F4.1)')
;items=['Kato & Yoshizawa, 1995','2^'+mystr]
;al_legend,  items, lines=lines, color=colors, linsize=0.25
if ( usingps ) then begin
cgps_close, /jpeg,  Width=1100, /nomessage, delete_ps=0
endif else begin
e=1
endelse
endfor


cgloadct,0
READ_JPEG, fname+'.jpg', a, TRUE=1 & cgimage, a

end
