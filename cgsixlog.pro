pro cgsix, vx1,vx2, rho, prs, t , nlast, nx1,nx2,x1,x2, background,dx1,dx2
growth=0
cg=0
hires=0
pload,0
ar=nx2*1.0/nx1*3
if (cg eq 1) then begin
cgwindow, xs=1500,ys=1100
;cgWindow
cgSet
endif else  begin
if (hires eq 1) then begin
window,xs=1500,ys=1100
endif else begin
xs=1200
ys=ar*xs
window,xs=xs,ys=ys
endelse
endelse
;loadct,33
;tvlct, 0,0,0,0
;tvlct, 255,255,255,1
pload,0
help, vx1

initvort= 0.0
initv1= 0.0
initv2= 0.0

;background=1
if ( background eq 1) then begin
initvort=getvort(vx1,vx2,x1,x2,nx1,nx2)
initv1=vx1
initv2=vx2

endif

nstart=1
nend=nlast
nstep=1
pload,0
totalke0=total(sqrt(vx1^2+vx2^2))
tvz2=fltarr(1)
tvx2=fltarr(1)
tvx2(*)=1

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


a=total(abs(vx2))/totalke0 ; total vy^2
b=total(abs(vx1))/totalke0 ; total vx^2
tvz2=[tvz2, a]
tvx2=[tvx2, b]
print, size(tvz2)

vort = getvort(vx1,vx2,x1,x2,nx1,nx2)
var=fltarr(6,nx1,nx2)
rho[0,0]=rho[0,0]+1e-6
var(0,*,*)=rho
if ( background eq 1 ) then begin 
var(1,*,*)=vx1-initv1
var(2,*,*)=vx2-initv2
endif else begin
var(1,*,*)=vx1
var(2,*,*)=vx2
endelse
var(3,*,*)=smooth(vort-initvort, 10,/edge_wrap)
var(3,*,*)=vort-initvort
var(4,*,*)=sqrt(1.4*prs/rho)
var(5,*,*)=vx1
str=strarr(6,20)
str(0,*)="density)"
str(1,*)="x-velocity"
str(2,*)="y-velocity"
str(3,*)="vorticity"
str(4,*)="sndspeed"
str(5,*)="vx1"

for usingps=0,1 do begin

if ( usingps ) then begin
set_plot,'ps'
device,filename=fname+'.eps',/encapsulated
device, /color
!p.font=0
device, /times
xs=10.
ys=6
DEVICE, XSIZE=xs, YSIZE=ys, /INCHES
!p.charsize=0.9
cbarchar=0.9
xyout=0.9
endif else begin
set_plot,'x'
!p.font=-1
!p.charsize=1.8
cbarchar=1.8
xyout=1.8
;device, set_resolution=[1100,800]
endelse

!p.multi=[0,2,2]
!x.style=1
!y.style=1


xx=x1
yy=x2

;p1 = !P & x1 = !X & y1 = !Y








 cgLoadCT, 33, CLIP=[5, 245]
;tvlct, 0,0,0,0
;tvlct, 255,255,255,1
white=1
!p.background=white
!p.color=0

for i=1,3 do begin


;r=scale_vector(var(i,*,*),4,255)
r=reform(var(i,*,*))
;contour, r, xx,yy,/nodata, title=str(i), xtitle='x', ytitle='y'
p = [0.08, 0.4, 0.98, 0.9]
  ;cgIMAGE, r, POSITION=p, /KEEP_ASPECT_RATIO ;, MISSING_INDEX=3 , scale=4, bottom=190, top=254, background='white'
  cgimage, r, POSITION=p, /KEEP_ASPECT_RATIO ,background='white', scale=1 ;, /axis, xtitle='x ', ytitle='y'
;cgaxis,0.5,0.1, /xaxis, /normal, xrange=[1,20]
;cgaxis, /xaxis, xRANGE=[0, 100], $
;MINOR=0, MAJOR=3
  cgcontour, r, xx,yy,POSITION=p, /NOERASE, XSTYLE=1, $
      YSTYLE=1,  NLEVELS=10, /nodata, title=str(i)+string(min(r))+' '+string(max(r)), $
      color='white'
imin=min(r)-1e-6
imax=max(r)+1e-6
cgcolorbar, Position=[p[0], p[1]-0.1, p[2], p[1]-0.05], range=[imin,imax], format='(F5.2)', charsize=cbarchar


if (i eq 3 ) then begin
q=25
if (background eq 1) then begin
cv1=congrid(vx1-initv1,q,q)
cv2=congrid(vx2-initv2,q,q)
endif else begin
cv1=congrid(vx1,q,q)
cv2=congrid(vx2,q,q)
endelse 
cx=congrid(xx,q)
cy=congrid(yy,q)

cgloadct,0
velovect, cv1,cv2, cx,cy, /noerase,/overplot, position=p , color=255
endif

endfor

growth=0
dogrowth=0

maxtvz2=0.1
if ( max(tvz2) ge maxtvz2 ) then begin 
dogrowth=1
endif

; estimate growth rate
tsndcr=1.0/10.0 ; should be kh /10?
tnorm=t
;tnorm=t/tsndcr
if (  dogrowth ) then begin 

nel=n_elements(tvz2)
gam2=[0.02, maxtvz2]
tam2=interpol( tnorm(0:nel-1),tvz2, gam2)

print, tam2
print, gam2
growth=(gam2[1]-gam2[0])/(tam2[1]-tam2[0])
growth=(alog10(gam2[1])-alog10(gam2[0]))/(tam2[1]-tam2[0])
;growth=(alog10(gam2[1])-alog10(gam2[0]))/(alog10(tam2[1])-alog10(tam2[0]))
endif

cgplot, tnorm, alog10(tvz2), title='Log (Total y-kinetic energy)' ,   xrange=[0.1,120],yrange=[-2,0], xtitle='t / t!Dsound crossing!N', ytitle='Log Total y kinetic energy/KE!Dt=0!N' , /xlog
cgplot, tnorm, alog10(tvx2), /overplot
if ( dogrowth ) then begin 
;oplot,t,exp(growth*t/0.1)*gam2[0]/exp(growth*tam2[0]/0.1)
cgplot, tnorm, growth*(tnorm-tam2[0])+alog10(gam2[0]) ,  /overplot
cgplot, tam2, alog10(gam2), psym=4, /overplot
endif


xyouts, 0.01,0.01,$
   'Kelvin-Helmholtz Instability, t='+string(t(nfile),format='(F8.1)')+ $
     ', growth rate'+string(growth, format='(F8.4)')+$
      ', aspect ratio '+string(max(x2)/max(x1), format='(F8.4)'),$
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
print, totalke0
PRINT, max(x2)/max(x1), ' growth ', growth
end
