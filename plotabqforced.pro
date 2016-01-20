
readcol, 'pqshear/all.dat', q, alpha
readcol, 'nirvq/all.dat', q1, alpha1
;alpha=alpha/alphanorm

cgloadct,33
fname="abqforced"
cgdisplay, wid=3, xs=800, ys=600
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated,  tt_font='Times', /quiet, font=1
omega_str='!9W!X'
endif else  begin
set_plot, 'x'
omega_str='!7X!X'
endelse


psym=[-16,-17,-18]

cgloadct,33
items=['Forced','MRI','Kato+ (1995)']
lines=[0,0,0]
colors=['blue','red', 'green']

cgplot, q1,alpha1, xtitle='Shear rate, q= -dln!9W!X/dlnr', ytitle='Aspect ratio of 2D Gaussian fit', psym=psym[0], linestyle=0, xrange=[0,2], color=colors[0], yrange=[1,3], pos=[0.1,0.2,.95,.95]

;cgplot, q, alpha, /overplot, psym=psym[1], color=colors[1]
;cgplot, q,alpha,   linestyle=0, /overplot
qexp=4.5
mystr=string(qexp, format='(F4.1)')
;cgplot, q, (q^qexp)/(1.5^qexp), linestyle=lines[1],color=colors[1], /overplot
al_legend,  items[0:0], lines=lines[0:0], color=colors[0:0], linsize=0.5, psym=psym[0:0], /right
if ( usingps ) then begin
cgps_close, /jpeg,  Width=1100, /nomessage, delete_ps=0
endif else begin
e=1
endelse
endfor


cgloadct,0
READ_JPEG, fname+'.jpg', a, TRUE=1 & cgimage, a

end
