
x=2
 
CASE x OF
   1: begin
	 PRINT, 'one'
	end
   2: PRINT, 'two'
   3: PRINT, 'three'
   4: PRINT, 'four'
   ELSE: PRINT, 'Not one through four'
ENDCASE

nbeg=20
nend=nbeg
angles=findgen(7)*15*!dtor
;projangle=29*!pi/30.
;projangle=5*!pi/12.
;projangle=!pi/3.
;projangle=!pi/4.
;projangle=!pi/6.
;projangle=!pi/12.
;projangle=!pi/30.

for angleno=1,6 do begin
projangle=angles[angleno]
for nfile=nbeg,nend,1 do begin
pload,nfile

vx=vx1
vy=vx2
vz=vx3
xx=x1
yy=x2
zz=x3
nx=nx1
ny=nx2
nz=nx3
;; calc vorticity, x,y,z
;vortz=getvort(vx,vy,xx,yy,nx,ny)
;vorty=getvort(vx,vz,xx,zz,nx,nz)
;vortx1getvort(vy,vz,yy,zz,ny,nz)

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

nslice=fix(sqrt(nx^2+nz^2))+50

plane_normal=[ 1./sqrt(2) ,-1./sqrt(2) , 0.]
xvec        =[ 1./sqrt(2) , 1./sqrt(2) , 0.]
plane_normal=[-sin(projangle),  cos(projangle) , 0.]
xvec        =[ cos(projangle),  sin(projangle) ,  0.]
vxsl = EXTRACT_SLICE(vx, nslice, nslice,nx/2-.5, ny/2-.5, nz/2-.5,  plane_normal, xvec, OUT_VAL=0B, /radians)
vysl = EXTRACT_SLICE(vy, nslice, nslice,nx/2-.5, ny/2-.5, nz/2-.5,   plane_normal, xvec, OUT_VAL=0B, /radians)
vzsl = EXTRACT_SLICE(vz, nslice, nslice,nx/2-.5, ny/2-.5, nz/2-.5,   plane_normal, xvec, OUT_VAL=0B, /radians)

;vxsl=congrid(vxsl,128,128, /cubic)
;vysl=congrid(vysl,128,128, /cubic)
;vzsl=congrid(vzsl,128,128, /cubic)

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

vpx=vxsl*unitvec1 + vysl*unitvec2
vpy=vxsl*unitvec2 - vysl*unitvec1
vpz=vzsl


;vortz=getvort(vpx,vpy,xx,xx,nx,nx)
xslice=findgen(nslice)
vorty=getvort(vpx,vpz,xslice,xslice,nslice,nslice)
!p.position=0
pos=[0.1,0.1,0.9,0.9]

xbeg=nslice/2-64
xend=nslice/2+64
ybeg=nslice/2-30 ;+angleno/3
yend=nslice/2+30 ;+angleno/3
data=vorty[xbeg:xend,ybeg:yend]

datptr=ptrarr(4)


datptr[0]=ptr_new(vxsl)
datptr[1]=ptr_new(vysl)
datptr[2]=ptr_new(vzsl)
datptr[3]=ptr_new(data)

!p.position=0
window, 0
!p.multi=[0,2,2]
;!p.multi=[0]
for i=0,3 do begin
cgimage, *datptr(i),  background='white',  multimargin=0.9
;cgimage, vpy,  background='white',  position=pos
;cgimage, vpz,  background='white',  position=pos
;cgimage,data, background='white',  pos=pos
endfor


datptr[0]=ptr_new(vpx)
datptr[1]=ptr_new(vpy)
datptr[2]=ptr_new(vpz)
datptr[3]=ptr_new(data)
!p.position=0
window, 1
!p.multi=[0,2,2]
;!p.multi=[0]
for i=0,3 do begin
cgimage, *datptr(i),  background='white',  multimargin=0.9
;cgimage, vpy,  background='white',  position=pos
;cgimage, vpz,  background='white',  position=pos
;cgimage,data, background='white',  pos=pos
endfor

cgcontour, data, /nodata, /overplot
cvx=vpx[xbeg:xend,ybeg:yend]
cvy=vpz[xbeg:xend,ybeg:yend]
;cvx=vxsl[nslice/2-64:nslice/2+64,nslice/2-30:nslice/2+30]
;cvy=vzsl[nslice/2-64:nslice/2+64,nslice/2-30:nslice/2+30]

qx=25
qz=26
sz=size(cvx, /dimensions)
xx=findgen(sz(0))
yy=findgen(sz(1))
cvx2=congrid(cvx,qx,qz)
cvz2=congrid(cvy,qx,qz)
cx=congrid(xx,qx)
cz=congrid(zz,qz)
!p.multi=0
window, 2
cgimage,data, background='white',  pos=pos
tag=string ( projangle*!radeg, format='(I02)')
cgcontour, data,xx,yy,/nodata,  /noerase, pos=pos, axiscolor=cgcolor('black'), $
	 title="Vorticity orthogonal to h , with velocity vectors", $
	 xtitle="h, angle="+tag, $
	 ytitle="z"
velovect, cvx2,cvz2, cx,cz, /noerase, color=cgcolor('white'), thick=1.5 , len=2.5 , pos=pos

ll=6
zero=''
nts=strcompress(string(nfile),/remove_all)
lnt=strlen(nts)
for j=1,ll-lnt do zero=zero+'0'
           fname='angle'+tag+"_"+zero+nts

im=cgsnapshot(filename=fname, /nodialog, /jpeg)

endfor
endfor
!p.position=0
!p.multi=0
end
