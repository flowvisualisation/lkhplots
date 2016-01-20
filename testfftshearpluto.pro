; load some sheared data

nfile=20
plutoread,dens, vx,vy, vz,bx,by,bz, xx3d,yy3d,zz3d,xx,yy,zz,nx,ny,nz,nfile, time
nx1=nx
nx2=ny
x1=xx
x2=yy
time=nfile*1.0

t=findgen(nfile+1)
vec=vz(*,*,0)*1.0d
xx=x1
yy=x2
xx2d=rebin(reform(xx,nx1,1),nx1,nx2)
yy2d=rebin(reform(yy,1,nx2),nx1,nx2)

vfft=fft(vec,2)
vfft=abs(vfft)

ky=[dindgen(nx2/2), -nx2/2+dindgen(nx2/2)]
ky2d=rebin(reform(ky,1,nx2),nx1,nx2)


q=1.5d
omega=1.0d
S=q*omega
time=t[nfile] 
;time=19.5
print, 'time',time
time=t[nfile] mod  2.0d
dt=t[nfile] mod  2.0d
print, 'time',time, 'dt', dt
Ly=x2[nx2-1]+x2[0]
qomegat_Ly=q*omega*time/Ly

cfft1=fft(vec,dimension=2, /double)
jimag=complex(0.0d,1.0d)
cfft1shift=cfft1*exp (  jimag * ky2d * xx2d *2 *!DPI *qomegat_Ly ) 
cfft2=fft(cfft1shift, dimension=1, /double)

pf1=alog10(abs(fft(vec,dimension=1, /double)))
pf2=alog10(abs(fft(vec,dimension=2, /double)))

ffttot=complexarr(nx1,nx2)
 shearfft2d, vec, ffttot, qomegat_Ly,x2d, nx1,nx2, x1


ifftmy=fft(cfft2, -1, /double)
 rcfft2=real_part(ifftmy)

ifftshear=fft(ffttot,-1, /double)
final=real_part(ifftshear)

dataptr=ptrarr(18)

dataptr[ 0]=ptr_new(vec)
dataptr[ 1]=ptr_new(vec)
dataptr[ 2]=ptr_new(vfft)
dataptr[ 3]=ptr_new(pf1)
dataptr[ 4]=ptr_new(pf2)
dataptr[ 5]=ptr_new(ky2d)
dataptr[ 6]=ptr_new(xx2d)
dataptr[ 7]=ptr_new(final)
dataptr[ 8]=ptr_new(rotate(rcfft2,2))
dataptr[ 9]=ptr_new(rotate(rcfft2,2))
dataptr[10]=ptr_new(shift(abs(cfft2),nx1/2,nx2/2))
dataptr[11]=ptr_new(alog10(shift(abs(cfft2),nx1/2,nx2/2)))
dataptr[12]=ptr_new(final)
dataptr[13]=ptr_new(final)
dataptr[14]=ptr_new(final)
dataptr[15]=ptr_new(final)

pos=[0.2,0.1,0.9,0.9]

titlestr=strarr(18,30)
titlestr[ 0,*]='vz'
titlestr[ 1,*]='vz'
titlestr[ 2,*]='fft(vz)'
titlestr[ 3,*]='fft dimension 1'
titlestr[ 4,*]='fft dimension 2'
titlestr[ 5,*]='ky2d'
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


   cgDisplay, WID=1,xs=1800, ys=700, xpos=100, ypos=700
  
fname="first_sheartest"
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet
endif else  begin
set_plot, 'x'
endelse





   cgLoadCT, 33
   pos = cglayout([8,2] , OXMargin=[4,12], OYMargin=[5,5], XGap=0, YGap=4)
   FOR j=0,15 DO BEGIN
     p = pos[*,j]
     d= *dataptr(j)
	r=cgscalevector(d, 1,254)
	imin=min(*dataptr[j])
	imax=max(*dataptr[j])
     cgImage, r, NoErase=j NE 0, Position=p
  cgcontour,xx#yy, xx,yy , /nodata, /noerase, xtitle='x', pos=p, title=titlestr(j), Charsize=cgDefCharsize()*0.5
     ;cgColorBar, position=[p[2]+0.06, p[1], p[2]+0.07, p[3]],range=[imin-1e-6,imax+1e-6], Charsize=cgDefCharsize()*0.5 ;, /vertical
   ENDFOR
   cgText, 0.5, 0.96, /Normal,  'FFT testing', Alignment=0.5, Charsize=cgDefCharsize()*1.25


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





end
