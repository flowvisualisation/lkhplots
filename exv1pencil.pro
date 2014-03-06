;pro exvort9, nfile, vx1,vx2,vx3, rho, prs, t , nlast, nx1,nx2,nx3,x1,x2,x3, dx1,dx2, vorty, vpx,vpz, vmri, vshear, vx,vy,vz, vxsl, vysl
pluto=0
nfile=1
x=2


CD, CURRENT=str & PRINT, str
dirpath=STRSPLIT(Str,'/',  /EXTRACT) 
 dirname=dirpath(size(dirpath, /dimensions)-2)
 
omega=1
  !X.OMargin = [2, 6]
   !Y.OMargin = [2, 6]
window, 0, xs=1700, ys=900
;!p.multi=[0,3,2]

!p.charsize=2
nbeg=1
;nend=nlast
nend=20
t=findgen(nend+1)
angles=findgen(7)*15*!dtor
;projangle=29*!pi/30.
;projangle=5*!pi/12.
;projangle=!pi/3.
;projangle=!pi/4.
;projangle=!pi/6.
;projangle=!pi/12.
;projangle=!pi/30.

angleno=0
projangle=angles[angleno]
for nfile=nbeg,nend,1 do begin

code='pencil'
code='pluto'
code='snoopy'

switch code OF 
'pluto': begin
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
break;
end

'pencil':begin


path='data/proc0/'
varfile='VAR'+str(nfile)
if ( (pluto eq 0 )  and (file_test(path+varfile)  ne 1 )) then begin
print, varfile+' does not exist, exiting gm'
endif
pc_read_var, obj=f0, varfile=varfile, /trimall, /bb
vx=f0.uu[*,*,*,0]
vy=f0.uu[*,*,*,1]
vz=f0.uu[*,*,*,2]
nx=mx-6
ny=my-6
nz=mz-6
Lx=2.d0
Ly=2.d0
Lz=1.d0
xx=dindgen(nx)/(nx)*Lx-Lx/2.d0+Lx/nx/2.d0
yy=dindgen(ny)/(ny)*Ly-Ly/2.d0+Ly/ny/2.d0
zz=dindgen(nz)/(nz)*Lz-Lz/2.d0+Lz/nz/2.d0
xx=x[3:mx-4]
yy=y[3:my-4]
zz=z[3:mz-4]

end
'snoopy':begin
snoopyread, vx,vy, vz,bx,by,bz, xx3d,yy3d,zz3d,xx,yy,zz,nx,ny,nz,nfile, time
end

end


sbq=1.5
sbomega=1e-3
sba=-0.5*sbq*sbomega
vsh=2*sba
eps=1e-3
lx=2.0

xx3d=rebin(reform(xx,nx,  1,  1),nx,ny,nz) 
yy3d=rebin(reform(yy,  1,ny,  1),nx,ny,nz) 
zz3d=rebin(reform(zz,  1,  1,nz),nx,ny,nz) 
vshear=vsh*xx3d
scrh=lx*sbomega*eps/8.0
scrh=1e-7
;scrh=max(vx)/exp(0.75)
vmri=scrh*sin(2*!PI*zz3d)*exp(0.74975229*nfile)
scrh=max(vx)
vmri=scrh*sin(2*!PI*zz3d)
;; calc vorticity, x,y,z
;vortz=getvort(vx,vy,xx,yy,nx,ny)
;vorty=getvort(vx,vz,xx,zz,nx,nz)
;vortx1getvort(vy,vz,yy,zz,ny,nz)

vx0=vx
vy0=vy
vx=vx-vmri
vy=vy-vmri
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
vxsl = EXTRACT_SLICE(vx, nslice, nslice2,nx/2-.5, ny/2-.5, nz/2-.5,  plane_normal, xvec, OUT_VAL=0B, /radians)
vysl = EXTRACT_SLICE(vy, nslice, nslice2,nx/2-.5, ny/2-.5, nz/2-.5,   plane_normal, xvec, OUT_VAL=0B, /radians)
vzsl = EXTRACT_SLICE(vz, nslice, nslice2,nx/2-.5, ny/2-.5, nz/2-.5,   plane_normal, xvec, OUT_VAL=0B, /radians)

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

xbeg=0
xend=nslice-1
ybeg=1 ;+angleno/3
yend=nslice2-2 ;+angleno/3
data=vorty[xbeg:xend,ybeg:yend]

datptr=ptrarr(4)


datptr[0]=ptr_new(vxsl)
datptr[1]=ptr_new(vysl)
datptr[2]=ptr_new(vzsl)
datptr[3]=ptr_new(data)



datptr[0]=ptr_new(vpx)
datptr[1]=ptr_new(vpy)
datptr[2]=ptr_new(vpz)
datptr[3]=ptr_new(data)
!p.position=0

cvx=vpx[xbeg:xend,ybeg:yend]
cvy=vpz[xbeg:xend,ybeg:yend]

qx=25
qy=26
qz=26
sz=size(cvx, /dimensions)
xqx=findgen(sz(0))
yqy=findgen(sz(1))
cvx2=congrid(cvx,qx,qz)
cvz2=congrid(cvy,qx,qz)
cx=congrid(xqx,qx)
cz=congrid(yqy,qy)
;!p.multi=0
;window, 2
!p.multi=0
;!p.multi=[0,4,1]
;cgimage, vpx
;cgimage, reform(vx0[*,0,*])
;cgimage, vpz
;cgimage, reform(vmri[*,0,*])


for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times'
endif else  begin
set_plot, 'x'
endelse


cgloadct,33
pos=[0.1,0.15,0.9,0.9]
cbarchar=0.9
d=data[1:nx-2,*]
cgimage,d, background='white',  pos=pos
imin=min(data)
imax=max(data)
cgcolorbar, Position=[pos[0], pos[1]-0.07, pos[2], pos[1]-0.06], range=[imin,imax], format='(G8.1)', charsize=cbarchar
tag=string ( projangle*!radeg, format='(I02)')
cgcontour, data,xqx,yqy,/nodata,  /noerase, pos=pos, axiscolor=cgcolor('black'), $
	 ;title="Vorticity orthogonal to h , with velocity vectors", $
	 xtitle="x ", $
	 ytitle="z", charsize=cbarchar
velovect, cvx2,cvz2, cx,cz, /noerase, color=cgcolor('white'), thick=1.5 , len=2.5 , pos=pos, /overplot

ll=6
zero=''
nts=strcompress(string(nfile),/remove_all)
lnt=strlen(nts)
for j=1,ll-lnt do zero=zero+'0'
           fname=code+dirname+'vorticity'+tag+"_"+zero+nts

print, t
   cgText, 0.5, 0.95, ALIGNMENT=0.5, CHARSIZE=1.9, /NORMAL, $
      'Vorticity with velocity vectors'+', t='+string(time, format='(F5.1)')+' orbits', color='black'

if ( usingps ) then begin
cgps_close, /jpeg,  Width=1100
endif else begin
fname2=fname
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
