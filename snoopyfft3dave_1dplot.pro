   cgDisplay, WID=1,xs=1800, ys=1200, xpos=600, ypos=700
; load some sheared data

nfile=2

nsamp=19
nstart=400
nend=nstart+nsamp-1
snoopyread, vx,vy, vz,bx,by,bz, xx3d,yy3d,zz3d,xx,yy,zz,nx,ny,nz,nfile, time
timarr=dblarr(nsamp)
timeave=dblarr(nx,ny,nz)
tempim=dblarr(nx,ny,nsamp)
for nfile=nstart,nend do begin
snoopyread, vx,vy, vz,bx,by,bz, xx3d,yy3d,zz3d,xx,yy,zz,nx,ny,nz,nfile, time
timarr(nfile-nstart)=time
nx1=nx
nx2=ny
nx3=nz
x1=xx
x2=yy
x3=zz

t=findgen(nfile+1)
mytime=time
vec=(vx^2+vy^2+vz^2)
vec=(bx^2+by^2+bz^2)
vec=bz
vec=vx^2
xx=x1
yy=x2
xx2d=rebin(reform(xx,nx1,1),nx1,nx2)
yy2d=rebin(reform(yy,1,nx2),nx1,nx2)
xx3d=rebin(reform(xx,nx1,1,1),nx1,nx2,nx3)
yy3d=rebin(reform(yy,1,nx2,1),nx1,nx2,nx3)

vfft=fft(vec,2)
vfft=abs(vfft)

ky=[findgen(nx2/2), -nx2/2+findgen(nx2/2)]
ky2d=rebin(reform(ky,1,nx2),nx1,nx2)
ky3d=rebin(reform(ky,1,nx2,1),nx1,nx2,nx3)


q=1.5d
omega=1.0
S=q*omega
time=mytime
; dt is difference in time between this, and the nearest shear periodic point
;
dt=mytime mod  2.0d
dt=mytime mod  0.666666666666666666666666666666666666d
time=dt
print, 'time=',time,' dt=',dt
Ly=2.0
qomegat_Ly=q*omega*time/Ly

cfft1=fft(vec,dimension=2)
jimag=complex(0,1)
cfft1shift=cfft1*exp ( -jimag * ky3d * xx3d *2 *!PI *qomegat_Ly ) 
cfft2=fft(cfft1shift, dimension=1)
cfft3=fft(cfft2, dimension=3)
timeave=(timeave+abs(cfft3))/2.0d
nim=nfile-nstart
tempim(*,*,nim)=shift(alog10(abs(cfft3(*,*,0))^2),nx1/2,nx2/2)


ffttot=complexarr(nx1,nx2)
 shearfft2d, vec, ffttot, qomegat_Ly,x2d, nx1,nx2, x1


ifftmy=fft(cfft2, -1)
 rcfft2=real_part(ifftmy)

ifftshear=fft(ffttot,-1)
final=real_part(ifftshear)
endfor

dataptr=ptrarr(nsamp)

dataptr[ 0]=ptr_new(tempim(*,*,1))
dataptr[ 1]=ptr_new(shift(alog10(timeave(*,*,0)),nx1/2,nx2/2))
dataptr[ 2]=ptr_new(shift(alog10(abs(cfft3(*,*,0))),nx1/2,nx2/2))
dataptr[ 3]=ptr_new(tempim(*,*,1))
dataptr[ 4]=ptr_new(tempim(*,*,2))
dataptr[ 5]=ptr_new(tempim(*,*,3))
dataptr[ 6]=ptr_new(tempim(*,*,3))
dataptr[ 7]=ptr_new(final)
dataptr[ 8]=ptr_new(rcfft2)
dataptr[ 9]=ptr_new(rcfft2)
dataptr[10]=ptr_new(rcfft2)
dataptr[11]=ptr_new(final)
dataptr[12]=ptr_new(final)
dataptr[13]=ptr_new(final)
dataptr[14]=ptr_new(final)
dataptr[15]=ptr_new(final)

pos=[0.2,0.1,0.9,0.9]

titlestr=strarr(nsamp,30)
titlestr[ 0,*]='vz'
titlestr[ 1,*]='Averaged DFT of vz'
titlestr[ 2,*]='DFT t+0.01 orbits'
titlestr[ 3,*]='DFT t+0.02 orbits'
titlestr[ 4,*]='DFT t+0.03 orbits'
titlestr[ 5,*]='DFT t+0.04 orbits'
titlestr[ 6,*]='xx2d'
titlestr[ 7,*]='bz'
titlestr[ 8,*]='bz'
titlestr[ 9,*]='bz'
titlestr[10,*]='bz'
titlestr[10,*]='bz'
titlestr[10,*]='bz'
titlestr[10,*]='bz'
titlestr[10,*]='bz'
titlestr[10,*]='bz(z,t)'


  
fname="fftave18"+string(nfile, format='(I03)')
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet
endif else  begin
set_plot, 'x'
endelse


   pos = cglayout([1,2] , OXMargin=[2,2], OYMargin=[2,2], XGap=3, YGap=2)
     p = pos[*,0]

     d= tempim(*,*,0)
  cgplot, d[nx/2:nx-1,ny/2], pos=p, /noerase, yrange=[-4,-.01], xrange=[0,43], title='cuts of fft(vz) at t='+string(timarr(0))+' to '+string(timarr(nsamp-1)), charsize=cgDefCharsize()*0.5, ystyle=1

colors=[ 'blue', 'red', 'green', 'orange', 'black', 'yellow', 'pink','violet', 'brown', $
          'gray', 'ORG6','BLU4','BLU3','PUR8','PUR8 ','PUR8'  ,'PUR8'  ,'PUR8'    ]


   cgLoadCT, 33
   ;pos = cglayout([1,2] , OXMargin=[4,12], OYMargin=[5,6], XGap=9, YGap=2)
   FOR j=0,17 DO BEGIN
     d= tempim(*,*,j)
	r=cgscalevector(d, 1,254)
  ;   cgImage, r, NoErase=j NE 0, Position=p
  cgplot, d[nx/2:nx-1,ny/2], pos=p, /noerase,yrange=[-4,-.01], xrange=[0,43], /overplot, color=colors[j]
  ;cgcontour,xx#yy, xx,yy , /nodata, /noerase, xtitle='x', pos=p, title=titlestr(j), Charsize=cgDefCharsize()*0.5
  ;   cgColorBar, position=[p[2]+0.06, p[1], p[2]+0.07, p[3]],range=[imin-1e-6,imax+1e-6], Charsize=cgDefCharsize()*0.5 , /vertical
   ENDFOR
;   cgText, 0.5, 0.9, /Normal,  'vz and DFT(vz), t='+string(mytime), Alignment=0.5, Charsize=cgDefCharsize()*1.25

d=(shift(alog10(timeave(*,*,0)),nx1/2,nx2/2))
     p = pos[*,1]
  cgplot, d[nx/2:nx-1,ny/2], yrange=[-4,-0.01], xrange=[0,43], pos=p, /noerase, title='average of fft(vz) at t=',charsize=cgDefCharsize()*0.5, color='black'

if ( usingps ) then begin
;device,/close
cgps_close, /jpeg,  Width=2048
;set_plot,'x'
endif else begin
;set_plot,'x'
fname2=fname
;im=cgsnapshot(filename=fname2,/nodialog,/jpeg)
endelse

endfor





end
