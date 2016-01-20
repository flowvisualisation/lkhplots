;   .r ../vis/idl/pltath

;cgdisplay, xs=800,ys=700
pro athrz2, n
COMMON SHARE1,nx,ny,nz,nvar,nscalars
COMMON SHARE2,x,y,z
COMMON SHARE3,time,dt,gamm1,isocs
COMMON SHARE4,d,e,p,vx,vy,vz,bx,by,bz,s,phi
tag='CylNewtZ8'
tag='HKDisk'
strnum=string(n, format='(I04)')
pfact=5./3.
readvtk, tag+'.'+strnum+'.vtk', pfact

xmn=  4
xmx=  44
ymn= -0.785398
ymx=  0.785398
zmn= -15
zmx=  15
xr=xmx-xmn
yr=ymx-ymn
zr=zmx-zmn

 xx=findgen(nx)/nx*xr+xmn & yy=findgen(ny)/ny*yr+ymn  &   zz=findgen(nz)/nz*zr+zmn 
 x1=xx & x2=yy & x3=zz

dd =reform( (d[*,ny/2,*]))
dd=dd/max(dd)
vr =reform(vx[*,ny/2,*])
vp =reform(vy[*,ny/2,*])
vzi=reform(vz[*,ny/2,*])
br =reform(bx[*,ny/2,*])
bp =reform(by[*,ny/2,*])
bzi=reform(bz[*,ny/2,*])
en=reform(e[*,ny/2,*])

vp[0,0]=vp[0,0]+1e-6
pos=cglayout([4,2], xgap=2, ygap=6, oxmargin=[7,5], oymargin=[12,5])

dptr=ptrarr(12)
dptr[0]=ptr_new(dd)
dptr[1]=ptr_new(vr)
dptr[2]=ptr_new(vp)
dptr[3]=ptr_new(vzi)
dptr[4]=ptr_new(br)
dptr[5]=ptr_new(bp)
dptr[6]=ptr_new(bzi)
dptr[7]=ptr_new(en)

cgloadct,33
;tvlct,255,255,255,0
;tvlct,255,255,255,1
cgerase,0

;cgdisplay, xs=800,ys=800


fname="HKDisk"+"rz"+string(n, format='(I04)')
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet, font=1
charsize=cgdefcharsize()*.6
rhostr="!9r!X"
phistr="!9f!X"
omega_str='!9W!X'
sarr[2]="V!D!9f!X!N"
sarr[5]="B!D!9f!X!N"
endif else  begin
set_plot, 'x'
rhostr="!7q!X"
phistr="!7g!X"
omega_str='!7X!X'
charsize=cgdefcharsize()*.6
endelse


sarr=strarr(12)
sarr[0]=rhostr
sarr[1]="V!DR!N"
sarr[2]="V!D"+phistr+"!N"
sarr[3]="V!DZ!N"
sarr[4]="B!DR!N"
sarr[5]="B!D"+phistr+"!N"
sarr[6]="B!DZ!N"
sarr[7]="E!DT!N"



for i=0,7 do begin


d=*dptr[i]
imin=min(d)
imax=max(d)
r=cgscalevector(d,1,254)
px=pos[*,i]

xtickf="(a1)"
ytickf="(a1)"
xtit=''
ytit=''
cby=0.01

if ( i gt 3 ) then begin
xtickf="(I3)"
    xtit="R"
cby=0.07
endif

if ( (i eq 0) or (i eq 4) ) then begin
ytickf="(I3)"
    ytit="Z"
endif


if ( i eq 0 ) then begin
cgimage, r, pos=px
endif else begin
cgimage, r, pos=px, /noerase
endelse 
cgcontour,r,xx,zz,  $ 
    /noerase, /nodata, $
    charsize=charsize,$
    pos=px,  $
    ;title=sarr[i], $
    xtickf=xtickf,$
    ytickf=ytickf,$
    xtitle=xtit,$
    ytitle=ytit
    cgcolorbar, range=[imin,imax], pos=[px[0],px[1]-0.01-cby, px[2], px[1]-cby]

;cgtext, 5,10, sarr[i], charsize=charsize*1.3, color='white'
cgLegend,  Location=[25, 14],/data, $
      Titles=sarr[i], Length=0.001, /Box, VSpace=0.75,charsize=charsize, /Background, BG_Color='rose'

endfor

cgtext, 0.3,0.97, "athena GT4 turbulent disk , t="+string(time/61.5, format='(F4.1)')+" orbits", /normal

;fname=tag+'-rz-'+strnum
print, fname

if ( usingps ) then begin
cgps_close, /jpeg,  Width=2048, /nomessage, delete_ps=0
READ_JPEG, fname+'.jpg', a, TRUE=1 & cgimage, a
endif 
endfor
;im=cgsnapshot(filename=fname, /jpeg, /nodialog)


 end
