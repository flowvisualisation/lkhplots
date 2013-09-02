
background=0
hires=1
doxwin=1
if ( hires eq 1) then begin
xs=1800
ys=1300
endif else begin
xs=800
ys=800
endelse 
if ( doxwin eq 1 ) then begin
set_plot, 'x'
window, xs=xs, ys=ys
endif else begin
set_plot, 'z'
device, set_resolution=[1300,1100]
endelse

onefile=0
if ( onefile eq 1 ) then begin
qnumq=0
nend=0
nstart=nend
nstep=1
endif else begin
nend=400
nstart=0
nstep=1
endelse
t=findgen(1)
if( nend gt 0) then begin
t=findgen(nend)
endif

slice=0

f=rf(0)
vixinit=reform(f.v[*,slice,*,0,1])
viyinit=reform(f.v[*,slice,*,1,1])
vizinit=reform(f.v[*,slice,*,2,1])
vexinit=reform(f.v[*,slice,*,0,0])
veyinit=reform(f.v[*,slice,*,1,0])
vezinit=reform(f.v[*,slice,*,2,0])
qsm=200
vixsm=smooth(vixinit,qsm,/edge_wrap)
vizsm=smooth(vizinit,qsm,/edge_wrap)
initionvort = 0.5*(shift(vixsm,0,-1)-shift(vixsm,0,1) ) - 0.5*(shift(vizsm,-1,0) - shift(vizsm,1,0))
initionvort=getvort(vixsm,vizsm,xx,yy,nx,nz)
vixsm0=vixsm
vizsm0=vizsm

vexsm=smooth(vexinit,qsm,/edge_wrap)
vezsm=smooth(vezinit,qsm,/edge_wrap)
initelecvort= 0.5*(shift(vexsm,0,-1)-shift(vexsm,0,1) ) - 0.5*(shift(vezsm,-1,0) - shift(vezsm,1,0))
initelecvort=getvort(vexsm,vezsm,xx,yy,nx,nz)
vexsm0=vexsm
vezsm0=vezsm

totalelecke0=total(vexinit^2+vezinit^2)
totalionke0=total(vixinit^2+vizinit^2)
gamma=fltarr(1)
tvx2=fltarr(1)
tvx2(*)=1

for nfile=nstart,nend,nstep do begin
print, ' nfile= ' , nfile

ll=6
zero=''
nts=strcompress(string(nfile),/remove_all)
lnt=strlen(nts)
for j=1,ll-lnt do zero=zero+'0'
           fname='phasespace'+zero+nts


varfile='VAR1'
tag=zero+nts+'.dat'
varfile='fields-'+tag
path='Data/'

if (  file_test(path+varfile)  ne 1 ) then begin
print, varfile+' does not exist, exiting'
break
endif

f=rf(nfile)
p=rp(nfile, /wrap)

!p.position=0
nx = f.s.gn[0]
nz = f.s.gn[2]
nx1=findgen(nx)
nx2=findgen(nz)
;print, nx,nz
slice= f.s.gn[1]/2

bx=reform(f.bx[*,slice,*],nx,nz)
by=reform(f.by[*,slice,*],nx,nz)
bz=reform(f.bz[*,slice,*],nx,nz)
ex=reform(f.ex[*,slice,*],nx,nz)
ey=reform(f.ey[*,slice,*],nx,nz)
ez=reform(f.ez[*,slice,*],nx,nz)
vix=reform(f.v[*,slice,*,0,1],nx,nz)
viy=reform(f.v[*,slice,*,1,1],nx,nz)
viz=reform(f.v[*,slice,*,2,1],nx,nz)
vex=reform(f.v[*,slice,*,0,0],nx,nz)
vey=reform(f.v[*,slice,*,1,0],nx,nz)
vez=reform(f.v[*,slice,*,2,0],nx,nz)

a=total(vex^2)/totalelecke0
b=total(vix^2)/totalionke0
gamma=[gamma, a]
tvx2=[tvx2, b]
;print, size(gamma)


for usingps=0,0 do begin

if ( usingps ) then begin
set_plot,'ps'
device,filename=fname+'.eps',/encapsulated
device, /color
!p.font=0
device, /times
xs=10.
ys=6
!p.charsize=1.8
DEVICE, XSIZE=xs, YSIZE=ys, /INCHES
endif else begin
set_plot,'x'
!p.font=-1
!p.color=0
!p.background=255
!p.charsize=1.8
;window, xs=1100,ys=800
;device, Set_Resolution=[1100,800]
endelse

;window, xs=1100,ys=800
dophasespace=0
!p.multi=[0,4,2]
 if ( dophasespace eq 1) then begin
!p.multi=[0,4,4]
endif
!x.style=1
!y.style=1

!p.background=1

xx=findgen(nx)
yy=findgen(nz)

p1 = !P & x1 = !X & y1 = !Y


elec=0
ion=1
xdir=0
ydir=1
zdir=2
px=0
py=1
pz=2

qnparq=n_Elements(p.r[*,xdir,elec])
var=fltarr(16,qnparq)
var(0,*)=p.r[*,xdir,elec]
var(1,*)=p.p[*,px,elec]  
var(2,*)=p.r[*,zdir,elec]
var(3,*)=p.p[*,px,elec]  
var(4,*)=p.r[*,xdir,elec]
var(5,*)=p.p[*,pz,elec]  
var(6,*)=p.r[*,zdir,elec]
var(7,*)=p.p[*,pz,elec]  
var(8,*)=p.r[*,xdir,ion]
var(9,*)=p.p[*,px,ion]  
var(10,*)=p.r[*,zdir,ion]
var(11,*)=p.p[*,px,ion]  
var(12,*)=p.r[*,xdir,ion]
var(13,*)=p.p[*,pz,ion]  
var(14,*)=p.r[*,zdir,ion]
var(15,*)=p.p[*,pz,ion]  

titlstr=strarr(8,30)
titlstr(0,*)="Elec Phase Space x-vx"
titlstr(1,*)="Elec Phase Space z-vx"
titlstr(2,*)="Elec Phase Space x-vz"
titlstr(3,*)="Elec Phase Space z-vz"
titlstr(4,*)="Ion Phase Space x-vx"
titlstr(5,*)="Ion Phase Space z-vx"
titlstr(6,*)="Ion Phase Space x-vz"
titlstr(7,*)="Ion Phase Space z-vz"

nqx=100
nqy=100
 if ( dophasespace eq 1) then begin
;plot,p.r[*,xdir,elec], p.p[*,px,elec],  xtitle='xpos',  ytitle='px',  psym=3, title=
for i=0,7 do begin
   pos = [0.12, 0.05, 0.98, 0.91]
r1=var(2*i,*)
r2=var(2*i+1,*)
n1=n_elements(r1)
grid=fltarr(nqx,nqy)
bin2d, r1,r2,n1, grid, nqx,nqy
r=scale_vector(grid,1,254)
xq=findgen(nqx)* (max(r1)-min(r1))/nqx + min(r1)
yq=findgen(nqy)* (max(r2)-min(r2))/nqy + min(r2)
;contour, grid, xq,yq,/nodata, xtitle='xpos',  ytitle='px',   
cgloadct,3, /reverse
 cgimage, r, POSITION=pos, /KEEP_ASPECT_RATIO ,background='white', scale=1
 cgcontour, r, xq,yq,POSITION=pos, /NOERASE, XSTYLE=1, $
      YSTYLE=1,  NLEVELS=10, /nodata, title=titlstr(i), $
      ;color='white',$
       axiscolor='black',$
      xtitle='x ', ytitle='y'
endfor

;xxxxxx

endif


;;
;;  
;;;


var=fltarr(8,nx,nz)
;help,var, vex,vey,vez
var(0,*,*)=vix
var(1,*,*)=viz
vixsm=smooth(vix,qsm,/edge_wrap)
vizsm=smooth(viz,qsm,/edge_wrap)
;vixsm=vix
;vizsm=viz
vortion= 0.5*(shift(vixsm,0,-1)-shift(vixsm,0,1) ) - 0.5*(shift(vizsm,-1,0) - shift(vizsm,1,0))
vortion=getvort(vixsm,vizsm,xx,yy,nx,nz)
if (background eq 1 ) then begin
var(2,*,*) = vortion-initionvort
endif else begin
        var(2,*,*)= vortion
endelse
var(3,*,*)=reform(f.by[*,0,*])

var(4,*,*)=vex
var(5,*,*)=vez
vexsm=smooth(vex,qsm,/edge_wrap)
vezsm=smooth(vez,qsm,/edge_wrap)
;vexsm=vex
;vezsm=vez
vortelec= 0.5*(shift(vexsm,0,-1)-shift(vexsm,0,1) ) - 0.5*(shift(vezsm,-1,0) - shift(vezsm,1,0)) 
vortelec=getvort(vexsm,vezsm,xx,yy,nx,nz)
if (background eq 1 ) then begin
var(6,*,*)= vortelec-initelecvort
endif else begin
var(6,*,*)= vortelec
endelse
var(7,*,*)=vix

titlstr=strarr(8,30)
titlstr(0,*)="V!Dion, X!N"
titlstr(1,*)="V!Dion, Z!N"
titlstr(2,*)="Ion Vorticity"
titlstr(3,*)="by"
titlstr(4,*)="V!Delec, X!N"
titlstr(5,*)="V!Delec, Z!N"
titlstr(6,*)="Electron Vorticity"
titlstr(7,*)="spare"



;contour, vez, xx,yy,/nodata, title='V!Delec, Z!N'
;tvimage, r, /overplot

 cgLoadCT, 33, CLIP=[5, 245]

for i=0,6 do begin
   pos = [0.02, 0.3, 0.98, 0.95]
localimagecopy=reform(var(i,*,*))
 cgIMAGE, localimagecopy, POSITION=pos, /KEEP_ASPECT_RATIO ,background='white', scale=1
 cgcontour, localimagecopy, xx,yy,POSITION=pos, /NOERASE, XSTYLE=1, $
      YSTYLE=1,  NLEVELS=10, /nodata, title=titlstr(i), $
       axiscolor='black',$
      xtitle='x ', ytitle='y'
imin=min(localimagecopy)-1e-6
imax=max(localimagecopy)+1e-6
cgcolorbar, Position=[pos[0], pos[1]-0.06, pos[2], pos[1]-0.05], range=[imin,imax], format='(G12.1)', annotatecolor='black'

if (i eq 2  or i eq 6) then begin
q=30
if (i eq 2) then begin
if ( background=1 ) then begin
cv1=congrid(vixsm-vixsm0,q,q)
cv2=congrid(vizsm-vizsm0,q,q)
endif else begin
cv1=congrid(vixsm,q,q)
cv2=congrid(vizsm,q,q)
endelse 
endif else begin
if ( background=1 ) then begin
cv1=congrid(vexsm-vexsm0,q,q)
cv2=congrid(vezsm-vezsm0,q,q)
endif else begin
cv1=congrid(vexsm,q,q)
cv2=congrid(vezsm,q,q)
endelse 
endelse
cx=congrid(xx,q)
cy=congrid(yy,q)

velovect, cv1,cv2, cx,cy, /noerase,/overplot, position=pos , color=cgcolor('black'), c_thick=4
endif
endfor


!x.range=0
!y.range=0
cgplot,  gamma, title='Total x-kinetic energy',color='black' ;, /xlog, /ylog
cgplot,  tvx2, /overplot, color='black'

xyouts, 0.01,0.01,$
   't='+string(nfile,format='(F8.1)'),$
   /normal, charsize=3

!p.position=0
!p.multi=0


if ( usingps ) then begin
device,/close
set_plot,'x'
endif else begin
;set_plot,'x'
fname2=fname
im=cgsnapshot(filename=fname2,/nodialog,/jpeg)
endelse

endfor
set_plot,'x'


print,a,b
endfor

cgloadct,0, /reverse
end
