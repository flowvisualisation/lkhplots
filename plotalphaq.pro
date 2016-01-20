
readcol, 'nirvqmri/alphaall.dat', q, alpha
readcol, 'nirvq/alphaall.dat', q1, alpha1
alphanorm=alpha[3]
alphanorm=alpha[8]
;alphanorm=alpha[10]
alphanorm=alpha[6]
alpha=alpha/alphanorm

cgloadct,33
fname="alphaq"
cgdisplay, wid=3, xs=800, ys=600
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated,  tt_font='Times', /quiet, font=1
omega_str='!9W!X'
endif else  begin
set_plot, 'x'
omega_str='!7X!X'
endelse



cgplot, q,alpha, xtitle='Shear, q=dln!9W!X/dlnr', ytitle='Normalized Turbulent MHD Stress, T!Dr!9f!X!N/P', psym=4, linestyle=0, xrange=[0,2]

cgplot, q1, alpha1, /overplot
lines=[1,2]
colors=['black','black']
;cgplot, q,alpha,   linestyle=0, /overplot
qexp=4.5
mystr=string(qexp, format='(F4.1)')
cgplot, q, (q^8)/(1.5^8),     linestyle=lines[0],color=colors[0], /overplot
;cgplot, q, (q^qexp)/(1.5^qexp), linestyle=lines[1],color=colors[1], /overplot
items=['Kato & Yoshizawa, 1995','q^'+mystr]
al_legend,  items[0], lines=lines[0], color=colors[0], linsize=0.25
if ( usingps ) then begin
cgps_close, /jpeg,  Width=1100, /nomessage, delete_ps=0
endif else begin
e=1
endelse
endfor


cgloadct,0
READ_JPEG, fname+'.jpg', a, TRUE=1 & cgimage, a

end
