cgdisplay, xs=800,ys=800

q=1.5d
;q=1.4d
;q=1.2d


spawn, 'basename $PWD', a
dirname=a
dirtag='znf'

b=strmid(dirname,3,1)
q=1.+0.1*uint(b[0])



usingps=0
!p.multi=0
readcol,'timevar', t,ev,em,vxvy,bxby,vxave,vyave,vzave,bxave,byave,bzave,x1KE,x2KE,x3KE,x1ME,x2ME,x3ME

; it,t,dt,ux2m,uy2m,uz2m,uxuym,rhom,rhomin,rhomax,bx2m,by2m,bz2m,bxbym,ndm,ndmin,ndmax
    fname="timeseries"

ux2m=vxave
uy2m=vyave
uz2m=vzave
bx2m=bxave
by2m=byave
bz2m=bzave

items=['v!Dx!N','v!Dy!N', 'v!Dz!N', 'B!Dx!N', 'B!Dy!N', 'B!Dz!N','exp('+string(q,format='(F3.1)')+'t/2)' ]
linestyles=[0,0,0,3,2,2,1]
psym=[0,1,2,3,4,5,6]
colors=['red', 'blue', 'green', 'orange', 'turquoise', 'purple', 'black']


maxall=max([ [sqrt(ux2m)] , [sqrt(uy2m)], [sqrt(uz2m)] , [sqrt(bx2m)] , [sqrt(by2m)] ,[sqrt(bz2m)]   ])
minall=min([ [sqrt(ux2m)] , [sqrt(uy2m)], [sqrt(uz2m)] , [sqrt(bx2m)] , [sqrt(by2m)] ,[sqrt(bz2m)]   ])
ymin=1e-6
ymax=3e2
ymax=maxall
;ymax=2e3

spawn, 'basename $PWD', dirtag
fname="timehistory"+dirtag
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet
omega_str='!9W!X'
endif else  begin
set_plot, 'x'
omega_str='!7X!X'
endelse


charsize=cgdefcharsize()

cgplot, t, sqrt(ux2m), color=colors[0], linestyle=linestyles[0], $
    /ylog, $
    ;xrange=[6.0, 6.7], $
    yrange=[ymin, ymax], $
    ystyle=1,$
    charsize=charsize,$
    ;title="MRI + PI", $
    xtitle="time,"+omega_str+" t", $
     ytitle='v!Dx,y,z!N, B!Dx,y,z!N' ,$
      ;xrange=[0,18] ,$
     pos=[0.15,0.12,0.98,0.98]
cgplot, t, sqrt(uy2m), /overplot, color=colors[1], linestyle=linestyles[1]
cgplot, t, sqrt(uz2m), /overplot, color=colors[2], linestyle=linestyles[2]
cgplot, t, sqrt(bx2m), /overplot, color=colors[3], linestyle=linestyles[3]
cgplot, t, sqrt(by2m), /overplot, color=colors[4], linestyle=linestyles[4]
cgplot, t, sqrt(bz2m), /overplot, color=colors[5], linestyle=linestyles[5]
cgplot, t, sqrt(ux2m[0])*exp(q*t/2), /overplot, color=colors[6], linestyle=linestyles[6]
cgplot, t, abs(bzave-0.1643751), /overplot, color=colors[5], linestyle=linestyles[5]


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

    al_legend, items, colors=colors, linestyle=linestyles, $
    charsize=cgdefcharsize(),$
    ;pos=[0.06,1e-3] , $
    /right, $
    linsize=0.5

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
