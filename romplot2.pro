
cgloadct,33
pload,1

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

;cgcontour, den, xx,yy, lev=[0.004, 0.008,0.009,0.01,   1.655,2.135]


sz=size(xx, /dimensions)
nx=sz(0)
x2d=rebin(reform(xx,nx,1),nx,nx)
y2d=rebin(reform(yy,1,nx),nx,nx)
th=atan(x2d/y2d)
vr=v1*cos(th)
vz=v1*sin(th)


cgcontour, th,xx,yy

end
