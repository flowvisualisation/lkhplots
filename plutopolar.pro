
   cgDisplay, WID=1,xs=1100, ys=1100,xpos=1200, ypos=800
nbeg=0
nend=nlast
nfile=0
for nfile=nbeg, nend do begin
pload,nfile
time=t[nfile]
den=rho[*,*,nx3/2]
v1 =vx1[*,*,nx3/2]
v2 =vx2[*,*,nx3/2]
v3 =vx3[*,*,nx3/2]
b1 =bx1[*,*,nx3/2]
b2 =bx2[*,*,nx3/2]
b3 =bx3[*,*,nx3/2]
pr =prs[*,*,nx3/2]

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

bx2by2=b1^2+b2^2

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

titlestr[0,*]='v1'
titlestr[1,*]='v2'
titlestr[2,*]='v3'
titlestr[3,*]='b1'
titlestr[4,*]='b2'
titlestr[5,*]='b3'
titlestr[6,*]='rho'
titlestr[7,*]='rho'
titlestr[8,*]='bx^2+by^2'




   cgLoadCT, 22, /Brewer, /Reverse
   pos = cglayout([3,3] , OXMargin=[5,5], OYMargin=[5,7], XGap=3, YGap=7)
   FOR j=0,8 DO BEGIN
     p = pos[*,j]
	r=cgscalevector( *dataptr(j), 1,254)
	imin=min(*dataptr[j])
	imax=max(*dataptr[j])
     cgImage, r, NoErase=j NE 0, Position=p
  cgcontour,xx#yy, xx,yy , /nodata, /noerase, xtitle='x', pos=p, title=titlestr(j), Charsize=cgDefCharsize()*0.5
     cgColorBar, position=[p[0], p[1]-0.03, p[2], p[1]-0.02],range=[imin-1e-6,imax+1e-6], Charsize=cgDefCharsize()*0.5
   ENDFOR
   cgText, 0.5, 0.96, /Normal,  'MRI time='+string(time), Alignment=0.5, Charsize=cgDefCharsize()*1.25


q=13
help, b1
cv1=congrid(b1, q,q)
cv2=congrid(b2, q,q)
cx=congrid(xx, q)
cy=congrid(yy, q)
;velovect, cv1,cv2, cx,cy, /noerase,/overplot, position=pos , color=cgcolor('white'), c_thick=4

xf=2.0
for i=0.26, xf,0.1 do begin

field_line, b1, b2, xx,yy,  i,0.05, rr,zz
oplot, rr,zz,color=255
;field_line, b1(0), b2(0), x1,x2,  10,i, rr,zz
;oplot, rr,zz,color=255
endfor

endfor

end
