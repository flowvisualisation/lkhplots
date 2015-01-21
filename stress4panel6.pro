qsm=3
   cgDisplay, WID=1,xs=2100, ys=600, xpos=200, ypos=700
   mychar=1.1

if ( 1 ) then begin
nstart=40
nstep =10
nend  =50
;nstart=115
;nend=2000
;nstep=20
endif


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
vec=(bx^2+by^2+bz^2)
vtag2='B!U2!N'
vtag='b'
if ( 0 ) then begin
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


dataptr[ 0]=ptr_new(fslzoom)
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

pos=[0.2,0.1,0.9,0.9]



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

fname=vtag+"degreedft3cuts"+string(nfile, format='(I04)')
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet
endif else  begin
set_plot, 'x'
endelse


cgerase



   cgLoadCT, 33
   pos = cglayout([4,1] , OXMargin=[4,1], OYMargin=[4,1], XGap=3, YGap=2)

tp=pos[*,0]
    ;print,tp[2]-tp[0], tp[3]-t[1]
 
   FOR j=0,2 DO BEGIN
     p = pos[*,j]
     ;p = posarr[*,j]
     d= alog10(*dataptr(j))
	r=cgscalevector(d, 1,254)
	imin=min(*dataptr[j])
	imax=max(*dataptr[j])
    ; cgimage, r, NoErase=j NE 0, Position=p
    ttag='                         '
    if ( j eq 2 ) then begin
    ttag=', t='+string(mytime,format='(F6.2)')+' orbits'
    ttag=''
    endif

    if ( j eq 0 ) then begin
    ytickf1='(I3)'
    endif else  begin
    ytickf1='(A1)'
    endelse
  cgcontour,d, $
  *k1arr[j],*k2arr[j] , $
  ;/nodata,
   /noerase, $ 
    ;/c_Colors,$
    nlev=20,$
    /fill, $
    xtitle=xtitlestr(j), $
    ytitle=ytitlestr(j), $
    xrange=[-50,50],$
    yrange=[-50,50],$
   ytickformat=ytickf1,$
    pos=p,$
    ;title=titlestr(j)+ttag,$
    charsize=mychar
    gft=gauss2dfit(d, aa,/tilt)
    ;print, 'gauss,',aa[2]/aa[3]
    if (usingps eq 1) then begin
    if ( j eq 2 ) then begin
    print, nfile,aa[6]*!RADEG
    print, 'Program', xtitlestr(j), ytitlestr(j)
    endif
    endif


angle=aa[6]
if ( (angle gt  90) and (angle lt  180)) then angle = angle-90
if ( (angle lt   0) and (angle gt  -90)) then angle = angle+90 
if ( (angle lt -90) and (angle gt -180)) then angle = angle+180
    
   ; interpolate along max angle



    cgloadct,33
    tvlct,255,255,255,255
    cgcontour, gft, *k1arr[j],*k2arr[j], /overplot, pos=p, color='Black', Charsize=cgDefCharsize()*0.9 , label=0
        if (  j eq 2 ) then begin
     ;cgcolorBar, position=[p[2]+0.06, p[1], p[2]+0.07, p[3]],range=[imin-1e-6,imax+1e-6], Charsize=cgDefCharsize()*0.9  , /vertical
     endif

    if ( j eq 0 ) then begin
    num=0
    if ( nfile > 30 ) then num=1
    ttag='t='+string(nfile+6,format='(I3)') ;+' orbits'
    cgtext, -44,37, ttag, color='white', Charsize=cgDefCharsize()*0.6
    endif
   ENDFOR
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





dsx=119
cut45=fltarr(dsx)
cut135=fltarr(dsx)
powave =fltarr(ny,2)
for i=0,dsx-2 do begin

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




k1=findgen(120)+1

colors=['red', 'blue', 'green', 'black', 'turquoise', 'black']
    items=['k!Dp!N', 'k!Dh!N', 'k!Dz!N', 'k!Dr!N', '-4/3', 'ave']
    lines=[0,0,0,0,0,0]


mp=pos[*,3]
k1h=k1*sqrt(2)
yrmax=1e2
yrmin=1e-6
if ( vtag eq 'bxby' ) then begin
yrmax=1e1
yrmin=1e-5
endif
cgplot,k1h, k1h*cut45, /xlog, /ylog, xrange=[1,128],yrange=[yrmin,yrmax], color=colors[0], $
    ytickformat='logticks_exp',$
    linestyle=lines[0], xtitle='kL', ytitle='log!D10!Nk|DFT('+vtag2+')|!U2!N', pos=[mp[0]+0.03,mp[1],mp[2],mp[3]],/noerase, charsize=mychar
cgplot,k1h, k1h*cut135, /overplot , color=colors[1], linestyle=lines[1]

k1h=k1*2
cgplot,k1h, k1h*vcut, /overplot , color=colors[2], linestyle=lines[2]
cgplot,k1, k1h*powave, /overplot , color=colors[3], linestyle=lines[3]
 al_legend, items[0:3], colors=colors[0:3], linestyle=lines[0:3], Charsize=mychar,linsize=0.15,$
    ;/right,$
    pos=[13,yrmax],$
    box=0
   

if ( usingps ) then begin
cgps_close, /jpeg,  Width=2048, /nomessage
endif else begin
fname2=fname
;im=cgsnapshot(filename=fname2,/nodialog,/jpeg)
endelse
endfor

endfor



end
