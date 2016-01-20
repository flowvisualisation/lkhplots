qsm=3
   cgDisplay, WID=1,xs=2100, ys=1100, xpos=200, ypos=700
   mychar=1.1


psum=findgen(256)
psum(*)=0.
zsum=findgen(256)
zsum(*)=0.
maxsum=findgen(256)
maxsum(*)=0.
minsum=findgen(256)
minsum(*)=0.
zave=findgen(256)
zave(*)=0.
maxave=findgen(256)
maxave(*)=0.
minave=findgen(256)
minave(*)=0.
pave=findgen(256)
pave(*)=0.
ave=0

cgerase
if ( 1 ) then begin
nstart=4
nstep=2
nend=260
;nstart=258
nstep=2
;nstart=115
;nend=2000
;nstep=20
endif

   posx = cglayout([3,2] , OXMargin=[4,1], OYMargin=[4,1], XGap=3, YGap=2)
   ;posx = fltarr(4,4)
   !p.multi=[0,1,4]
   kx=findgen(181)+1
   b=findgen(100)+1e-6

j=0
!p.charsize=2.9
   cgplot, kx,b,/xlog, /ylog,/nodata, pos=posx[*,j], /noerase, xstyle=1
   p1 = !P & px1 = !X & py1 = !Y
j=1
   cgplot, kx,b,/xlog, /ylog,/nodata, pos=posx[*,j], /noerase, xstyle=1
   p2 = !P & px2 = !X & py2 = !Y
j=2
   cgplot, kx,b,/xlog, /ylog,/nodata, pos=posx[*,j], /noerase, xstyle=1
   p3 = !P & px3 = !X & py3 = !Y
j=3
   cgplot, kx,b,/xlog, /ylog,/nodata, pos=posx[*,j], /noerase, xstyle=1
   p4 = !P & px4 = !X & py4 = !Y

j=4
   cgplot, 128+findgen(128),128+findgen(128),/nodata, pos=posx[*,j], /noerase, xstyle=1, ystyle=1, yrange=[0,256]
   p5 = !P & px5 = !X & py5 = !Y
j=5
   cgplot, kx,b,/xlog, /ylog,/nodata, pos=posx[*,j], /noerase, xstyle=1,yrange=[1e-8,1e2]
   p6 = !P & px6 = !X & py6 = !Y
for nfile=nstart,nend,nstep do begin

;print, nfile
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
vtag2='B!U2!N'
vtag='b'
if ( 1 ) then begin
vec=(bx*by)
vtag2='B!Dx!NB!Dy!N'
vtag='bxby'
endif
;vec=(vx*vy)
;vtag='vxvy'
;vec=(-vx*vy+bx*by)
;vtag='total'
;vec=(vx^2+vy^2+vz^2)
;vtag='v'
vec=vec ;-mean(vec)
xx=x1
yy=x2
xx2d=rebin(reform(xx,nx1,1),nx1,nx2)
yy2d=rebin(reform(yy,1,nx2),nx1,nx2)
xx3d=rebin(reform(xx,nx1,1,1),nx1,nx2,nx3)
yy3d=rebin(reform(yy,1,nx2,1),nx1,nx2,nx3)


ky=[findgen(nx2/2), -nx2/2+findgen(nx2/2)]
kvxvyy2d=rebin(reform(ky,1,nx2),nx1,nx2)
ky3d=rebin(reform(ky,1,nx2,1),nx1,nx2,nx3)


q=1.5d
omega=1.0
S=q*omega
time=mytime
; dt is difference in time between this, and the nearest periodic point
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

dataptr=ptrarr(18)

ftsq=abs(cfft3)^2
smftsq=smooth(ftsq,qsm, /edge_wrap)
shftft=shift(smftsq,nx/2,ny/2,nz/2)

qxq=reform(abs(cfft3(nx-1,*,*))^2)
sl2=reform(abs(cfft3(*,0,*))^2)
sl3=reform(abs(cfft3(*,*,0))^2)

for i=0,nx-1 do begin
    qxq(i,*)=abs(cfft3(i,i,*))
endfor

    qcfft=shift(cfft3,-1,0,0)
for i=0,nx-1 do begin
    sl2(i,*)=abs(qcfft(i,nx-i-1,*))
endfor

;qxq=qxq^2
fsl =reform(smooth(shift(qxq,nx2/2,nx3/2),qsm ))
fsl2=reform(smooth(shift(sl2,nx1/2,nx3/2),qsm ))
fsl3=reform(smooth(shift(sl3,nx1/2,nx2/2),qsm ))
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
k1arr[0]=ptr_new(sqrt(2)*k1)
k1arr[1]=ptr_new(sqrt(2)*k1)
k1arr[2]=ptr_new(k1)

k2arr=ptrarr(3)
k2arr[0]=ptr_new(2*k3)
k2arr[1]=ptr_new(2*k3)
k2arr[2]=ptr_new(k1)


dataptr[ 0]=ptr_new(fsl2zoom)
dataptr[ 1]=ptr_new(fslzoom)
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




titlestr=strarr(18,30)
titlestr[ 0,*]='DFT '+vtag+'(k!Dp!N,k!Dz!N)'
titlestr[ 1,*]='DFT '+vtag+'(k!Dh!N,k!Dz!N)'
titlestr[ 2,*]='DFT '+vtag+'(k!Dx!N,k!Dy!N)'
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
xtitlestr[ 0,*]='k!Dh!NL'
xtitlestr[ 1,*]='k!Dp!NL'
xtitlestr[ 2,*]='k!Dx!NL'

ytitlestr=strarr(18,30)
ytitlestr[ 0,*]='k!Dz!NL'
ytitlestr[ 1,*]='k!Dz!NL'
ytitlestr[ 2,*]='k!Dy!NL'
  

posarr=fltarr(4,3)

ytop=0.98
ymid=0.48
ymid2=0.68
ydown=0.18
xmid1=0.49
xbeg=0.10
xend=0.95
;print, ytop-ymid2, ymid-ydown
posarr[*,0]=[xbeg,ydown,xmid1,ymid]
posarr[*,1]=[xbeg,ymid2,xmid1,ytop]
posarr[*,2]=[0.59,ydown,xend,ytop]

fname=vtag+"dft3cuts"+string(nfile, format='(I04)')
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet
endif else  begin
set_plot, 'x'
endelse


;cgerase



   cgLoadCT, 33

    ;print,tp[2]-tp[0], tp[3]-t[1]
 
   ;cgText, 0.5, 0.9, /Normal,  'vz and DFT(vz), t='+string(mytime), Alignment=0.5, Charsize=cgDefCharsize()*1.25

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
    items=['+45', '-45', '-7/3', '-5/3', '-4/3', 'ave']
    lines=[0,0,1,1,1,0]
    ;power3d,unshear, /noplot, spec=spec, wns=wave

ymin=min(spec1)
ymax=max(spec1)





dsx=128
cut45=fltarr(dsx)
cut135=fltarr(dsx)
powave =fltarr(ny,2)
for i=0,dsx-1 do begin

cut45[i]=shftft[nx/2+i,ny/2+i,nz/2]
cut135[i]=shftft[nx/2+i,ny/2-i,nz/2]
endfor





vcut=reform(shftft[nx/2,ny/2,nz/2:nz-1])


square=congrid(shftft,nx,ny,ny)

for i=0,nx/2-1 do begin
for j=0,ny/2-1 do begin
for k=0,ny/2-1 do begin


rad=sqrt(1.*i^2 +1.*j^2 +1.*(k)^2)

radint=round(rad)

powave[radint] += square[nx/2+i,ny/2+j,ny/2+k]/rad^2/!DPI/2

endfor
endfor
endfor

if (usingps eq 0) then begin

dat=alog10(*dataptr(2))
;dat=fsl3
    gft=gauss2dfit(dat, aa,/tilt)

angle=aa[6]
    
if ( (angle gt  !DPI/2.) and (angle lt  !DPI)) then angle = angle-!DPI/2.0d
if ( (angle lt   0) and (angle gt  -!DPI/2)) then angle = angle+!DPI/2.0d
if ( (angle lt -!DPI/2.) and (angle gt -!DPI)) then angle = angle+!DPI
angle=!PI/2-angle



print, ' gm angle ', nfile,  angle*!RADEG
endif

dat=fsl3


for  i=-nx/2,(nx-1)/2  do begin
for  j=-ny/2,(ny-1)/2  do begin

rad=sqrt(1.*i^2 +1.*j^2 )
if (rad gt (nx-1)/3) then begin
dat[nx/2+i,ny/2+j]=0
endif

endfor
endfor

;display, alog10(dat+1e-8)
;stop

sz=size(  dat, /dimensions)
nxq=sz(0)
nyq=sz(1)
xq=findgen(nxq/2)*cos(angle)+nxq/2
yq=findgen(nyq/2)*sin(angle)+nyq/2
yq1=yq
   maxstress=interpolate (dat ,xq,yq)
;xq= findgen(nyq/2)*cos(-!DPI/2+angle)+nyq/2
;yq= findgen(nyq/2)*sin(-!DPI/2+angle)+nyq/2

xq2=yq
yq2=-xq+nyq
   pmaxstress=interpolate (dat ,xq2,yq2)

vcut=reform(shftft[nx/2,ny/2,nz/2:nz-1])
   ;zstress=interpolate(vcut,  )


   zsum=zsum+vcut
   psum=psum+powave
   maxsum=(maxsum+maxstress)
   minsum=(minsum+pmaxstress)
   ave=ave+1
   pave=(psum)/(ave)
   zave=(zsum)/(ave)
   maxave=(maxsum)/(ave)
   minave=(minsum)/(ave)


k1=findgen(120)+1

colors=['red', 'blue', 'green', 'black', 'turquoise', 'black']
    items=['k!Dp!N', 'k!Dh!N', 'k!Dz!N', 'k!Dr!N', '-4/3', 'ave']
    lines=[0,0,0,0,0,0]


k1h=k1
yrmax=1e2
yrmin=1e-6
if ( vtag eq 'bxby' ) then begin
yrmax=1e1
yrmin=1e-5
endif
!P = p1 & !X = px1 & !Y = py1
cgplot,k1h, k1h*maxstress , /overplot,  color=colors[0]
    ;/xlog, /ylog, xrange=[1,128],yrange=[yrmin,yrmax], 
    ;ytickformat='logticks_exp',$
    ;linestyle=lines[0], xtitle='kL', ytitle='log!D10!Nk|DFT('+vtag2+')|!U2!N', pos=[mp[0]+0.03,mp[1],mp[2],mp[3]],/noerase, charsize=mychar
    !P = p2 & !X = px2 & !Y = py2
cgplot,k1h, k1h*pmaxstress, /overplot , color=colors[1], linestyle=lines[1]

k1h=k1*2
!P = p3 & !X = px3 & !Y = py3
cgplot,k1h, k1h*vcut, /overplot , color=colors[2], linestyle=lines[2]
!P = p4 & !X = px4 & !Y = py4
cgplot,k1, k1*powave, /overplot , color=colors[3], linestyle=lines[3]
!P = p5 & !X = px5 & !Y = py5
cgplot,(xq), (yq),/overplot,  color=colors[0], linestyle=lines[3]
cgplot,(xq2), (yq2),/overplot,  color=colors[1], linestyle=lines[3]
!P = p6 & !X = px6 & !Y = py6
cgplot,xq(*)-128, maxave, /overplot , color=colors[0], linestyle=lines[0]
;cgplot,xq(*)-128, maxave, pos=posx[*,5] , color=colors[0], linestyle=lines[0], /xlog, /ylog
cgplot,xq(*)-128, minave, /overplot , color=colors[1], linestyle=lines[1]
cgplot,k1h, vcut, /overplot , color=colors[2], linestyle=lines[2]
 ;al_legend, items[0:3], colors=colors[0:3], linestyle=lines[0:3], Charsize=mychar,linsize=0.15,$
    ;/right,$
    ;pos=[13,yrmax],$
    ;box=0
   

if ( usingps ) then begin
cgps_close, /jpeg,  Width=2048, /nomessage
endif else begin
fname2=fname
im=cgsnapshot(filename='tst'+fname2,/nodialog,/jpeg)
endelse
endfor

endfor



end
