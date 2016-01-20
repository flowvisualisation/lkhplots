!EXCEPT=0

pistr='!9p!X'
;cgdisplay, xs=1500,ys=600
cgdisplay, xs=800,ys=300

nbeg=790L*1000L
nend=790L*1000L
nstep=2000L
;nfile=322000L

grd_ctl,g,c, model=0

qcfrac2d=findgen(g.ny-1)
qdfrac2d=qcfrac2d

d=h5_read(0,/rho,   /remap)
rho=transpose(reform(d.rho[*,*,*]))
initpres=rho^(5./3.)

spawn, 'basename $PWD', dirname
dirtag=strmid(dirname,18,6) & print, dirtag

for nfile=nbeg, nend, nstep do begin
;if ( firstcall eq !NULL ) then begin 

d=h5_read(nfile,/rho,  /B, /remap)
grd_ctl,g,c, model=nfile
bx1=transpose(reform(d.b[2,*,*,*]))
bx2=transpose(reform(d.b[1,*,*,*]))
bx3=transpose(reform(d.b[0,*,*,*]))
;d=h5_read(0,/rho)
rho=transpose(reform(d.rho[*,*,*]))
;firstcall=1
;endif

b2=bx1^2+bx2^2+bx3^2

pmag=b2/8e-7/!DPI
pres=rho^(5./3.)
pbeta=pres/pmag
betaave=total(pbeta,1)/g.nx
betaave=total(betaave,1)/g.ny
;cgplot, g.z, betaave, /ylog

a=where( betaave[0:g.nz/2]  gt 1)
b=where( betaave[g.nz/2:g.nz-1]  lt 1)

print, a(0), g.nz/2+b(0)
db=a(0)
dt=g.nz/2+b(0)
;print, 

fdge=+0
dqb=(db)-fdge

dqt=(dt)+fdge

print, dqb,dqt
print, g.z(dqb), g.z(dqt)

;stop

;b2=bx2^2
vec=sqrt(pmag) /initpres
;vec=bx1*bx2/pres
nx1=320
nx2=320
nx3=512
vec=congrid(vec, nx1,nx2,nx3)

xx=findgen(nx1)/nx1*2-1
ky=[findgen(nx2/2), -nx2/2+findgen(nx2/2)]

xx3d=rebin(reform(xx,nx1,1,1),nx1,nx2,nx3)
ky3d=rebin(reform(ky,1,nx2,1),nx1,nx2,nx3)


cfft1=fft(vec ,dimension=2)
cfft2=fft(cfft1, dimension=1)

fftarr=cfft2

fftnorm=abs(fftarr)
fftnorm=fftnorm^2


; split into disk and corona

fh=512
hd=128
cb=0
;dqt=fh/2+hd
;dqb=fh/2-hd

print, dqb,dqt


dbot=dqb
dtop=dqt-1
cbot=dqt
ctop=dqb-1

fftd=fftnorm[*,*,dqb:dqt-1]
fdsum=total(fftd,3)/(dqt-dqb)
fftc=fftnorm[*,*,0:dqb-1]
fftc2=fftnorm[*,*,dqt:fh-1]
fcsum=total(fftc,3)/dqb+total(fftc2,3)/(fh-dqt)



ttag=string(nfile, format='(I08)')
fname="${HOME}/Documents/results/"+dirname+"/"+"nauman"+dirtag+ttag
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet
omega_str='!9W!X'
pistr='!9p!X'
!p.charsize=1.0
charsize=cgdefcharsize()
endif else  begin
set_plot, 'x'
omega_str='!7X!X'
pistr='!7q!X'
!p.charsize=1.5
charsize=cgdefcharsize()
endelse

if (1) then begin
cgloadct,33




pos=cglayout([4,1] , OXMargin=[4,2], OYMargin=[6,2], XGap=4, YGap=11)

datptr=ptrarr(12)
datptr(0)=ptr_new(alog10(shift(fcsum,nx1/2,nx2/2)))
datptr(1)=ptr_new(alog10(shift(fdsum,nx1/2,nx2/2)))

torb=c.time/2./!DPI
timetag=string(torb, format='(F6.2)' ) 
tstr=strarr(12)
tstr(0)=dirtag+', corona B(k)'
tstr(1)=timetag+', disk B(k)'
tstr(2)='k |B!Dx!NB!Dy!N(k)|!U2!N'
tstr(2)='k |B(k)|!U2!N'
tstr(3)=string (torb mod .6666 , format='(F5.2) ') +', Q!Df!N'
tstr(4)='k |B(k)|!U2!N'


cgerase
for i=0,1 do begin
px=pos[*,i]
dat=*datptr(i)
imin=min(dat)
imax=max(dat)
sz=size(dat, /dimensions)
kx=findgen(sz(0))-sz(0)/2
ky=findgen(sz(1))-sz(1)/2
cgimage,  dat, pos=px, /noerase
cgcontour, dat, kx, ky, /nodata, /noerase, title=tstr(i), pos=px, $
   xtitle='k!Dx!N',$
      xtickinterval=100, $
      ytickinterval=100, $
   ytitle='k!Dy!N', charsize=charsize
cgcolorbar, range=[imin,imax], pos=[px[0],px[1]-0.18,px[2],px[1]-0.16]
endfor
;cgimage,  alog10(shift(fdsum,nx1/2,nx2/2)), pos=pos[*,1], /noerase
endif




; circle average 

fcsumshift=shift(fcsum,nx1/2,nx2/2)
fdsumshift=shift(fdsum,nx1/2,nx2/2)

fdc=dblarr(1.5*nx1)
fcc=dblarr(1.5*nx1)
karr=findgen(1.5*nx1)/2.d/!DPI
for i=-nx1/2,nx1/2-1 do begin
for j=-nx2/2,nx2/2-1 do begin
   

rad=sqrt((1.d*i)^2 +(1.d*j)^2 )

radint=round(rad)

fdc[radint] += fcsumshift[nx1/2+i,nx2/2+j]/rad/!DPI/2
fcc[radint] += fdsumshift[nx1/2+i,nx2/2+j]/rad/!DPI/2


endfor
endfor

fnorm=5e-7
kfc=karr*fcc/fnorm*2*!DPI
kfd=karr*fdc/fnorm*2*!DPI
ymin=1e-14
ymax=1e-4
nqn=120
myrange=[kfc[1:nqn], kfd[1:nqn]]
ymin=min(myrange)
ymax=max(myrange)
;cgplot,karr, kfc, pos=pos(*,2), /noerase, /ylog, /xlog, xrange=[1,nqn], title='corona', yrange=[ymin,ymax], color='black'
cgplot,karr, kfd, pos=pos(*,2), /noerase, /xlog, /ylog, xrange=[0.1,nqn], yrange=[ymin,ymax], color='blue', $
   xtitle='kH/2'+pistr,$
   ytitle='2'+pistr+tstr(2),$
   title='2'+pistr+tstr(2),$
   charsize=charsize

cgplot,karr[1:nx1*1.5-1], kfc[1:nx1*1.5-1], /overplot,  color='black'
items=['disk','corona']
al_legend, items, linestyle=[0,0],color=['blue','black'], /bottom, charsize=charsize,linsize=0.15


;; fractional power
qcfrac=dblarr(nx1*1.5)
qdfrac=dblarr(nx1*1.5)
for i=2,nx1 do begin

qcfrac(i)=total(kfc[1:i])/total(kfc[1:nx1*1.5-1])
qdfrac(i)=total(kfd[1:i])/total(kfd[1:nx1*1.5-1])
endfor

qcfrac2d=[[qcfrac2d],[qcfrac(0:nx1-1)]]
qdfrac2d=[[qdfrac2d],[qdfrac(0:nx1-1)]]

cgplot,karr[2:nx1*1.-1], (qcfrac[2:nx1*1.-1]), pos=pos[*,3], /noerase, /xlog, xrange=[0.1,128], color='black', ytitle='Q!Df!N', title=tstr(3), xtitle='kH/2'+pistr , charsize=charsize
cgplot,karr[2:nx1*1.-1], (qdfrac[2:nx1*1.-1]),  /overplot, color='blue'


if ( usingps ) then begin
;device,/close
cgps_close, /jpeg,  Width=1900, /nomessage
;set_plot,'x'
endif else begin
;set_plot,'x'
fname2=fname
;im=cgsnapshot(filename=fname2,/nodialog,/jpeg)
endelse

endfor



endfor
end
