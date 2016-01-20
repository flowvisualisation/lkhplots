pload,0, /nodata, /silent
xs=1100
ys=xs
   cgDisplay, WID=1,xs=xs, ys=ys,xpos=1200, ypos=800


   Device, GET_FONTNAMES=fontNames, SET_FONT='*times*'
   myfont=fontnames[1030]
   print, myfont

nbeg=getunplotted()
nend=nlast
;nbeg=2
;nend=2
for nfile=nbeg, nend do begin
pload,nfile, /silent
time=t[nfile]
den=rho[*,*]
v1 =vx1[*,*]
v2 =vx2[*,*]
v3 =vx3[*,*]
b1 =bx1[*,*]
b2 =bx2[*,*]
b3 =bx3[*,*]
pr =prs[*,*]

x2d=rebin(reform(x1,nx1,1),nx1,nx2)
th2d=rebin(reform(x2,1,nx2),nx1,nx2)
r2d=rebin(reform(x1,nx1,1),nx1,nx2)
y2d=rebin(reform(x2,1,nx2),nx1,nx2)
   r  = x2d;
   r2 = r*r;
   r3 = r2*r;
     


xx=x1
yy=!PI/2-x2
polar, th2d, xx,yy
xx=x1
yy=!PI/2-x2
polar, r2d, xx,yy
betap=120.5
kappa=1.
Bmag = sqrt(2.0*kappa/betap);
bxback= 2.0*Bmag*cos(y2d)/r3;
byback=   Bmag*sin(y2d)/r3;
;bx1=bx1+bxback
;bx2=bx2+byback
bx2by2=b1^2+b2^2
b1=bx1
b2=bx2
xx=x1
yy=!PI/2-x2
polar, den, xx,yy
xx=x1
yy=!PI/2-x2
polar, v1, xx,yy
xx=x1
yy=!PI/2-x2
polar, v2, xx,yy
xx=x1
yy=!PI/2-x2
polar, v3, xx,yy
xx=x1
yy=!PI/2-x2
polar, b1, xx,yy
xx=x1
yy=!PI/2-x2
polar, b2, xx,yy
xx=x1
yy=!PI/2-x2
polar, b3, xx,yy
xx=x1
yy=!PI/2-x2
polar, pr, xx,yy

sz=size( v1, /dimensions)
qx=sz[0]
qy=sz[1]
for i=0,qx-1 do begin
for j=0,qy-1 do begin
;print, ' gm ', i,j, r2d[i,j] , x1[nx1-1] 
;if ( r2d[i,j] ge x1[nx1-1]) then begin
num=sqrt((1.*i)^2+(1.*j)^2)
if ( num  ge qx ) then begin
v1[i,j]=0
v2[i,j]=0
;print, ' gm bg ', i,j, v1[i,j]
endif
endfor
endfor

vr=v1*cos(th2d)
vz=v1*sin(th2d)
print, 'max, min, v1', max(v1), min(v1)
print, 'max, min, v2', max(v2), min(v2)
print, 'max, min, v3', max(v3), min(v3)
print, 'max, min, b1', max(b1), min(b1)
print, 'max, min, b2', max(b2), min(b2)
print, 'max, min, b3', max(b3), min(b3)

dataptr=ptrarr(12)

titlestr=strarr(12,30)
dataptr[0]=ptr_new(v1)
dataptr[1]=ptr_new(v2)
dataptr[2]=ptr_new(v3)
dataptr[3]=ptr_new(b1)
dataptr[4]=ptr_new(b2)
dataptr[5]=ptr_new(b3)
dataptr[6]=ptr_new(pr)
dataptr[7]=ptr_new(alog(den))
dataptr[8]=ptr_new(alog(bx2by2))

   timestr=' time='+string(time/2./!DPI, format='(F12.3)')
titlestr[0,*]='v1'
titlestr[1,*]='v2'
titlestr[2,*]='v3'
titlestr[3,*]='b1'
titlestr[4,*]='b2'
titlestr[5,*]='b3'
titlestr[6,*]='rho'
titlestr[7,*]='log!D10!N density, !9r!X, '+timestr
titlestr[8,*]='bx^2+by^2'



spawn, 'basename $PWD', dirtag
tag=string(nfile, format='(I06)')
fname="stardisk"+tag
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet, font=1
omega_str='!9W!X'
endif else  begin
set_plot, 'x'
!p.font=0
DEVICE, SET_FONT = myfont

omega_str='!7X!X'
endelse




   cgloadct, 33
   pos = cglayout([1,1] , OXMargin=[10,5], OYMargin=[19,7], XGap=3, YGap=7)
   ;FOR j=0,8 DO BEGIN
   j=0
     p = pos[*,j]
     j=7
     dat=alog10(den)
     ;dat=v3
     ;dat=pr*2./(b1^2+b2^2+b3^2)
	r=cgscalevector( dat, 1,254)
	imin=min(dat)
	imax=max(dat)
     cgImage, r, Position=p
  cgcontour,xx#yy, xx,yy , /nodata, /noerase,  $
    xtitle='Radius, R', $
    ytitle='Altitude, Z', $
    pos=p, title=titlestr(j), Charsize=cgDefCharsize()*1.

     cgColorBar, position=[p[0], p[1]-0.12, p[2], p[1]-0.11],range=[imin-1e-6,imax+1e-6], Charsize=cgDefCharsize()*1.
vecfield, vr,vz, xx, yy, /overplot, spacing=9.5, color=cgcolor('white')
   ;ENDFOR


bpres=(b1^2+b2^2+b3^2)/2.d
bet=bpres/pr
;stag=bpres/den*(v1^2+v2^2+v3^2)


cgcontour,bet, xx,yy,pos=p, levels=1, /overplot, color='yellow', thick=2

q=13
help, b1
cv1=congrid(b1, q,q)
cv2=congrid(b2, q,q)
cx=congrid(xx, q)
cy=congrid(yy, q)
;velovect, cv1,cv2, cx,cy, /noerase,/overplot, position=pos , color=cgcolor('white'), c_thick=4

xf=2.0
;for i=1.26, xf,0.1 do begin

;field_line, b1, b2, xx,yy,  i,0.05, rr,zz
;oplot, rr,zz,color=255
;field_line, b1(0), b2(0), x1,x2,  10,i, rr,zz
;oplot, rr,zz,color=255
;endfor

 for qq=x1[1],5,0.25 do begin
seed=[qq,!PI*9.9/20.]
myxq=x1
myyq=x2
br=bx1
bth=bx2/sqrt(xpos^2+ypos^2)
field_line, br,bth,0,myxq,myyq,0,seed=seed ,pl, method="BS23", tol=1.e-6
oplot, pl[0,*]*sin(pl[1,*]), pl[0,*]*cos(pl[1,*]), color=cgcolor('black')
pl=0
seed=0
endfor





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



endfor

cgloadct,33
end
