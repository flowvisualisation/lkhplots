 
xs=1200
ys=1100
cgdisplay, xs=xs,ys=ys

nfile=4


nbeg=50000
nbeg=322000
;nbeg=308000
nbeg=790000L
nend=nbeg
;nend=998000L
nstep=nend-nbeg
nstep=2
;nend=nlast
spawn, 'basename $PWD', dirtag
spawn,'uname', listing
if ( listing ne 'Darwin') then begin
nbeg=322000
nbeg=24000L
getlast, nbeg
nend=nbeg
nstep=2000L
endif

d=h5_read(0,  /remap, /v)
vy0=transpose(reform(d.v(1,*,*,*)))

for nfile=nbeg,nend,nstep do begin
;pload,nfile, /xyassoc, /silent
d=h5_read(nfile, /rho,  /remap, /v)
grd_ctl,model=nfile, mydat
print, nfile
bx1=transpose(reform(d.v(0,*,*,*)))
bx2=transpose(reform(d.v(1,*,*,*)))-vy0
bx3=transpose(reform(d.v(2,*,*,*)))
rho=transpose(reform(d.rho(*,*,*)))
grd_ctl, model=nfile, p, c
x1=p.x
x2=p.y
x3=p.z
nx1=p.nx
nx2=p.ny
nx3=p.nz




pos= cglayout([3,2] , OXMargin=[39,1], OYMargin=[39,6], XGap=7, YGap=12)



bnorm=1.0
;vec=bx1^2+bx2^2+bx3^2
tag='b'
;vec=bx1*bx2
tag='bxby'+dirtag
;vecnorm=total(vec)/nx1/nx2/nx3
;vec=vec/vecnorm


nh1=3*nx3/4
nh1=7*nx3/8



nh0=nx3/2
;levh1=vec(*,*,nh1)
;levh1=bx1(nh1)^2+bx2(nh1)^2+bx3(nh1)^2
levh1=bx1(*,*,nh1)^2+bx2(*,*,nh1)^2+bx3(*,*,nh1)^2
levh0=bx1(*,*,nh0)^2+bx2(*,*,nh0)^2+bx3(*,*,nh0)^2

;levh1(0,0)=max(levh0)
;levh1(0,1)=min(levh0)
;levh0(0,0)=max(levh1)
;levh0(0,1)=min(levh1)

levh1unnorm=levh1
levh1=levh1/mean(levh1)


fh1=(nx1*nx2*abs(fft(levh1,/center)))
fh1unnorm=(nx1*nx2*abs(fft(levh1unnorm,/center)))
qsm=2
fh1=smooth(fh1,qsm)
fh1unnorm=smooth(fh1unnorm,qsm)
;levh0=vec(*,*,nh0)
;levh0=bx1(nh0)^2+bx2(nh0)^2+bx3(nh0)^2


levh0unnorm=levh0
levh0=levh0/mean(levh0)
fh0=(nx1*nx2*abs(fft(levh0,/center)))
fh0unnorm=(nx1*nx2*abs(fft(levh0unnorm,/center)))
fh0=smooth(fh0,qsm)
fh0unnorm=smooth(fh0unnorm,qsm)


datptr=ptrarr(12)
datptr(0)=ptr_new((levh1))
datptr(1)=ptr_new(fh1)
datptr(2)=ptr_new(fh0)
datptr(3)=ptr_new((levh0))
datptr(4)=ptr_new(fh0)
datptr(5)=ptr_new(fh1)

titstr=strarr(12)
titstr(2)='dummy'
h1tag=string(x3(nh1), format='(I1)')
h0tag=string(x3(nh0), format='(I1)')
lg10bn='log!D10!N|v!Dnorm!N!U2!N|'
titstr(0)=lg10bn
titstr(1)=lg10bn 
titstr(5)='dummy'
titstr(3)=lg10bn
titstr(4)=lg10bn
titstr(3)=''
titstr(4)=''
titstr(6)='p6'
titstr(7)='p7'

xtitstr=strarr(12)
xtitstr(2)='dummy'
xtitstr(0)='x/H'
xtitstr(1)='k!Dx!N'
xtitstr(5)='dummy'
xtitstr(3)='x/H'
xtitstr(4)='k!Dx!N'


ytitstr=strarr(12)
ytitstr(2)='dummy'
ytitstr(0)='y/H'
ytitstr(1)='k!Dy!N'
ytitstr(5)='dummy'
ytitstr(3)='y/H'
ytitstr(4)='k!Dy!N'

xaxis1=fltarr(12)
xaxis1(2)=999.
xaxis1(0)=x1(nx1-1)-x1(0)
xaxis1(1)=nx2
xaxis1(5)=999.0
xaxis1(3)=x1(nx1-1)-x1(0)
xaxis1(4)=nx2

xaxis2=fltarr(12)
xaxis2(2)=999.0
xaxis2(0)=(x1(nx1-1)-x1(0))/2.
xaxis2(1)=nx2/2
xaxis2(5)=999.0
xaxis2(3)=(x1(nx1-1)-x1(0))/2.
xaxis2(4)=nx2/2

yaxis1=fltarr(12)
yaxis1(2)=999.0
yaxis1(0)=x2(nx2-1)-x2(0)
yaxis1(1)=nx2
yaxis1(5)=999.0
yaxis1(3)=x2(nx2-1)-x2(0)
yaxis1(4)=nx2

yaxis2=fltarr(12)
yaxis2(2)=999
yaxis2(0)=(x2(nx2-1)-x2(0))/2
yaxis2(1)=nx2/2
yaxis2(5)=999
yaxis2(3)=(x2(nx2-1)-x2(0))/2
yaxis2(4)=nx2/2

th=fltarr(12)
th(0)=2
th(1)=128
th(3)=2
th(4)=128

tx=fltarr(12)
tx(0)=-.7
tx(1)=-100
tx(3)=-.7
tx(4)=-100

strz=strarr(12)
strz(0)='z=3'
strz(1)='z=3'
strz(3)='z=0'
strz(4)='z=0'
cgloadct,33




fname="~/Documents/results/"+dirtag+'/'+tag+'slices'+string(nfile,format='(I08)')
fname=tag+'slices';+string(nfile,format='(I08)')

for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet, font=1 ;, /nomatch, xs=20, ys=5, /bold
charsize=cgdefcharsize()*0.5
pi_str='!9p!X'
   !P.CharThick = 8
endif else  begin
set_plot, 'x'
charsize=cgdefcharsize()*1.1
pi_str='!7p!X'
endelse



;pload, nfile, x2range=[0,0], var="bx1", /silent
;pload, nfile, x2range=[0,0], var="bx2", /silent
;pload, nfile, x2range=[0,0], var="bx3", /silent
;pload, nfile, x2range=[0,0], var="rho", /silent
;d=h5load(nfile, /rho, /v)
;bx1=reform(d.b(0,*,*,*))
;bx2=reform(d.b(1,*,*,*))
;bx3=reform(d.b(2,*,*,*))


cgerase
b2=reform(bx1(*,0,*)^2+bx2(*,0,*)^2+bx3(*,0,*)^2)
b2=b2 ;/8e-7/!DPI

gmm=5./3.
p=reform(rho(*,0,*)^gmm)

a=b2 ;/2.d/p

print,max(a),min(a)

nirvtime=c.time
tstring=string(nirvtime/2./!DPI, format='(F5.1)')


;pos1=[pos[0,0],pos[1,3],pos[2,0],pos[3,0]]
pos1=[0.1,pos[1,3],0.25,pos[3,0]]
d=alog10(a)
imin=min(d)
imax=max(d)
r=cgscalevector(d,1,254)
cgimage,r, pos=pos1
sz=size(d,/dimensions)
x=findgen(sz(0))/sz(0)-0.5
z=findgen(sz(1))/sz(1)*3-1.5
cgcontour, d, x1,x3, /nodata, pos=pos1, color='black', /noerase, $
    ;title='!9r!X', $
    charsize=cgDefCharsize()*.6,$
    ;title='log!D10!N|2p/v!U2!N|', $
    xticks=3,$
    xtickinterval=1,$
    title='log!D10!N|v!U2!N|, t='+tstring, $
    xtitle='x/H', ytitle='z/H'
    cgplot, findgen(100)/50.-1, findgen(100)*0, /overplot
    cgplot, findgen(100)/50.-1, findgen(100)*0+3, /overplot
p=pos1
xs=!d.x_size
ys=!d.y_size
;cgarrow, xs*.26, ys*.79, xs*.32, ys*.8, /Solid
;cgarrow, xs*.26, ys*.59, xs*.32, ys*.5, /Solid
cgcolorbar, Position=[p[0], p[1]-0.09, p[2], p[1]-0.08], range=[imin,imax], format='(I5)', $
    charsize=cgDefCharsize()*.6

nplot=[0,1,3,4]

xtickinterval=[1,100,1,100]
ytickinterval=xtickinterval

for myc=0,3 do begin
i=nplot[myc]
d=alog10(*datptr(i))
r=cgscalevector(d,1,254)
imin=min(d)
imax=max(d)
cgimage, r, pos=pos[*,i], /noerase
sz=size(d,/dimensions)
x=findgen(sz(0))/sz(0)*xaxis1(i)-xaxis2(i)
y=findgen(sz(1))/sz(1)*yaxis1(i)-yaxis2(i)
cgcontour, d,x,y, /nodata, pos=pos[*,i], color='black', /noerase, $
    charsize=cgDefCharsize()*.6,$
    title=titstr(i),$
    xtitle=xtitstr(i),$
    xtickinterval=xtickinterval[myc],$
    ytickinterval=ytickinterval[myc],$
    ytitle=ytitstr(i)
    cgtext, tx(i), th(i), strz(i) , charsize=cgDefCharsize()*.6
p=pos[*,i]
cgcolorbar, Position=[p[0], p[1]-0.09, p[2], p[1]-0.08], range=[imin,imax], $
    format='(I5)',$
    charsize=cgDefCharsize()*.6

    if (  (myc eq 1 ) or (myc eq 3)) then begin
    gft=gauss2dfit(d^3, aa,/tilt)
    cgcontour, gft, x,y, /overplot, pos=p, color='black', Charsize=cgDefCharsize()*0.9 , label=0
    
angle=aa[6]
if ( (angle gt  !DPI/2.) and (angle lt  !DPI)) then angle = angle-!DPI/2.0d
if ( (angle lt   0) and (angle gt  -!DPI/2)) then angle = angle+!DPI/2.0d
if ( (angle lt -!DPI/2.) and (angle gt -!DPI)) then angle = angle+!DPI
angle=!PI/2-angle
print, 'angle=', angle*!RADEG
    endif
endfor

fftarr1=*datptr(1)
sz=size(fftarr1, /dimensions)
  gft=gauss2dfit(fftarr1^3, aa,/tilt)

f1=fftarr1(nx1/2:nx1-1,sz(1)/2)

angle=aa[6]
if ( (angle gt  !DPI/2.) and (angle lt  !DPI)) then angle = angle-!DPI/2.0d
if ( (angle lt   0) and (angle gt  -!DPI/2)) then angle = angle+!DPI/2.0d
if ( (angle lt -!DPI/2.) and (angle gt -!DPI)) then angle = angle+!DPI
angle=!PI/2-angle
print, 'angle=', angle*!RADEG

;angle=!DPI/5.d

nxq=sz(0)
nyq=sz(1)
xq = findgen(nyq/2)*cos(angle);+nyq/2
yq = findgen(nyq/2)*sin(angle);+nyq/2

k=findgen(nyq/2)
k1max=sqrt(  (  findgen(nxq/2)*cos(angle)  )^2+( findgen(nyq/2)*sin(angle) )^2)

fh1=(nx1*nx2*abs(fft(levh1)))
fftarr1=smooth(fh1, qsm)
fftarr1_rebin=congrid(fftarr1, nyq, nyq)
   f1=interpolate (fftarr1_rebin ,xq,yq)

fh0=(nx1*nx2*abs(fft(levh0)))
fftarr0=smooth(fh0,qsm)
fftarr0_rebin=congrid(fftarr0, nyq, nyq)
   f0=interpolate (fftarr0_rebin ,xq,yq)


fh0unnorm2=(nx1*nx2*abs(fft(levh0unnorm)))
fh0unnorm2=smooth( fh0unnorm2, qsm)
levh0unnormrebin=congrid(fh0unnorm2,nyq,nyq)


powave=fltarr(nyq/2*1.5)
powave(*)=0
for i=0, nyq/2-1 do begin
for j=0, nyq/2-1 do begin
rad=sqrt(1.*i^2 +1.*j^2)
radint=round(rad)
powave[radint] += levh0unnormrebin[i,j]/rad^2/!DPI/2
endfor
endfor


   f0unnorm=interpolate (levh0unnormrebin ,xq,yq)
   f0unk0=f0unnorm(0)
 ;  f0unnorm=f0unnorm(1:nyq/2-1)

fh1unnorm2=(nx1*nx2*abs(fft(levh1unnorm)))
fh1unnorm2 = smooth ( fh1unnorm2, qsm)
levh1unnormrebin=congrid(fh1unnorm2,nyq,nyq)
powaveh1=fltarr(nyq/2*1.5)
powaveh1(*)=0
for i=0, nyq/2-1 do begin
for j=0, nyq/2-1 do begin
rad=sqrt(1.*i^2 +1.*j^2)
radint=round(rad)
powaveh1[radint] += levh1unnormrebin[i,j]/rad^2/!DPI/2
endfor
endfor
   f1unnorm=interpolate (levh1unnormrebin ,xq,yq)
   f1unk0=f1unnorm(0)
;   f1unnorm=f1unnorm(1:nyq/2-1)

ymax=max(k*f0unnorm)
cgplot, k,k*f0unnorm,pos=pos[*,2], /noerase, xtitle='k', /xlog,/ylog, $
    xrange=[1,max(k)], $
    yrange=[1e-3*ymax,10*ymax], $
    charsize=charsize, $
color='red',$
    title='log!D10!N|k v!U2!N(k!Dx!N,k!Dy!N)|' ;,$
;    ytitle='log!D10!N|v!U2!N(k!Dx!N,k!Dy!N)|'
cgplot, k,k*f1unnorm,/overplot, color='black'
cgplot, 2, f0unk0, psym=1, /overplot, color='red'
cgplot, 2, f1unk0, psym=1, /overplot
cgplot, k, k*powave, /overplot, color='red', linestyle=2
cgplot, k, k*powaveh1, /overplot, color='black', linestyle=2
print, min(k*powave), max(k*powave)

cgplot, k,k*f0,pos=pos[*,5], /noerase, xtitle='k', /xlog,/ylog, xrange=[1,max(k)], charsize=charsize,$
color='red',$
    title='log!D10!N|k v!Dnorm!N!U2!N(k!Dx!N,k!Dy!N)|' ;,$
;    ytitle='log |v!Dnorm!N!U2!N(k!Dx!N,k!Dy!N)|'
cgplot, k,k*f1,/overplot, color='black'
items=['z='+h1tag,'z='+h0tag]
al_legend, items, linestyle=[0,0], /bottom, color=['black','red'], charsize=charsize*0.8, linsize=0.25

;readcol,'averages.dat',tn1,dt,b2,vx2,vy2,vz2,bx2,by2,bz2
r=h5_parse('profile.h5', /read)
tnorm=r.time._DATA
;tnorm=tn1/2.d/!DPI

;ctime=t(nfile)
;zz=where ( tn1 gt ctime)
;lim=zz(0)

;bx2s=bx2[0:lim]
;by2s=by2[0:lim]
;bz2s=bz2[0:lim]
bx2s=total(r.bx._DATA^2,2)
by2s=total(r.by._DATA^2,2)
bz2s=total(r.bz._DATA^2,2)

ymax=max( [ bx2s,by2s, bz2s] )
ymin=1e-3*ymax
cgplot, tnorm, bx2s , pos=[0.1,0.1,0.98,0.2], /noerase, /ylog, yrange=[ymin,ymax], color=['red'], ytitle='v!Dx,y,z!N', xtitle='time/2'+pi_str+'  (orbits)'+' , '+dirtag, charsize=charsize
cgplot, tnorm, by2s , /overplot, color=['blue']
cgplot, tnorm, bz2s , /overplot, color=['green']
cgplots, [nirvtime/2/!DPI, nirvtime/2/!DPI], [ymin, ymax], color='black'
items=['v!Dx!N','v!Dy!N','v!Dz!N']
colors=['red','blue','green']
al_legend,items,linestyle=[0,0,0], color=colors, charsize=charsize*0.8, linsize=0.25, /right

;cgtext, 0.2,0.95, "DFT at z="+h0tag+','+h1tag+", t/2"+pi_str+"="+tstring+' orbits', /normal


if ( usingps ) then begin
cgps_close, /jpeg,  Width=2048, /nomessage, delete_ps=0
READ_JPEG, fname+'.jpg', a, TRUE=1 & cgimage, a
print, 'output ps'
endif else begin
fname2=fname
;im=cgsnapshot(filename=fname2,/nodialog,/jpeg)
endelse

endfor


endfor


end
