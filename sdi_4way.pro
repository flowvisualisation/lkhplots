
xs=800
ys=900
   cgDisplay, WID=1,xs=xs, ys=ys,xpos=1200, ypos=800


   Device, GET_FONTNAMES=fontNames, SET_FONT='*times*'
   myfont=fontnames[1030]
   print, myfont

nbeg=max( [ 0 , nlast-2] )
nend=nlast
;nend=400
;nbeg=0
nstep=1

for nfile=nbeg, nend, nstep do begin
pload,nfile
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

den=fourway(den)
v1=fourwayaxi(v1)
v2=fourway(v2)
v3=fourway(v3)

br=b1*sin(th2d) + b2*cos(th2d)
bz=b1*cos(th2d) - b2*sin(th2d)

br=fourwayaxi(br)
bz=fourway(bz)
b3=fourway(b3)
xx_l=[-reverse(xx), xx]
yy_l=[-reverse(yy), yy]

for i=0,2*nx1-1 do begin
for j=0,2*nx2-1 do begin
rm=sqrt(xx_l[i]^2+yy_l[j]^2)
if ( rm lt  .36 ) then begin
;print, 'rm', rm
br[i,j]=0
bz[i,j]=0
endif
endfor
endfor

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


   titx='SDI, t='+string(time/2./!DPI, format='(F6.3)')+' orbits'


titlestr[0,*]='v1'
titlestr[1,*]='v2'
titlestr[2,*]='v3'
titlestr[3,*]='b1'
titlestr[4,*]='b2'
titlestr[5,*]='b3'
titlestr[6,*]='rho'
titlestr[7,*]='log density, '+titx
titlestr[8,*]='bx^2+by^2'



spawn, 'basename $PWD', dirtag
tag=string(nfile, format='(I06)')
fname="qstardisk"+tag
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
     cgimage, r, Position=p, /keep_Aspect_Ratio
  cgcontour,xx_l#yy_l, xx_l,yy_l , /nodata, /noerase,  $
    xtitle='Radius, R', $
    ytitle='Altitude, Z', $
    pos=p, title=titlestr(j), Charsize=cgDefCharsize()*1.

     cgColorBar, position=[p[0], p[1]-0.12, p[2], p[1]-0.11],range=[imin-1e-6,imax+1e-6], Charsize=cgDefCharsize()*1.
;vecfield, vr,vz, xx, yy, /overplot, spacing=3.5, color=cgcolor('white')
   ;ENDFOR


bpres=(b1^2+b2^2+b3^2)/2.d
bet=bpres/pr
;stag=bpres/den*(v1^2+v2^2+v3^2)


;cgcontour,bet, xx,yy,pos=p, levels=1, /overplot, color='yellow', thick=2

q=13
;help, b1
cv1=congrid(b1, q,q)
cv2=congrid(b2, q,q)
cx=congrid(xx, q)
cy=congrid(yy, q)
;velovect, cv1,cv2, cx,cy, /noerase,/overplot, position=pos , color=cgcolor('white'), c_thick=4

xf=2.0


pl=0
qbeg=0.4
qend=2.75
field=1
field=0
if ( field eq 1 ) then begin
    for qq=qbeg,qend,0.5 do begin
        myxq=xx_l &  myyq=yy_l & bqx=br & bqy=bz
        field_line_old, bqx, bqy, myxq, myyq, qq, 0.4, xl, yl, method="BS23", tol=1.e-4
        cgplot,xl,yl, /overplot, color='white'  ; overplot on current window
        myxq=xx_l &  myyq=yy_l & bqx=br & bqy=bz
        field_line_old, bqx, bqy, myxq, myyq, -qq, 0.4, xl, yl, method="BS23", tol=1.e-4
        cgplot,xl,yl, /overplot, color='white'  ; overplot on current window
        pl=0
        seed=0
    endfor
endif





if ( usingps ) then begin
cgps_close, /jpeg,  Width=1100, /nomessage
endif

endfor



endfor

cgloadct,33
end
