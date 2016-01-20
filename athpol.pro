pro athpol, n
COMMON SHARE1,nx,ny,nz,nvar,nscalars
COMMON SHARE2,x,y,z
COMMON SHARE3,time,dt,gamm1,isocs
COMMON SHARE4,d,e,p,vx,vy,vz,bx,by,bz,s,phi
tag='HKDisk'
strnum=string(n, format='(I04)')
pfact=5./3.
readvtk, tag+'.'+strnum+'.vtk', pfact

xmn=  4
xmx=  44
ymn= -0.785398
ymx=  0.785398
zmn= -20
zmx=  20
xr=xmx-xmn
yr=ymx-ymn
zr=zmx-zmn

 xx=findgen(nx)/nx*xr+xmn & yy=findgen(ny)/ny*yr+ymn  &   zz=findgen(nz)/nz*zr+zmn & dd=d[*,*,nz/2]
 x1=xx & x2=yy & x3=zz
 polar, dd, xx,yy, sample=3 
 dd=dd/299.3

 xx=x1 & yy=x2 & vr=vx[*,*,nz/2]
 polar, vr, xx,yy, sample=3 
 xx=x1 & yy=x2 & vp=vy[*,*,nz/2]
 polar, vp, xx,yy, sample=3 
 xx=x1 & yy=x2 & vzi=vz[*,*,nz/2]
 polar, vzi, xx,yy, sample=3 
 xx=x1 & yy=x2 & br=bx[*,*,nz/2]
 polar, br, xx,yy, sample=3 
 xx=x1 & yy=x2 & bp=by[*,*,nz/2]
 polar, bp, xx,yy, sample=3 
 xx=x1 & yy=x2 & bzi=bz[*,*,nz/2]
 polar, bzi, xx,yy, sample=3 

vp[0,0]=vp[0,0]+1e-6
pos=cglayout([4,2], xgap=7, ygap=12, oxmargin=[7,5], oymargin=[12,5])

dptr=ptrarr(12)
dptr[0]=ptr_new(dd)
dptr[1]=ptr_new(vr)
dptr[2]=ptr_new(vp)
dptr[3]=ptr_new(vzi)
dptr[4]=ptr_new(br)
dptr[5]=ptr_new(bp)
dptr[6]=ptr_new(bzi)
dptr[7]=ptr_new(bzi)

sarr=strarr(12)
sarr[0]="density"
sarr[1]="V!DR!N"
sarr[2]="V!D!7u!X!N"
sarr[3]="V!DZ!N"
sarr[4]="B!DR!N"
sarr[5]="B!D!7u!X!N"
sarr[6]="B!DZ!N"
sarr[7]="B!DZ!N"

cgloadct,33
;tvlct,255,255,255,0
;tvlct,255,255,255,1

;cgdisplay, xs=800,ys=800
cgerase
for i=0,7 do begin
d=*dptr[i]
imin=min(d)
imax=max(d)
r=cgscalevector(d,1,254)
px=pos[*,i]
cgimage, r, pos=px, /noerase
cgcontour,r,xx,yy,  $ 
    /noerase, /nodata, $
    pos=px,  $
    title=sarr[i], $
    xtitle="X",$
    ytitle="Y"
    cgcolorbar, range=[imin,imax], pos=[px[0],px[1]-0.05, px[2], px[1]-0.04]

endfor

cgtext, 0.4,0.97, "athena GT4 accretion disk, t="+string(time/61.5)+" orbits", /normal

fname=tag+'-pol-'+strnum
print, fname
im=cgsnapshot(filename=fname, /jpeg, /nodialog)


 end
