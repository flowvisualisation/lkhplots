   cgDisplay, WID=1,xs=1600, ys=800, xpos=900, ypos=700
; load some sheared data


if ( 1 ) then begin
nstart=4
nend=22
nstep=1
;nstart=115
;nend=2000
;nstep=20
endif


for nfile=nstart,nend,nstep do begin
snoopyread, vx,vy, vz,bx,by,bz, xx3d,yy3d,zz3d,xx,yy,zz,nx,ny,nz,nfile, time
nx1=nx
nx2=ny
nx3=nz
x1=xx
x2=yy
x3=zz

t=findgen(nfile+1)
mytime=time
vec=sqrt(bx^2+by^2+bz^2)
vtag='b'
;vec=sqrt(vx^2+vy^2+vz^2)
;vtag='v'
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
;dt=mytime mod  6.0d
;dt=mytime mod  0.666666666666666666666666666666666666d
time=dt
;print, 'time=',time,' dt=',dt
Ly=2.0
qomegat_Ly=q*omega*time/Ly

cfft1=fft(vec,dimension=2)
jimag=complex(0,1)
cfft1shift=cfft1*exp ( -jimag * ky3d * xx3d *2 *!PI *qomegat_Ly ) 
cfft2=fft(cfft1shift, dimension=1)
cfft3=fft(cfft2, dimension=3)

pf1=alog10(abs(fft(vec,dimension=1)))
pf2=alog10(abs(fft(vec,dimension=2)))

ffttot=complexarr(nx1,nx2)
 shearfft2d, vec, ffttot, qomegat_Ly,x2d, nx1,nx2, x1


ifftmy=fft(cfft3, -1)
 rcfft2=real_part(ifftmy)
 final=rcfft2

ifftshear=fft(cfft3,-1)
unshear=real_part(ifftshear)

dataptr=ptrarr(18)


qxq=reform(abs(cfft3(nx-1,*,*)))
sl2=reform(abs(cfft3(*,0,*)))
sl3=reform(abs(cfft3(*,*,0)))

for i=0,nx-1 do begin
    qxq(i,*)=abs(cfft3(i,i,*))
endfor

    qcfft=shift(cfft3,-1,0,0)
for i=0,nx-1 do begin
    sl2(i,*)=abs(qcfft(i,nx-i-1,*))
endfor

;qxq=qxq^2
fsl=reform(smooth(shift(qxq,nx2/2,nx3/2),1, /edge_wrap))
fsl2=reform(smooth(shift(sl2,nx1/2,nx3/2),1, /edge_wrap))
fsl3=reform(smooth(shift(sl3,nx1/2,nx2/2),1, /edge_wrap))
zmn=0.4
zmx=0.6
zmn=0.3
zmx=0.7
fslzoom=fsl[nx2*zmn:nx2*zmx, nx3*zmn:nx3*zmx]
fsl2zoom=fsl2[nx1*zmn:nx1*zmx, nx3*zmn:nx3*zmx]
fsl3zoom=fsl3[nx1*zmn:nx1*zmx, nx2*zmn:nx2*zmx]

sz=size(fslzoom, /dimensions)
k1=findgen(sz(0))-sz(0)/2
k2=findgen(sz(1))-sz(1)/2
k3=findgen(sz(1))-sz(1)/2
sz=size(fsl2zoom, /dimensions)
;k1=findgen(sz(0))-sz(0)/2
;k3=findgen(sz(1))-sz(1)/2

k1arr=ptrarr(3)
k1arr[0]=ptr_new(k1)
k1arr[1]=ptr_new(k1)
k1arr[2]=ptr_new(k1)

k2arr=ptrarr(3)
k2arr[0]=ptr_new(k3)
k2arr[1]=ptr_new(k3)
k2arr[2]=ptr_new(k1)


dataptr[ 0]=ptr_new(final(*,*,nz/2) )
dataptr[ 0]=ptr_new(fslzoom)
dataptr[ 1]=ptr_new(fsl2zoom)
dataptr[ 2]=ptr_new(fsl3zoom)
dataptr[ 3]=ptr_new(pf1)
dataptr[ 4]=ptr_new(pf2)
dataptr[ 5]=ptr_new(ky2d)
dataptr[ 6]=ptr_new(xx2d)
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



titlestr=strarr(18,30)
titlestr[ 0,*]='DFT V(k!Dp!N,k!Dz!N)'
titlestr[ 1,*]='DFT V(k!Dh!N,k!Dz!N)'
titlestr[ 2,*]='DFT V(k!Dx!N,k!Dy!N)'
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

xtitlestr=strarr(18,30)
xtitlestr[ 0,*]='k!Dp!N'
xtitlestr[ 1,*]='k!Dh!N'
xtitlestr[ 2,*]='k!Dx!N'

ytitlestr=strarr(18,30)
ytitlestr[ 0,*]='k!Dz!N'
ytitlestr[ 1,*]='k!Dz!N'
ytitlestr[ 2,*]='k!Dy!N'
  

posarr=fltarr(4,3)
posarr[*,0]=[0.1,0.12,0.45,0.43]
posarr[*,1]=[0.1,0.56,0.45,0.9]
posarr[*,2]=[0.55,0.12,0.9,0.9]

fname=vtag+"dft1dcuts"+string(nfile, format='(I04)')
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet
endif else  begin
set_plot, 'x'
endelse





;   cgLoadCT, 33
;   pos = cglayout([3,1] , OXMargin=[4,7], OYMargin=[5,5], XGap=8, YGap=2)
;   FOR j=0,2 DO BEGIN
;     p = pos[*,j]
;     p = posarr[*,j]
;     d= alog10(*dataptr(j))
;	r=cgscalevector(d, 1,254)
;	imin=min(*dataptr[j])
;	imax=max(*dataptr[j])
;    ; cgimage, r, NoErase=j NE 0, Position=p
;    ttag='                         '
;    if ( j eq 2 ) then begin
;    ttag=', t='+string(mytime,format='(F6.2)')+' orbits'
;    endif
;
;  cgcontour,d, $
;  *k1arr[j],*k2arr[j] , $
;  ;/nodata,
;   /noerase, $ 
;    ;/c_Colors,$
;    nlev=20,$
;    /fill, $
;    xtitle=xtitlestr(j), $
;    ytitle=ytitlestr(j), $
;    pos=p,$
;    title=titlestr(j)+ttag,$
;    Charsize=cgDefCharsize()*0.6
;    gft=gauss2dfit(d, aa,/tilt)
;    cgloadct,33
;    tvlct,255,255,255,255
;    cgcontour, gft, *k1arr[j],*k2arr[j], /overplot, pos=p, color='Black'
;     cgcolorBar, position=[p[2]+0.03, p[1], p[2]+0.04, p[3]],range=[imin-1e-6,imax+1e-6], Charsize=cgDefCharsize()*0.5 , /vertical
;   ENDFOR
;   ;cgText, 0.5, 0.9, /Normal,  'vz and DFT(vz), t='+string(mytime), Alignment=0.5, Charsize=cgDefCharsize()*1.25
;
    qq=reform(*dataptr(0))
        sz=size(qq, /dimensions)
        qx=sz(0)
        qy=sz(1)
        wns=findgen(qx)+1
    spec1=findgen(qx/2)
    spec2=findgen(qx/2)
    k1=findgen(qx)-qx/2
    k2=findgen(qy)-qy/2
    k11=rebin(reform(k1,qx,1),qx,qy)
    k22=rebin(reform(k2,1,qy),qx,qy)
    kr=sqrt(k11^2+k22^2)
    radave=fltarr(qx/2)
    radave(*)=0.0


    for  zi = 0,qx/2-1 do begin
;        spec1(zi) = qq(qx/2+zi, qy/2+zi)
;        spec2(zi) = qq(qx/2+zi, qy/2-zi)
    endfor

    for i=0, qx-1 do begin
    for j=0, qy-1 do begin
    disp=kr(i,j) 
    if ( disp lt qx/2-1 ) then begin 
int_disp=round(disp)
int_disp=fix(disp)
;print, int_disp, i,j, disp, int_disp, vec(i,j)

radave(int_disp)= radave(int_disp)+qq(i,j)/2/!DPI/kr(i,j)

    endif

    endfor
    endfor

    colors=['red', 'blue', 'green', 'orange', 'turquoise', 'black']
    items=['k!Dp!N', 'k!Dh!N', 'k!Dz!N', '-5/3', '-4/3', 'ave']
    lines=[0,0,0,0,0,0]
    ;power3d,unshear, /noplot, spec=spec, wns=wave

ymin=min(spec1)
ymax=max(spec1)
!p.multi=[0,1,3]
!p.multi=0
k1=findgen(ny/2)+1
kz=findgen(nz/2)+1
x=alog10(k1)
y=alog10( qxq(0:ny/2-1,0))
cgplot, x, y,   xrange=[1e-3,2.2], title='t='+string (mytime,format='(F4.2)')+' orbits', yrange=[-11,0], color=colors[0]

measure_errors = SQRT(ABS(Y))
result1 = LINFIT(X, Y, MEASURE_ERRORS=measure_errors)


cgplot, x, result1(0)+result1(1)*x, /overplot, color=colors[0]
cgplot, x, (-7./3.)*x, /overplot, color=colors[3]

gmz=reverse(sl2(*,0))
x=alog10(k1)
y=alog10( gmz(0:ny/2-1,0))
cgplot, x,y, /overplot, color=colors[1], linestyle=lines[1]
measure_errors = SQRT(ABS(Y))
result2 = LINFIT(X, Y, MEASURE_ERRORS=measure_errors)

cgplot, x, result2(0)+result2(1)*x, /overplot, color=colors[1]

x=alog10(kz)
y=alog10( reform(qxq(0,0:nz/2-1)))
cgplot, x,y, /overplot, color=colors[2];, linestyle=lines[2]
measure_errors = SQRT(ABS(Y))
result3 = LINFIT(X, Y, MEASURE_ERRORS=measure_errors)
cgplot, x, result3(0)+x*result3(1), /overplot, color=colors[2]

;print, qxq(0,0), gmz(0)
if (usingps eq 1) then begin
print, "fits ", (mytime), result1[1],result2[1], result3[1]
endif
    ;cgplot,wns, smooth(spec1,2), pos=pos[*,1], /noerase,  xrange=[0.9,37], xtitle="k!DR!N", ytitle="V!DZ!N" , /xlog, Charsize=cgDefCharsize()*0.6, /ylog, yrange=[ymin,ymax], color=colors[0]
    ;cgplot,wns, smooth(spec2,2), pos=pos[*,1], /noerase, /overplot, color=colors[1]
    ;cgplot, wns , 0.01*wns^(-7./3.), pos=pos[*,1], /noerase, /overplot, color=colors[2], linestyle=lines[2]
    ;cgplot, wns , 0.01*wns^(-5./3.), pos=pos[*,1], /noerase, /overplot, color=colors[3], linestyle=lines[3]
;    cgplot, wns , 0.001*wns^(-4./3.), pos=pos[*,1], /noerase, /overplot, color=colors[4], linestyle=lines[4]
    ;cgplot, wns , max(spec1)*spec/max(spec), pos=pos[*,1], /noerase, /overplot, color=colors[5], linestyle=lines[5]
;    cgplot, wns , spec, pos=pos[*,1], /noerase, /overplot, color=colors[5], linestyle=lines[5]
;     cgplot, wns, radave, /overplot



    al_legend, items[0:3], colors=colors[0:3], linestyle=lines[0:3], Charsize=cgDefCharsize()*0.4, /right

if ( usingps ) then begin
cgps_close, /jpeg,  Width=2048, /nomessage
endif else begin
fname2=fname
;im=cgsnapshot(filename=fname2,/nodialog,/jpeg)
endelse

endfor


endfor



end
