cgdisplay, xs=800,ys=800


usingps=0
!p.multi=0
readcol,'timevar_good', t,ev,em,vxmax,vxmin,vymax,vymin,vzmax,vzmin,vxvy,bxmax,bxmin,bymax,bymin,bzmax,bzmin,bxby,thmax,thmin,w2,j2,hm

; it,t,dt,ux2m,uy2m,uz2m,uxuym,rhom,rhomin,rhomax,bx2m,by2m,bz2m,bxbym,ndm,ndmin,ndmax
    fname="timeseries"

ux2m=vxmax^2
uy2m=vymax^2
uz2m=vzmax^2
bx2m=bxmax^2
by2m=bymax^2
bz2m=bzmax^2

items=['v!Dx!N','v!Dy!N', 'v!Dz!N', 'b!Dx!N', 'b!Dy!N', 'b!Dz!N','e!U0.75t!N' ]
linestyles=[0,0,0,3,2,2,1]
psym=[0,1,2,3,4,5,6]
colors=['red', 'blue', 'green', 'orange', 'turquoise', 'purple', 'black']


maxall=max([ [sqrt(ux2m)] , [sqrt(uy2m)], [sqrt(uz2m)] , [sqrt(bx2m)] , [sqrt(by2m)] ,[sqrt(bz2m)]   ])
minall=min([ [sqrt(ux2m)] , [sqrt(uy2m)], [sqrt(uz2m)] , [sqrt(bx2m)] , [sqrt(by2m)] ,[sqrt(bz2m)]   ])
ymin=1e-6
ymax=3e2
ymax=maxall
;ymax=2e3


fname="timeseries_"
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet
endif else  begin
set_plot, 'x'
endelse



cgplot, t, sqrt(ux2m), color=colors[0], linestyle=linestyles[0], $
    /ylog, $
    yrange=[ymin, ymax], $
    ystyle=1,$
    ;title="MRI + PI", $
    xtitle="time, !9W!X t", $
     ytitle='v!Dx,y,z!N, B!Dx,y,z!N' ,$
      ;xrange=[0,18] ,$
     pos=[0.2,0.2,0.98,0.98]
cgplot, t, sqrt(uy2m), /overplot, color=colors[1], linestyle=linestyles[1]
cgplot, t, sqrt(uz2m), /overplot, color=colors[2], linestyle=linestyles[2]
cgplot, t, sqrt(bx2m), /overplot, color=colors[3], linestyle=linestyles[3]
cgplot, t, sqrt(by2m), /overplot, color=colors[4], linestyle=linestyles[4]
cgplot, t, sqrt(bz2m), /overplot, color=colors[5], linestyle=linestyles[5]
cgplot, t, sqrt(ux2m[0])*exp(0.75*t), /overplot, color=colors[6], linestyle=linestyles[6]
cgplot, t, abs(bzmax-0.1643751), /overplot, color=colors[5], linestyle=linestyles[5]


fit=sqrt(ux2m[0])*exp(0.75*t)
dat=sqrt(ux2m)

nlines=size(t, /dimensions)
if ( nlines gt 80 ) then begin
print,"growth rate theory", (alog(fit[nlines])-alog(fit[nlines-10])) / (t[nlines]-t[nlines-10])

print, "growth rate data", (alog(dat[nlines])-alog(dat[nlines-10])) / (t[nlines]-t[nlines-10])
endif

rho=1.d0
omega=1.d0
va=0.16437451
lfast=sqrt(15.d0/16.d0) *2.d0 *!DPI  /omega/sqrt(rho) 
print, '1 lfast', 1/lfast

	al_legend, items, colors=colors, linestyle=linestyles, charsize=1.4,pos=[0.06,1e-3] , linsize=0.5

print, 'Saturation level', maxall




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
