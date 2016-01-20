
pload,0

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

cgcontour, den, xx,yy, lev=[0.004, 0.008,0.009,0.01,   1.655,2.135]

end
