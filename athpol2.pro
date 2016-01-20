pro athpol2, n
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

dptr=ptrarr(12)
dptr[0]=ptr_new(dd)
dptr[1]=ptr_new(vr)
dptr[2]=ptr_new(vp)
dptr[3]=ptr_new(vzi)
dptr[4]=ptr_new(br)
dptr[5]=ptr_new(bp)
dptr[6]=ptr_new(bzi)
dptr[7]=ptr_new(br*bp)

sarr=strarr(12)
sarr[0]="density"
sarr[1]="V!DR!N"
sarr[2]="V!D!7u!X!N"
sarr[3]="V!DZ!N"
sarr[4]="B!DR!N"
sarr[5]="B!D!7u!X!N"
sarr[6]="B!DZ!N"
sarr[7]="B!DR!NB!D!7u!X!N"

cgloadct,33
tvlct,255,255,255,0
;tvlct,255,255,255,1


cgdisplay, xs=800,ys=700
pos=cglayout([4,2], xgap=1, ygap=6, oxmargin=[5,1], oymargin=[11,4])
cgerase
fname="HKDisk"+"pol"+string(n, format='(I04)')
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet, font=1
charsize=cgdefcharsize()*.6
omega_str='!9W!X'
sarr[2]="V!D!9f!X!N"
sarr[5]="B!D!9f!X!N"
sarr[7]="B!DR!NB!D!9f!X!N"
endif else  begin
set_plot, 'x'
omega_str='!7X!X'
charsize=cgdefcharsize()*.6
endelse


for i=0,7 do begin
d=*dptr[i]
imin=min(d)
imax=max(d)
r=cgscalevector(d,0,254)
px=pos[*,i]

xtickf="(a1)"
ytickf="(a1)"
xtit=''
ytit=''
cby=0.01

if ( i gt 3 ) then begin
xtickf="(I3)"
    xtit="X"
cby=0.07
endif

if ( (i eq 0) or (i eq 4) ) then begin
ytickf="(I3)"
    ytit="Y"
endif

cgimage, r, pos=px, /noerase
cgcontour,r,xx,yy,  $ 
    /noerase, /nodata, $
    pos=px,  $
    charsize=charsize, $
    ;title=sarr[i], $
    xtickf=xtickf,$
    ytickf=ytickf,$
    xtitle=xtit,$
    ytitle=ytit
    
    cgcolorbar, range=[imin,imax], pos=[px[0],px[1]-0.01-cby, px[2], px[1]-cby], charsize=charsize ;, divisions=3
cgtext, 5,20,sarr[i]  ,  charsize=charsize

endfor




cgtext, 0.4,0.97, "athena GT4 accretion disk, t="+string(time/61.5, format="(F5.1)")+" orbits", /normal, charsize=charsize

;fname=tag+'-pol-'+strnum
print, fname
;im=cgsnapshot(filename=fname, /jpeg, /nodialog)



if ( usingps ) then begin
cgps_close, /jpeg,  Width=1100, /nomessage, delete_ps=0
READ_JPEG, fname+'.jpg', a, TRUE=1 & cgimage, a
endif 
endfor



 end
