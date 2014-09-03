;;;
powlaw=3/2
powlaw=2.2
qsm=10
snoopyread, vx,vy, vz,bx,by,bz, xx3d,yy3d,zz3d,xx,yy,zz,nx,ny,nz,0, time
mychar=1.4
xfftcut=dblarr(ny/2,2)
yfftcut=dblarr(ny/2,2)
zfftcut=dblarr(nz/2,2)

nfile=99

; load some sheared data


if ( 1 ) then begin
nstart=14
nend=46
nstep=32
;nstep=1
;nstart=115
;nend=2000
;nstep=20
endif

plist=[14,46]
for loadnum=0,1 do begin

snoopyread, vx,vy, vz,bx,by,bz, xx3d,yy3d,zz3d,xx,yy,zz,nx,ny,nz,plist[loadnum], time
nx1=nx
nx2=ny
nx3=nz
x1=xx
x2=yy
x3=zz

;t=findgen(nfile+1)
mytime=time
vec=(bx^2+by^2+bz^2)
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



qxdd=abs(cfft3(*,*,*))

for i=0,ny/2-1 do begin
xfftcut[i, loadnum]=(qxdd(i,i,0))
print, loadnum,xfftcut(i,loadnum)
endfor

for i=0,ny/2-1 do begin
yfftcut[i, loadnum]=(qxdd(i,ny-i-1,0))
endfor
yfftcut[0, loadnum]=(qxdd(0,0,0))

zfftcut[0:nz/2-1, loadnum]=(qxdd(0,0,0:nz/2-1))


endfor

   cgDisplay, WID=1,xs=1600, ys=800, xpos=900, ypos=700

fname=vtag+"dft1dcuts"+string(nfile, format='(I04)')
fname="comp_fft"+string(nfile, format='(I04)')
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet
endif else  begin
set_plot, 'x'
endelse

   pos1 = cglayout([2,1] , OXMargin=[5,1], OYMargin=[5,1], XGap=1, YGap=2)


for nplot=0,1 do begin


;   cgLoadCT, 33

colors=['red', 'blue', 'green', 'black', 'turquoise', 'black']
    items=['k!Dp!N', 'k!Dh!N', 'k!Dz!N', 'k!Dr!N', '-4/3', 'ave']
    lines=[0,0,0,0,0,0]
    ;power3d,unshear, /noplot, spec=spec, wns=wave


radius=fltarr(nx)
powave=fltarr(nx)

for i=0,nx/2-1 do begin
for j=0,ny/2-1 do begin
for k=0,nz/2-1 do begin


rad=sqrt(1.*i^2 +1.*j^2 +1.*k^2)

radint=round(rad)

powave[radint] += qxdd[i,j,k]/rad^2/!DPI

endfor
endfor
endfor

powave[0]=qxdd[0,0,0]

;ymin=min(spec1)
;ymax=max(spec1)
k1=findgen(ny/2)+1
kz=findgen(nz/2)+1
x=alog10(k1)
;xfftcut=alog10( qxdd(0:ny/2-1,0))
x=alog10(k1(0:ny/2-1))
;; this is the z direction
ytick=30
ytickf="(a1)"
ytit=''
if ( nplot eq 0 ) then begin
ytick=1
ytickf="(I2)"
    ytit='log!D10!N|B!U2!N|'
endif
cgplot, k1, smooth((k1^(powlaw))*xfftcut(*,nplot),qsm),   $
    xrange=[5e-1,200.], $
    /xlog,$
    /ylog,$
    pos=pos1[*,nplot],$
    /noerase,$
    charsize=mychar,$
     ;title='t='+string (mytime,format='(F6.1)')+' orbits', $
     yrange=[1e-1,1e2], color=colors[0], $
    xtitle='log!D10!N|k|',$
    ytickf=ytickf,$
    ytitle=ytit

cgplot, k1,(k1^powlaw)*powave, /overplot ;, color=colors[1], linestyle=lines[1]

cgplot, k1,smooth((k1^(powlaw))*yfftcut(*,nplot),qsm), /overplot, color=colors[1], linestyle=lines[1]


;x=alog10(kz)
;y=alog10( reform(qxq(0,0:nz/2-1)))
cgplot, k1,smooth((k1^(powlaw))*zfftcut(*,nplot),qsm), /overplot, color=colors[2];, linestyle=lines[2]



    al_legend, items[0:3], colors=colors[0:3], linestyle=lines[0:3], Charsize=mychar,linsize=0.25, /right
    endfor

if ( usingps ) then begin
cgps_close, /jpeg,  Width=2048, /nomessage
endif else begin
fname2=fname
;im=cgsnapshot(filename=fname2,/nodialog,/jpeg)
endelse

endfor





end
