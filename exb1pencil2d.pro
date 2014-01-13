;pro exvort9, nfile, vx1,vx2,vx3, rho, prs, t , nlast, nx1,nx2,nx3,x1,x2,x3, dx1,dx2, vorty, vpx,vpz, vmri, vshear, vx,vy,vz, vxsl, vysl
set_plot,'x'
  cgDisplay, WID=1,xs=1500, ys=900

pluto=0
nfile=1
x=2
 
omega=1
  !X.OMargin = [2, 6]
   !Y.OMargin = [2, 6]
;!p.multi=[0,3,2]

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

bx=f0.bb[*,*,0]
by=f0.bb[*,*,1]
bz=f0.bb[*,*,2]
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
bmri=scrh*sqrt(5./3.)*cos(2*!PI*zz3d)*exp(0.74975229*nfile)
scrh=max(vx)
vmri=scrh*sin(2*!PI*zz3d)
scrh=max(bx)
bmri=scrh*cos(2*!PI*zz3d)
;; calc vorticity, x,y,z

vx0=vx
vy0=vy
vx=vx -vmri
vy=vy -vmri

bx0=bx
by0=by
bx=bx -bmri
by=by +bmri



vxsl=reform(vx(*,*))
vysl=reform(vy(*,*))
vzsl=reform(vz(*,*))



cgloadct,33





vpx=vxsl ;*unitvec1 + vysl*unitvec2
vpy=vxsl ;*unitvec2 - vysl*unitvec1
vpz=vzsl

mvpx=max(vpx)

vorty=getvort(vx,vz,xx,zz,nx,nz)
curry=getvort(bx,bz,xx,zz,nx,nz)
pos=[0.1,0.1,0.9,0.9]

xbeg=0
xend=nx-1
ybeg=1 ;+angleno/3
yend=nz-2 ;+angleno/3

data=vorty[xbeg:xend,ybeg:yend]
datptr=ptrarr(6)

datptr[0]=ptr_new(vorty[xbeg:xend,ybeg:yend] )
datptr[1]=ptr_new(curry[xbeg:xend,ybeg:yend] )
datptr[2]=ptr_new(vx[xbeg:xend,ybeg:yend] )
datptr[3]=ptr_new(vz[xbeg:xend,ybeg:yend] )
datptr[4]=ptr_new(bx[xbeg:xend,ybeg:yend] )
datptr[5]=ptr_new(bz[xbeg:xend,ybeg:yend] )



ll=6
zero=''
nts=strcompress(string(nfile),/remove_all)
lnt=strlen(nts)
for j=1,ll-lnt do zero=zero+'0'
           fname='vorticity_cur_pencil'+"_"+zero+nts

for usingps=0,1 do begin

if ( usingps ) then begin
;set_plot,'ps'
;device,filename=fname+'.eps',/encapsulated
;device, /color
!p.font=0
;device, /times
xs=8
ys=5
;DEVICE, XSIZE=xs, YSIZE=ys, /INCHES
!p.charsize=0.6
cbarchar=0.6
xyout=1.0
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times'
endif else begin
if ( keyword_set (zbuf) ) then begin
set_plot,'z'
ys=600+600*ar
xs=2400-ar*400
device, set_resolution=[1100,800]
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




  poscg = cglayout([2,1] , OXMargin=[5,2], OYMargin=[5,2], XGap=5, YGap=7, aspect=1.0)

;cgimage, bx,noerase,   pos=poscg[*,0]
;cgimage, reform(vx0[*,0,*])
;cgimage, bz, noerase=1,  pos=poscg[*,1]
 for j=0,1 do begin
cvx=*datptr[2+2*j]
cvy=*datptr[3+2*j]
print, 'gmtest' ,2+2*j, 3+2*j
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
;cgimage, curry,noerase=0,   pos=poscg[*,0]
;cgcolorbar, Position=[pos[0], pos[1]-0.05, pos[2], pos[1]-0.04], range=[imin,imax], format='(G8.1)', charsize=cbarchar
cgloadct,33
cgimage,*datptr[j], noerase=j ne 0,  pos=poscg[*,j]
imin=min(*datptr[j])
imax=max(*datptr[j])
pos=poscg[*,j]
cgcolorbar, Position=[pos[0], pos[1]-0.08, pos[2], pos[1]-0.06], range=[imin,imax], format='(G8.1)', charsize=cbarchar
cgcontour, data,xqx,yqy,/nodata,  /noerase, pos=poscg[*,j], axiscolor=cgcolor('black'), $
	 ;title="Vorticity orthogonal to h , with velocity vectors", $
	 xtitle="x ", $
	 ytitle="z"
velovect, cvx2,cvz2, cx,cz, /noerase, color=cgcolor('white'), thick=1.5 , len=2.5 , pos=poscg[*,j], /overplot
endfor

print, t
   cgText, 0.5, 0.95, ALIGNMENT=0.5, CHARSIZE=xyout, /NORMAL, $
      'Vorticity with velocity vectors, Current with magnetic field '+', t='+string(t(nfile)*omega, format='(F5.1)')+' orbits', color='black'



if ( usingps ) then begin
;device,/close
cgps_close, /jpeg,  Width=1100
;set_plot,'x'
endif else begin
;set_plot,'x'
fname2=fname
;im=cgsnapshot(filename=fname2,/nodialog,/jpeg)
endelse



endfor


endfor

;window, 7
;cgplot, backgroundshear1



set_plot, 'x'
  !Y.OMargin = [0, 0]
   !X.OMargin = [0, 0]
end
