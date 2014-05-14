
pro readplutokh

usingps=0
!p.multi=0
;readcol,'timevar', t,ev,vxmax,vxmin,vymax,vymin,vzmax,vzmin
readcol,'averages.dat',t,dt,rhoe,vx2,vy2,vz2,rhovx2,rhovyE,BxBy

; it,t,dt,ux2m,uy2m,uz2m,uxuym,rhom,rhomin,rhomax,bx2m,by2m,bz2m,bxbym,ndm,ndmin,ndmax
    fname="timeseries"

;ux2m=vxmax^2
;uy2m=vymax^2
;uz2m=vzmax^2
ux2m=vx2
uy2m=vy2
uz2m=vz2

items=['v1','v2']
linestyles=[0,0]
psym=[0,1]
colors=['red', 'blue']


maxall=max([[ux2m], [uy2m]])
minall=min([[ux2m], [uy2m]])
ymin=minall
ymax=maxall
ymin=1e-3
ymax=1e0


fname="timeseries_"
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet
endif else  begin
set_plot, 'x'
endelse



sz=size(vy2,/dimensions)
maxsz=sz-3
maxsz=600
minsz=300
slope=(alog(vy2[maxsz])-alog(vy2[minsz]))/(t[maxsz]-t[minsz])
print, 'slope, ', slope/2
fit=sqrt(uy2m[0])*exp(slope*t/2)
cgplot, t, sqrt(ux2m), color=colors[0], linestyle=linestyles[0], /ylog, yrange=[ymin, ymax], ystyle=1, title="KH"+string(slope/2) ;, xrange=[0,20],
cgplot, t, sqrt(uy2m), /overplot, color=colors[1], linestyle=linestyles[1]
cgplot, t, fit , /overplot ;, color=colors[1], linestyle=linestyles[1]


dat=sqrt(ux2m)

nlines=size(t, /dimensions)
if ( nlines gt 50 ) then begin
;print,"growth rate theory", (alog(fit[nlines])-alog(fit[nlines-10])) / (t[nlines]-t[nlines-10])

;print, "growth rate data", (alog(dat[nlines])-alog(dat[nlines-10])) / (t[nlines]-t[nlines-10])
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




f1name='pluto.ini'
openr,1, f1name
header1=strarr(1)
readf, 1, header1
header1=strarr(1)
readf, 1, header1
junk=""
junk2=""
time=1.0d
nb=0
xb=-1.
xne=600
yne=600
readf, 1, junk, nb, xb, xne , junk2,format='(A7,x,I,x,E10.5,x,I4,x,A10)'
print, junk, nb, xb, xne
print, xne
readf, 1, junk, nb, xb, yne , junk2,format='(A7,x,I,x,E10.5,x,I4,x,A10)'
print, yne
close, 1

f2name='growthratemhd.dat'
OPENW,1,f2name
PRINTF,1, yne*1.0/(xne*1.0), slope/2,FORMAT='(F10.6  ,  F10.6)'
CLOSE,1


end
