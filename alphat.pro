
alphat=fltarr(1)
alphat[0]=0
nbeg=1
nend=nlast
pload, 0, /silent, var="vx2"
lx=x1[nx1-1]-x1[0]+dx1[0]
ly=x2[nx2-1]-x2[0]+dx2[0]
lz=x3[nx3-1]-x3[0]+dx3[0]
vol=lx*ly*lz
dv=dx1[0]*dx2[0]*dx3[0]

print, vol, dv
vshear=vx2

openw, 23, "alphat.txt"
for i=nbeg, nend do begin


pload,i, /silent
mx=bx1*bx2
vxbar=total(total(vx1,2),2)/nx2/nx3
vybar=total(total(vx2,2),2)/nx2/nx3
vxbar=rebin(reform(vxbar,nx1,1,1),nx1,nx2,nx3)
vybar=rebin(reform(vybar,nx1,1,1),nx1,nx2,nx3)


;ry=rho*vx1*(vx2-vshear)
ry=rho*(vx1-vxbar)*(vx2-vybar)
gam=5.d/3.d
cs=1.0
pr=rho*cs^2


rytot=total(ry*dv)
ryave=rytot/vol
mxtot=total(mx*dv)
mxave=mxtot/vol
alpha_a=(ryave-mxave)
alphamean=mean(alpha_a)

print, t[i],alphamean
printf,23, t[i],alphamean
alphat=[alphat, alphamean]
endfor

close, 23
cgplot, t, alphat
end
