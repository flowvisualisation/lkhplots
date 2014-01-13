;pro exvort9, nfile, vx1,vx2,vx3, rho, prs, t , nlast, nx1,nx2,nx3,x1,x2,x3, dx1,dx2, vorty, vpx,vpz, vmri, vshear, vx,vy,vz, vxsl, vysl
pluto=0
nfile=1
x=2
 
omega=1
  !X.OMargin = [2, 6]
   !Y.OMargin = [2, 6]
window, 0, xs=1700, ys=900
;!p.multi=[0,3,2]

!p.charsize=2
nbeg=1
;nend=nlast
nend=11
t=findgen(nend+1)

for nfile=nbeg,nend,1 do begin

if ( pluto eq 1) then begin

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
endif else begin


path='data/proc0/'
varfile='VAR'+str(nfile)
if ( (pluto eq 0 )  and (file_test(path+varfile)  eq 0 )) then begin
print, varfile+' does not exist, exiting gm'
endif
pc_read_var, obj=f0, varfile=varfile, /trimall, /bb
vx=f0.uu[*,*,0]
vy=f0.uu[*,*,1]
vz=f0.uu[*,*,2]
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

endelse

sbq=1.5
sbomega=1e-3
sba=-0.5*sbq*sbomega
vsh=2*sba
eps=1e-3
lx=2.0

xx3d=rebin(reform(xx,nx,    1),nx,nz) 
zz3d=rebin(reform(zz,  1,  nz),nx,nz) 
vshear=vsh*xx3d
scrh=lx*sbomega*eps/8.0
scrh=1e-7
;scrh=max(vx)/exp(0.75)
vmri=scrh*sin(2*!PI*zz3d)*exp(0.74975229*nfile)
scrh=max(vx)
vmri=scrh*sin(2*!PI*zz3d)
;; calc vorticity, x,y,z

vx0=vx
vy0=vy
vx=vx-vmri
vy=vy-vmri
;vx=vx;-vmri
;vy=vy;-vshear-vmri
;; extract slices




vxsl=reform(vx(*,*))
vysl=reform(vy(*,*))
vzsl=reform(vz(*,*))



cgloadct,33





vpx=vxsl ;*unitvec1 + vysl*unitvec2
vpy=vxsl ;*unitvec2 - vysl*unitvec1
vpz=vzsl

mvpx=max(vpx)

vorty=getvort(vpx,vpz,xx,zz,nx,nz)
;!p.position=0
pos=[0.1,0.1,0.9,0.9]

xbeg=0
xend=nx-1
ybeg=1 ;+angleno/3
yend=nz-2 ;+angleno/3
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

;cgcontour, data, /nodata, /overplot
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
cgimage,data, background='white',  pos=pos
imin=min(data)
imax=max(data)
cgcolorbar, Position=[pos[0], pos[1]-0.05, pos[2], pos[1]-0.04], range=[imin,imax], format='(G8.1)', charsize=cbarchar
tag=string ( !radeg, format='(I02)')
cgcontour, data,xqx,yqy,/nodata,  /noerase, pos=pos, axiscolor=cgcolor('black'), $
	 ;title="Vorticity orthogonal to h , with velocity vectors", $
	 xtitle="x ", $
	 ytitle="z"
velovect, cvx2,cvz2, cx,cz, /noerase, color=cgcolor('white'), thick=1.5 , len=2.5 , pos=pos

ll=6
zero=''
nts=strcompress(string(nfile),/remove_all)
lnt=strlen(nts)
for j=1,ll-lnt do zero=zero+'0'
           fname='vorticity'+tag+"_"+zero+nts

print, t
   cgText, 0.5, 0.95, ALIGNMENT=0.5, CHARSIZE=2.25, /NORMAL, $
      'Vorticity with velocity vectors'+', t='+string(t(nfile)*omega, format='(F5.1)')+' orbits', color='black'

im=cgsnapshot(filename=fname, /nodialog, /jpeg)
endfor

;window, 7
;cgplot, backgroundshear1


!p.position=0
!p.multi=0

  !Y.OMargin = [0, 0]
   !X.OMargin = [0, 0]
end
