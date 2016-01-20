
nfile=23
pload, nfile

den=rho
vrad=vx1
vtheta=vx2
vz=vx3
pr=prs
bx=bx1
by=bx2
bz=bx3

rr=rebin(reform(x1,nx1,1),nx1,nx2)
theta2=rebin(reform(x2,1,nx2),nx1,nx2)



xx=x1
yy=!PI/2-x2
polar, rr, xx,yy

xx=x1
yy=!PI/2-x2
polar, theta2, xx,yy

xx=x1
yy=!PI/2-x2
polar, den, xx,yy


xx=x1
yy=!PI/2-x2
polar, vrad, xx,yy

xx=x1
yy=!PI/2-x2
polar, vtheta, xx,yy


vrcyl = vrad*sin(theta2)+vth*cos(theta2)
vz    = vrad*sin(theta2)+vth*cos(theta2)


xx=x1
yy=!PI/2-x2
polar, vphi, xx,yy

xx=x1
yy=!PI/2-x2
polar, pr, xx,yy

xx=x1
yy=!PI/2-x2
polar, bx, xx,yy

xx=x1
yy=!PI/2-x2
polar, by, xx,yy

xx=x1
yy=!PI/2-x2
polar, bz, xx,yy

end
