nx=400
ny=400
x=findgen(nx)/nx
y=findgen(ny)/ny


xx=rebin( reform (x,nx, 1), nx,ny)
yy=rebin( reform (y, 1,ny), nx,ny)


vx=  sin(2*!PI*xx)*cos(2.01*!PI*yy)
vy=  cos(2*!PI*xx)*sin(2.0001*!PI*yy)
 
yx=pdiv(vx,2, order=1)
xy=pdiv(vy,1, order=1)
 
 vort=yx-xy


qnx=26
qny=31
cvx=congrid(vx, qnx,qny)
cvy=congrid(vy, qnx,qny)
cnx=congrid(x, qnx)
cny=congrid(y, qny)

loadct,33
window,xs=1800,ys=800
;!p.position=0
!p.multi=[0,3,1]
pos=[0.1,0.2,0.9,0.9]
cgcontour, vx, xx,yy,/fill, nlev=80 ;, pos=pos
cgcontour, vy, xx,yy,/fill, nlev=80; , pos=pos
cgcontour, vort, xx,yy,/fill, nlev=80;, pos=pos
imin=min(vort)
imax=max(vort)
cgcolorbar, Position=[pos[0], pos[1]-0.07, pos[2], pos[1]-0.05], range=[imin,imax], format='(G12.1)', annotatecolor='black'
velovect, cvx,cvy,cnx,cny, /overplot, color=cgcolor('white'), pos=pos

end
