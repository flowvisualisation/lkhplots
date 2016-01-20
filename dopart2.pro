
pro dopart2, model
;xs=380
;ys=720
xs=480
ys=950
xs=550
ys=1100
cgdisplay, xs=xs,ys=ys
cgloadct,33
r=h5_read( model, /b,/v,/rho,/p) 
grd_ctl, model=model, p 
;display, /polar, x1=p.x, x2=!PI/2-p.y, ims=[xs,ys],/hbar,  transpose(alog10(r.rho(*,*)))
dat=alog10(r.rho)
var='rho'
dat2=transpose(dat)
xx=p.x
yy=!PI/2-p.y
polar, dat2, xx,yy, sample=5

 ;display,/polar,x1=p.x,x2=!PI/2-p.y,/hbar,ims=[800,1200], transpose(dat)
pos=[0.1,0.1,0.9,.96]
scl=cgscalevector(dat2,1,255)
cgimage, scl, pos=pos;, /noerase
cgcontour, dat2,xx,yy, /noerase,/nodata, pos=pos, title=var+', t='+string(model)
imin=min(dat2)
imax=max(dat2)
cgcolorbar, range=[imin,imax], pos=[pos[0],pos[1]-0.06,pos[2],pos[1]-0.05 ]



q=h5_parse("particles.h5", /read)   

sz=size(q.time._DATA, /dimensions)

i=sz-1

xqb=0
xqe=3000-1
 rad=q.position._DATA[0,i,xqb:xqe]
th=q.position._DATA[1,i,xqb:xqe]
 cgplot, rad*Sin(th), rad*cos(th), $
	title=string(i), /overplot, color='white', $
	psym=3, $ 
	symsize=.5

xqb=3000
xqe=6000-1
 rad=q.position._DATA[0,i,xqb:xqe]
th=q.position._DATA[1,i,xqb:xqe]
 cgplot, rad*Sin(th), rad*cos(th), $
	title=string(i), /overplot, color='green', $
	psym=3, $ 
	symsize=.5

xqb=6000
xqe=9000-1
 rad=q.position._DATA[0,i,xqb:xqe]
th=q.position._DATA[1,i,xqb:xqe]
 cgplot, rad*Sin(th), rad*cos(th), $
	title=string(i), /overplot, color='blue', $
	psym=3, $ 
	symsize=.5

xqb=9000
xqe=12000-1
 rad=q.position._DATA[0,i,xqb:xqe]
th=q.position._DATA[1,i,xqb:xqe]
 cgplot, rad*Sin(th), rad*cos(th), $
	title=string(i), /overplot, color='black', $
	psym=3, $ 
	symsize=.5


;wait, 1
end
