
nbeg=40
nend=100
cgDisplay, WID=1,xs=800, ys=700, xpos=600, ypos=800
nfile=60
for nfile=nbeg,nend do begin
snoopyread, vx,vy, vz,bx,by,bz, xx3d,yy3d,zz3d,xx,yy,zz,nx,ny,nz,nfile, time


vmri=sin(2*!DPI*zz3d)*max(vx)
bmri=cos(2*!DPI*zz3d)*max(bx)
vx=vx-vmri
vy=vy-vmri
bx=bx-bmri
by=by+bmri


v1=reform(vx[*,4,*])
v2=reform(vy[*,4,*])
v3=reform(vz[*,4,*])
a1=reform(bx[*,4,*])
a2=reform(by[*,4,*])
a3=reform(bz[*,4,*])

vorty=getvort(v1,v3,xx,zz,nx,nz)
cury=getvort(a1,a3,xx,zz,nx,nz)

print, 'max, min, v1', max(v1), min(v1)
print, 'max, min, v2', max(v2), min(v2)
print, 'max, min, v3', max(v3), min(v3)
print, 'max, min, b1', max(a1), min(a1)
print, 'max, min, b2', max(a2), min(a2)
print, 'max, min, b3', max(a3), min(a3)

dataptr=ptrarr(12)

titlestr=strarr(12,30)
dataptr[0]=ptr_new(v1)
dataptr[1]=ptr_new(v2)
dataptr[2]=ptr_new(v3)
dataptr[3]=ptr_new(a1)
dataptr[4]=ptr_new(a2)
dataptr[5]=ptr_new(a3)
dataptr[6]=ptr_new(vorty)
dataptr[7]=ptr_new(cury)
dataptr[8]=ptr_new(vorty)

titlestr[0,*]='v1'
titlestr[1,*]='v2'
titlestr[2,*]='v3'
titlestr[3,*]='b1'
titlestr[4,*]='b2'
titlestr[5,*]='b3'
titlestr[6,*]='vorty'
titlestr[7,*]='cury'
titlestr[8,*]='rho'




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
   cgText, 0.5, 0.96, /Normal,  'Jet time='+string(time), Alignment=0.5, Charsize=cgDefCharsize()*1.25



endfor


end
