
q=qarr
alpha=fltarr(12)
for i=0,7 do begin
a=*bptr[i]
alpha[i]=mean(a[50:60])
endfor
alpha=alpha/0.01218

fname="alphaq"
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet, font=1
omega_str='!9W!X'
endif else  begin
set_plot, 'x'
omega_str='!7X!X'
endelse



cgplot, q,alpha, xtitle='Shear, q=dln!9W!X/dlnr', ytitle='Normalized Turbulent MHD Stress, T!Dr!9f!X!N/P', psym=4, linestyle=0

lines=[1,2]
colors=['black','black']
;cgplot, q,alpha,   linestyle=0, /overplot
cgplot, q, (q^8)/(1.5^8),     linestyle=lines[0],color=colors[0], /overplot
cgplot, q, (q^2.5)/(1.5^2.5), linestyle=lines[1],color=colors[1], /overplot
items=['Kato & Yoshiwaza, 1995','2^2.5']
al_legend,  items, lines=lines, color=colors
if ( usingps ) then begin
cgps_close, /jpeg,  Width=1100, /nomessage, delete_ps=0
endif else begin
e=1
endelse
endfor

end
