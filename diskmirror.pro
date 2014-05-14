
cgdisplay, xs=600, ys=1200
sx=511
sy=1023
nstart=0
nstep=100
nend=600

cgloadct,33
cgloadct,3
for myfile=nstart,nend, nstep do begin
print,myfile
pload, out=myfile


 s2u, d,p,vr,vz,vth, br,bz,bth , rho, pr, v1,v2,v3, b1,b2,b3,x1,x2,xa,xb,n1,n2

a=reform(alog10(d(0:sx,0:sy,0)))
;a=reform(b2(0:sx,0:sy,0))
;tot=[ [reverse(reverse(a,1),2),reverse(a,2)],[reverse(a),a]]
;tot=[ [reverse(reverse(a,1),2),reverse(a,2)],[reverse(a),a]]
make4, a, tot
sx1=[-reverse(x1(0:sx)),x1(0:sx)]
sx2=[-reverse(x2(0:sy)),x2(0:sy)]
;sx2=x2(0:sy)

fname="mirror"+string(myfile, format='(I04)')
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet
endif else  begin
set_plot, 'x'
endelse



imin=min(tot)
imax=max(tot)

tot[0,0]=-8.2
tot[0,1]=-0.255
pos=[0.1,0.05,0.9,0.95]
cgcontour, tot,sx1,sx2,$
    title='Time= '+string(time(myfile)/2/!PI, format='(F5.1)'),$
    /fill, nlev=50, $
    pos=pos,$
    xtitle="R", $
    ytitle="Z"

;cgcolorbar, range=[imin, imax],  pos=[0.9,0.1,0.95,0.9]
print, imin
print, imax

xf= x2(n2-1)
xf=19

;bx=b1(0)
make4eqt, br(0:sx,0:sy,0), bx
make4, bz(0:sx,0:sy,0), by
;by=b2(0)

xs=-21
xf=xs+42
for i=xs, xf,2 do begin

field_line, bx, by, sx1,sx2,  i,0.05, rr,zz
oplot, rr,zz,color=cgcolor('white')
endfor




if ( usingps ) then begin
;device,/close
cgps_close, /jpeg,  Width=2048
;set_plot,'x'
endif else begin
;set_plot,'x'
fname2=fname
;im=cgsnapshot(filename=fname2,/nodialog,/jpeg)
endelse

endfor




;wait,1
endfor


end
