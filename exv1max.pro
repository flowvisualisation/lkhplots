;pro exvort9, nfile, vx1,vx2,vx3, rho, prs, t , nlast, nx1,nx2,nx3,x1,x2,x3, dx1,dx2, vorty, vpx,vpz, vmri, vshear, vx,vy,vz, vxsl, vysl
nfile=1



CD, CURRENT=str & PRINT, str
dirpath=STRSPLIT(Str,'/',  /EXTRACT) 
 dirname=dirpath(size(dirpath, /dimensions)-1)


 titlstr='?D MRI + PI ?'
CASE dirname OF
   '2d_mri_pi_kx_ll_ky'	: titlstr='2D MRI + PI k!Dx!N << k!Dy!N'
	'2d_mri_pi_ky_0'		: titlstr='2D MRI + PI k!Dy!N = 0 '
	'3d_mri_pi_kx_ky'		: titlstr='3D MRI + PI k!Dx!N = k!Dy!N'
	'3d_mri_pi_ky_0'		: titlstr='3D MRI + PI k!Dy!N = 0'
	'3d_mri_wn_pi_wn'		: titlstr='3D MRI!DWN!N + PI !DWN!N =0 '
	'3d_mri_pi_wn'		: titlstr='3D MRI + PI!DWN!N =0 '
   ELSE: PRINT, 'Not one through four'
   ELSE: PRINT, 'Not one through four'
ENDCASE

x=2
 
omega=1e-3
  !X.OMargin = [2, 6]
   !Y.OMargin = [2, 6]
window, 0, xs=1700, ys=900
;!p.multi=[0,3,2]

!p.charsize=2
nbeg=1
nend=8
angles=findgen(7)*15*!dtor
;projangle=29*!pi/30.
;projangle=5*!pi/12.
;projangle=!pi/3.
;projangle=!pi/4.
;projangle=!pi/6.
;projangle=!pi/12.
;projangle=!pi/30.

angleno=6
projangle=angles[angleno]
for nfile=nbeg,nend,1 do begin
pload,nfile, /silent

vx=vx1
vy=vx2
vz=vx3
xx=x1
yy=x2
zz=x3
nx=nx1
ny=nx2
nz=nx3

sbq=1.5
sbomega=1e-3
sba=-0.5*sbq*sbomega
vsh=2*sba
eps=1e-3
lx=2.0

xx3d=rebin(reform(x1,nx1,  1,  1),nx1,nx2,nx3) 
yy3d=rebin(reform(x2,  1,nx2,  1),nx1,nx2,nx3) 
zz3d=rebin(reform(x3,  1,  1,nx3),nx1,nx2,nx3) 
vshear=vsh*xx3d
scrh=lx*sbomega*eps/8.0
vmri=scrh*sin(2*!PI*zz3d)*exp(0.74975229*nfile)
vmri=max(vx)*sin(2*!PI*zz3d)
;; calc vorticity, x,y,z
;vortz=getvort(vx,vy,xx,yy,nx,ny)
;vorty=getvort(vx,vz,xx,zz,nx,nz)
;vortx1getvort(vy,vz,yy,zz,ny,nz)

vx=vx -vmri
vy=vy-vshear -vmri

vx=smooth(vx,5)
vy=smooth(vy,5)
;vx=vx;-vmri
;vy=vy;-vshear-vmri
;; extract slices


;; extract slices rotating around the z axis


;vx[nx/2-4:nx/2+4,ny/2-4:ny/2+4,nz/2-4:nz/2+4] *=1.5
;vy[nx/2-4:nx/2+4,ny/2-4:ny/2+4,nz/2-4:nz/2+4] *=1.5
;vz[nx/2-4:nx/2+4,ny/2-4:ny/2+4,nz/2-4:nz/2+4] *=1.5

for i=0,nx-1 do begin 
for j=0,ny-1 do begin 
for k=0,nz-1 do begin 
if (i eq j ) then begin
;vx[i,j,k]=i+k
endif
endfor
endfor
endfor


;vx[nx/2-4:nx/2+4,ny/2-4:ny/2+4,nz/2-4:nz/2+4] *=1.5
;vy[nx/2-4:nx/2+4,ny/2-4:ny/2+4,nz/2-4:nz/2+4] *=1.5
;vz[nx/2-4:nx/2+4,ny/2-4:ny/2+4,nz/2-4:nz/2+4] *=1.5

;

nslice=fix(sqrt(nx^2+ny^2))
nslice2=nz
nslice=nx
nslice2=nz

plane_normal=[ 1./sqrt(2) ,-1./sqrt(2) , 0.]
xvec        =[ 1./sqrt(2) , 1./sqrt(2) , 0.]
plane_normal=[-sin(projangle),  cos(projangle) , 0.]
xvec        =[ cos(projangle),  sin(projangle) ,  0.]
;vxsl = EXTRACT_SLICE(vx, nslice, nslice2,nx/2-.5, ny/2-.5, nz/2-.5,  plane_normal, xvec, OUT_VAL=0B, /radians)
;vysl = EXTRACT_SLICE(vy, nslice, nslice2,nx/2-.5, ny/2-.5, nz/2-.5,   plane_normal, xvec, OUT_VAL=0B, /radians)
;vzsl = EXTRACT_SLICE(vz, nslice, nslice2,nx/2-.5, ny/2-.5, nz/2-.5,   plane_normal, xvec, OUT_VAL=0B, /radians)

vxsl=reform(vx(*,4,*))
vysl=reform(vy(*,4,*))
vzsl=reform(vz(*,4,*))

;vxsl=congrid(vxsl,128,128, /cubic)
;vysl=congrid(vysl,128,128, /cubic)
;vzsl=congrid(vzsl,128,128, /cubic)

; subtract background
;backgroundshear1=total(vysl,2)
;backgroundshear=rebin(reform(backgroundshear1,nslice,1),nslice,nslice2 )/nslice2
;vysl=vysl-backgroundshear
;window,4 
;display, backgroundshear, ims=4
;cgplot, backgroundshear1

cgloadct,33
;cgimage, vxsl
;cgimage, vysl
;cgimage, vzsl
;; project them into specific plane


unitvec1=fltarr(size(vxsl, /dimensions))
unitvec2=fltarr(size(vxsl, /dimensions))
unitvec3=fltarr(size(vxsl, /dimensions))


unitvec1(*,*)=cos( projangle)
unitvec2(*,*)=sin( projangle)
unitvec3(*,*)=cos( projangle)

vpx=vxsl ;*unitvec1 + vysl*unitvec2
vpy=vxsl ;*unitvec2 - vysl*unitvec1
vpz=vzsl

mvpx=max(vpx)
;vpx=vpx-backgroundmri
;vpy=vpy-backgroundmri

;vortz=getvort(vpx,vpy,xx,xx,nx,nx)
xslice=findgen(nslice)
xslice2=findgen(nslice2)
vorty=getvort(vpx,vpz,xslice,xslice2,nslice,nslice2)
;!p.position=0
pos=[0.1,0.2,0.9,0.9]

xbeg=0
xend=nslice-1
ybeg=2 ;+angleno/3
yend=nslice2-3 ;+angleno/3
data=vorty[xbeg:xend,ybeg:yend]

datptr=ptrarr(4)


datptr[0]=ptr_new(vxsl)
datptr[1]=ptr_new(vysl)
datptr[2]=ptr_new(vzsl)
datptr[3]=ptr_new(data)

;!p.position=0
;window, 0
;!p.multi=[0,2,2]
;!p.multi=[0]
for i=0,3 do begin
;cgimage, *datptr(i),  background='white',  multimargin=0.9
;cgimage, vpy,  background='white',  position=pos
;cgimage, vpz,  background='white',  position=pos
;cgimage,data, background='white',  pos=pos
endfor


datptr[0]=ptr_new(vpx)
datptr[1]=ptr_new(vpy)
datptr[2]=ptr_new(vpz)
datptr[3]=ptr_new(data)
!p.position=0
;window, 1
;!p.multi=[0,2,2]
;!p.multi=[0]
for i=0,3 do begin
;cgimage, *datptr(i),  background='white',  multimargin=0.9
;cgimage, vpy,  background='white',  position=pos
;cgimage, vpz,  background='white',  position=pos
;cgimage,data, background='white',  pos=pos
endfor



fname="vort_"+dirname
projangle=0
tag=string ( projangle*!radeg, format='(I02)')
ll=6
zero=''
nts=strcompress(string(nfile),/remove_all)
lnt=strlen(nts)
for j=1,ll-lnt do zero=zero+'0'
           fname2=fname+tag+"_"+zero+nts

for usingps=0,1 do begin
if ( usingps ) then begin
set_plot,'ps'
device,filename=fname2+'.eps',/encapsulated
device, /color
!p.font=0
device, /times
;xs=12.-ar*6
;ys=6+ar*4
xsize=9
aspect_ratio=1.5 ;rectangle
device, xsize=xsize, ysize=xsize/aspect_ratio
!p.charsize=0.6
cbarchar=0.6
alchar=0.9
xyout=0.9
endif else begin
if ( keyword_set (zbuf) ) then begin
set_plot,'z'
ys=1200
xs=1800
!p.charsize=1.8
cbarchar=1.8
xyout=1.8
device, set_resolution=[xs,ys]
endif else begin
set_plot,'x'
!p.font=-1
!p.charsize=1.8
cbarchar=1.8
xyout=1.8
endelse
;device, set_resolution=[1100,800]
endelse




;cgcontour, data, /nodata, /overplot
cvx=vpx[xbeg:xend,ybeg:yend]
cvy=vpz[xbeg:xend,ybeg:yend]

qx=25
qy=26
qz=26
sz=size(cvx, /dimensions)
xx=findgen(sz(0))
yy=findgen(sz(1))
cvx2=congrid(cvx,qx,qz)
cvz2=congrid(cvy,qx,qz)
cx=congrid(xx,qx)
cz=congrid(yy,qy)
;!p.multi=0
;window, 2
cgloadct,33
cgimage,data, background='white',  pos=pos
imin=min(data)
imax=max(data)
cgcolorbar, Position=[pos[0], pos[1]-0.09, pos[2], pos[1]-0.06], range=[imin,imax], format='(G8.1)', charsize=cbarchar
cgcontour, data,xx,yy,/nodata,  /noerase, pos=pos, axiscolor=cgcolor('black'), $
	 ;title="Vorticity orthogonal to h , with velocity vectors", $
	 xtitle="x ", $
	 ytitle="z"
velovect, cvx2,cvz2, cx,cz, /overplot, /noerase, color=cgcolor('white'), thick=1.5 , len=2.5 , pos=pos

   cgText, 0.5, 0.95, ALIGNMENT=0.5, CHARSIZE=0.6, /NORMAL, $
      titlstr+', vorticity'+', t='+string(t(nfile)*omega, format='(F5.1)')+' orbits', color='black'



if ( usingps ) then begin
device,/close
set_plot,'x'
endif else begin
;set_plot,'x'
fname3=fname2
im=cgsnapshot(filename=fname3,/nodialog,/jpeg)
endelse

endfor




endfor

;window, 7
;cgplot, backgroundshear1


!p.position=0
!p.multi=0

  !Y.OMargin = [0, 0]
   !X.OMargin = [0, 0]
end
