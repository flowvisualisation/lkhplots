pro readsnoopykh


f1name='wavenumber'
openr,1, f1name
readf, 1, wavenumber
close,1

usingps=0
!p.multi=0
readcol,'timevar', t,ev,vxmax,vxmin,vymax,vymin,vzmax,vzmin

; it,t,dt,ux2m,uy2m,uz2m,uxuym,rhom,rhomin,rhomax,bx2m,by2m,bz2m,bxbym,ndm,ndmin,ndmax
    fname="timeseries"

ux2m=vxmax
uy2m=vymax
uz2m=vzmax

items=['v1','v2']
linestyles=[0,0]
psym=[0,1]
colors=['red', 'blue']


maxall=max([[ux2m], [uy2m]])
minall=min([[ux2m], [uy2m]])
ymin=minall
ymax=maxall
ymin=1e-3
;ymax=1e-2


fname="timeseries_"
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet
endif else  begin
set_plot, 'x'
endelse


sz=size(vxmax,/dimensions)
maxsz=60
minsz=30
;minsz=0
;maxsz=sz(0)-3
slope=(alog(vymax[maxsz])-alog(vymax[minsz]))/(t[maxsz]-t[minsz])
print, 'slope, ', slope/2

fit=(uy2m[0])*exp(1.5*t)
cgplot, t, (ux2m), color=colors[0], linestyle=linestyles[0], /ylog, yrange=[ymin, ymax], ystyle=1, title="KH"+string(wavenumber/10.0) , xrange=[0,20]
cgplot, t, (uy2m), /overplot, color=colors[1], linestyle=linestyles[1]
cgplot, t, (uy2m[0])*exp(slope*t) , /overplot ;, color=colors[1], linestyle=linestyles[1]


dat=sqrt(ux2m)

nlines=size(t, /dimensions)
if ( nlines gt 50 ) then begin
print,"growth rate theory", (alog(fit[nlines])-alog(fit[nlines-10])) / (t[nlines]-t[nlines-10])

print, "growth rate data", (alog(dat[nlines])-alog(dat[nlines-10])) / (t[nlines]-t[nlines-10])
endif

rho=1.d0
omega=1.d0
va=0.16437451
lfast=sqrt(15.d0/16.d0) *2.d0 *!DPI  /omega/sqrt(rho) 
print, '1 lfast', 1/lfast

	al_legend, items, colors=colors, linestyle=linestyles, charsize=1.4, /right





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




f2name='growthratemhd.dat'
OPENW,1,f2name
PRINTF,1, wavenumber/10., slope,FORMAT='(F10.6  ,  F10.6)'
CLOSE,1






end
