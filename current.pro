pro current, bx1,bx2,vx1,vx2, rho, prs, t , nlast, nx1,nx2,x1,x2, background,dx1,dx2, hires
growth=0
cg=0
if (cg eq 1) then begin
cgwindow, xs=1500,ys=1100
;cgWindow
cgSet
endif else  begin
if (hires eq 1) then begin
window,xs=1500,ys=1100
endif else begin
window,xs=1100,ys=800
endelse
endelse
;loadct,33
;tvlct, 0,0,0,0
;tvlct, 255,255,255,1
pload,0
help, bx1

initvort= 0.0
initb1= 0.0
initb2= 0.0

;background=1
if ( background eq 1) then begin
initvort= 0.5*(shift(bx1,0,-1)-shift(bx1,0,1) ) - 0.5*(shift(bx2,-1,0) - shift(bx2,1,0))
initb1=bx1
initb2=bx2

endif

nstart=1
nend=nlast
nstep=1
pload,0
totalb20=total(bx1^2+bx2^2)
gamma=fltarr(1)
tbx2=fltarr(1)
tbx2(*)=1
totvel1=fltarr(1)
totvel2=fltarr(1)
totprs=fltarr(1)

for nfile=nstart,nend,nstep do begin
print, nfile

ll=6
zero=''
nts=strcompress(string(nfile),/remove_all)
lnt=strlen(nts)
for j=1,ll-lnt do zero=zero+'0'
           fname='sixplot'+zero+nts

pload,nfile

!p.position=0
nx = nx1
nz = nx2
slice= 0


a=total(bx2^2)/totalb20 ; total by^2
b=total(bx1^2)/totalb20 ; total bx^2
qv1=total(vx2^2)/totalb20 ; total by^2
qv2=total(vx1^2)/totalb20 ; total bx^2
gamma=[gamma, a]
tbx2=[tbx2, b]
totvel1=[totvel1, qv1]
totvel2=[totvel2, qv2]
print, size(gamma)

vort= 0.5*(shift(bx1,0,-1)-shift(bx1,0,1) ) - 0.5*(shift(bx2,-1,0) - shift(bx2,1,0))
var=fltarr(6,nx1,nx2)
rho[0,0]=rho[0,0]+1e-6
var(0,*,*)=alog(prs)
;sndspd=sqrt(1.4*prs/rho)
;var(0,*,*)=sndspd
if ( background eq 1 ) then begin 
var(1,*,*)=bx1-initb1
var(2,*,*)=bx2-initb2
tag="(backgr subtracted)"
endif else begin
var(1,*,*)=bx1
var(2,*,*)=bx2
tag="(backgr included)"
endelse
var(3,*,*)=vort-initvort
var(4,*,*)=sqrt((bx1^2+bx2^2)/rho)
var(5,*,*)=bx1
str=strarr(6,20)
str(0,*)="prs"
;str(0,*)="sndspd"
str(1,*)="B!DX!N"+tag
str(2,*)="B!DZ!N"+tag
str(3,*)="current"+tag
str(4,*)="Alfven speed"
str(5,*)="bx1"

for usingps=0,1 do begin

if ( usingps ) then begin
set_plot,'ps'
device,filename=fname+'.eps',/encapsulated
device, /color
!p.font=0
device, /times
xs=10.
ys=6
!p.charsize=0.9
cbarchar=0.9
xychar=0.9
legchar=0.9
DEVICE, XSIZE=xs, YSIZE=ys, /INCHES
endif else begin
set_plot,'x'
!p.font=-1
;!p.color=0
;!p.background=255
!p.charsize=2.4
cbarchar=2.4
xychar=1.4
legchar=1.4
;device, set_resolution=[1100,800]
endelse

;window, xs=1100,ys=800
!p.multi=[0,3,2]
!x.style=1
!y.style=1

;!p.background=1

xx=x1
yy=x2

;p1 = !P & x1 = !X & y1 = !Y








 cgLoadCT, 33, CLIP=[5, 245]
;tvlct, 0,0,0,0
;tvlct, 255,255,255,1
white=1
!p.background=white
!p.color=0

for i=0,4 do begin


;r=scale_vector(var(i,*,*),4,255)
r=reform(var(i,*,*))
;contour, r, xx,yy,/nodata, title=str(i), xtitle='x', ytitle='y'
p = [0.08, 0.3, 0.98, 0.95]
  ;cgIMAGE, r, POSITION=p, /KEEP_ASPECT_RATIO ;, MISSING_INDEX=3 , scale=4, bottom=190, top=254, background='white'
  cgimage, r, POSITION=p, /KEEP_ASPECT_RATIO ,background='white', scale=1 ;, /axis, xtitle='x ', ytitle='y'
;cgaxis,0.5,0.1, /xaxis, /normal, xrange=[1,20]
;cgaxis, /xaxis, xRANGE=[0, 100], $
;MINOR=0, MAJOR=3
  cgcontour, r, xx,yy,POSITION=p, /NOERASE, XSTYLE=1, $
      YSTYLE=1,  NLEVELS=10, /nodata, title=str(i), $
      color='white'
imin=min(r)-1e-6
imax=max(r)+1e-6
cgcolorbar, Position=[p[0], p[1]-0.1, p[2], p[1]-0.05], range=[imin,imax], format='(F5.2)', charsize=cbarchar


if (i eq 3 ) then begin
q=25
if (background eq 1) then begin
cv1=congrid(bx1-initb1,q,q)
cv2=congrid(bx2-initb2,q,q)
endif else begin
cv1=congrid(bx1,q,q)
cv2=congrid(bx2,q,q)
endelse 
cx=congrid(xx,q)
cy=congrid(yy,q)

cgloadct,0
velovect, cv1,cv2, cx,cy, /noerase,/overplot, position=p , color=255
cgloadct,33
endif

endfor

growth=0
dogrowth=0
if ( max(gamma) ge 0.5 ) then begin 
dogrowth=1
endif

; estimate growth rate
tsndcr=1.0/10.0 ; should be kh /10?
tnorm=t
;tnorm=t/tsndcr
if (  dogrowth ) then begin 

nel=n_elements(gamma)
gam2=[0.01, 0.5]
tam2=interpol( tnorm(0:nel-1),gamma, gam2)

print, tam2
print, gam2
growth=(gam2[1]-gam2[0])/(tam2[1]-tam2[0])
growth=(alog10(gam2[1])-alog10(gam2[0]))/(tam2[1]-tam2[0])
endif

cgplot, tnorm, alog10(gamma), title='Log (Total B!U2!N!DZ!N)' ,   xrange=[0.1,24],yrange=[-5,0], xtitle='t / t!D(VK)!N', ytitle='Log Total B!U2!N!DZ!N /B!U2!N!Dt=0!N' , /xlog, psym=-14, Color='black',linestyle=0
cgplot, tnorm, alog10(tbx2), /overplot, PSym=-15, Color='red',linestyle=0
cgplot, tnorm, alog10(totvel1), /overplot,PSym=-16, Color='dodger blue', linestyle=2
cgplot, tnorm, alog10(totvel2), /overplot, PSym=-17, Color='green', linestyle=3
al_legend, ['bz','bx!U2!N', 'v1!U2!N','v2!U2!N'], PSym=[-14,-15,-16,-17], $
      LineStyle=[0,0,2,3], Color=['black','red','dodger blue','green'], charsize=legchar, /left
if ( dogrowth ) then begin 
;oplot,t,exp(growth*t/0.1)*gam2[0]/exp(growth*tam2[0]/0.1)
cgplot, tnorm, growth*(tnorm-tam2[0])+alog10(gam2[0]) ,  /overplot
cgplot, tam2, alog10(gam2), psym=4, /overplot
endif
talfven=1./max((bx1^2+bx2^2)/rho)
tresis=1/1e-4
tsound=1/max(prs/rho)
aspectratio=max(x2+0.5*dx2[0])/max(x1+0.5*dx1[0])

xyouts, 0.01,0.01,$
   'Tearing Mode Instability, t='+string(t(nfile),format='(F5.1)')+ $
     ', growth rate'+string(growth, format='(F7.4)')+$
      ', aspect ratio '+string(aspectratio, format='(F7.4)')+$
      ' , t!DA!N'+string(talfven, format='(F8.4)')+$
      ' , t!DR!N'+string(tresis, format='(F9.1)')+$
      ' , t!DS!N'+string(tsound, format='(F7.4)'),$
   /normal, charsize=xychar

!p.position=0
!p.multi=0


if ( usingps ) then begin
device,/close
set_plot,'x'
endif else begin
;set_plot,'x'
fname2=fname
im=cgsnapshot(filename=fname2,/nodialog,/jpeg)
endelse

endfor
set_plot,'x'


endfor

f2name='growthratemhd.dat'
OPENW,1,f2name
PRINTF,1, max(x2)/max(x1), growth,FORMAT='(F9.6 , F9.6)'
CLOSE,1
print, totalb20
PRINT, max(x2)/max(x1), ' growth ', growth
end
