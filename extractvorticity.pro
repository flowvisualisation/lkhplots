
for nfile=1,nlast do begin
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
;vortx=getvort(vy,vz,yy,zz,ny,nz)

;; extract slices


;; extract slices rotating around the z axis


theta=!PI/4
;theta=!PI/3
;theta=!PI/6
;theta=!PI/9
vxsl = EXTRACT_SLICE(vx, nx, ny,nx/2, ny/2-0.5, nz/2, 0.0, theta, 0.0, $
   OUT_VAL=0B)
vysl = EXTRACT_SLICE(vy, nx, ny,nx/2, ny/2-.5, nz/2, 0.0, theta, 0.0, $
   OUT_VAL=0B)
vzsl = EXTRACT_SLICE(vz, nx, ny,nx/2, ny/2-.5, nz/2, 0.0, theta, 0.0, $
   OUT_VAL=0B)

cgloadct,33
;cgimage, vxsl
;cgimage, vysl
;cgimage, vzsl
;; project them into specific plane


unitvec1=fltarr(size(vxsl, /dimensions))
unitvec2=fltarr(size(vxsl, /dimensions))
unitvec3=fltarr(size(vxsl, /dimensions))


unitvec1(*,*)=cos( theta)
unitvec2(*,*)=sin( theta)
unitvec3(*,*)=cos( theta)

vpx=vxsl*unitvec1 + vysl*unitvec2
vpy=vxsl*unitvec2 - vysl*unitvec1
vpz=vzsl


vortz=getvort(vpx,vpy,xx,yy,nx,ny)
vorty=getvort(vpx,vpz,xx,yy,nx,ny)
;!p.multi=[0,4,1]
!p.multi=[0]
pos=[0.1,0.1,0.9,0.9]
;cgimage, vpx,  background='white', scale=1
;cgimage, vpy,  background='white', scale=1
;cgimage, vpz,  background='white', scale=1
cgimage, vorty[0:nx-4,0:ny-1],  background='white', scale=1, pos=pos
cvx= vpx[0:nx-4,0:ny-1]
cvy=vpz[0:nx-4,0:ny-1] 
cvx2=congrid(vpx,13,17)
cvy2=congrid(vpy,13,17)
 velovect, cvx2,cvy2, /overplot, /noerase, color=cgcolor('white'), thick=1.25 , len=2.5, pos=pos

ll=6
zero=''
nts=strcompress(string(nfile),/remove_all)
lnt=strlen(nts)
for j=1,ll-lnt do zero=zero+'0'
           fname='ebvd_'+zero+nts

im=cgsnapshot(filename=fname, /nodialog, /jpeg)

endfor
!p.position=0
!p.multi=0
end
