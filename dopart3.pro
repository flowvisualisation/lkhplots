
pro dopart3
;xs=380
;ys=720
xs=480
ys=950
xs=550
ys=1100
cgdisplay, xs=xs,ys=ys


cgloadct,33

for i=1L,1L, 1 do begin
model=i*100000L
r=h5_read( model, /b,/v,/rho,/p) 
grd_ctl, model=model, p , c
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

ptime=q.time._DATA 

aa=where ( ptime gt c.time)

tn=aa(0)
 rad=q.position._DATA[0,i,0:tn]
th=q.position._DATA[1,i,0:tn]
 cgplot, rad*Sin(th), rad*cos(th), $
	title=string(i), /overplot, color='white', $
	psym=3, $ 
	symsize=.5
wait, 1



fname='part'+string(model, format='(I07)')
im=cgsnapshot(filename=fname,/png, /nodialog)

endfor
end
