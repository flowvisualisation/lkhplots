pro comparepessah, vx1,vx2, rho, prs, t , nlast, nx1,nx2,x1,x2, background,dx1,dx2, zbuf=zbuf
growth=0
cg=0
hires=0
pload,0,/silent
ar=nx2*1.0/nx1

xs=800
ys=1200
;window,xs=xs,ys=ys
cgdisplay,xs=xs,ys=ys
initvort= 0.0
initv1= 0.0
initv2= 0.0

;background=1
if ( background eq 1) then begin
initvort=getvort(vx1,vx2,x1,x2,nx1,nx2)
initv1=vx1
initv2=vx2

endif


cs=sqrt(1.4*prs/rho)
initcs=max(cs)
initmach=max(vx1/cs)

nstart=55
nend=79
;nend=2
;nend=40
nstep=1
;pload,0,/silent
totalke0=total(sqrt(vx1^2+vx2^2))
tvz2=fltarr(1)
tvx2=fltarr(1)
maxvx=fltarr(1)
maxvxvxinit=fltarr(1)
tvx2(*)=1

for nfile=nstart,nend,nstep do begin
print, nfile

ll=6
zero=''
nts=strcompress(string(nfile),/remove_all)
lnt=strlen(nts)
for j=1,ll-lnt do zero=zero+'0'
           fname='vortonly'+zero+nts

pload,nfile, /silent

!p.position=0
nx = nx1
nz = nx2
slice= 0


a=total(abs(vx2))/totalke0 ; total vy^2
b=total(abs(vx1))/totalke0 ; total vx^2
c=max(vx2)
d=max(vx2-initv2)
tvz2=[tvz2, a]
tvx2=[tvx2, b]
maxvx=[maxvx, c]
maxvxvxinit=[maxvxvxinit, d]
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
var(4,*,*)=(1.4*prs/rho)
;var(4,*,*)=vx1
str=strarr(6,20)
str(0,*)="density)"
str(1,*)="V!DX!N"
str(2,*)="V!DZ!N"
str(3,*)="vort"
str(4,*)="V!DTH!N!U2!N"
str(5,*)="vx1"

for usingps=0,1 do begin

if ( usingps ) then begin
set_plot,'ps'
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet, /nomatch, xsize=6, ysize=6
cbarchar=1.9
xyout=1.9
endif else begin


endelse



xx=x1*ar
yy=x2

;p1 = !P & x1 = !X & y1 = !Y








 cgLoadCT, 33

for i=3,3 do begin


;r=scale_vector(var(i,*,*),4,255)
r=reform(var(i,*,*))
;contour, r, xx,yy,/nodata, title=str(i), xtitle='x', ytitle='y'
p = [0.15, 0.15, 0.98, 0.9]
  ;cgIMAGE, r, POSITION=p, /KEEP_ASPECT_RATIO ;, MISSING_INDEX=3 , scale=4, bottom=190, top=254, background='white'
  cgimage, r, POSITION=p, background='white';, scale=1 ;, /axis, xtitle='x ', ytitle='y'
;cgaxis,0.5,0.1, /xaxis, /normal, xrange=[1,20]
;cgaxis, /xaxis, xRANGE=[0, 100], $
;MINOR=0, MAJOR=3
  cgcontour, r, xx,yy,POSITION=p, /NOERASE, XSTYLE=1, $
      YSTYLE=1,  NLEVELS=10, /nodata, $
      ;title=str(i)+string(min(r), format='(G8.2)')+' '+string(max(r), format='(G8.2)'), $
         title='numerical', $
         xtitle='k!Dh!Nh', $
         charsize=2.25,$
         ;ytitle='Kz', $
      color='black'
imin=min(r)-1e-6
imax=max(r)+1e-6
;cgcolorbar, Position=[p[0], p[1]-0.08, p[2], p[1]-0.06], range=[imin,imax], format='(F5.2)', charsize=cbarchar


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

velovect, cv1,cv2, cx,cy, /noerase,/overplot, position=p , color=cgcolor('white'), len=2.5, thick=3.25
cgloadct,33
endif

endfor






;!p.position=0
;!p.multi=0


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
set_plot,'x'


endfor

f2name='growthratemhd.dat'
OPENW,1,f2name
PRINTF,1, max(x2)/max(x1), growth,FORMAT='(F9.6 , F9.6)'
CLOSE,1
print, totalke0
PRINT, max(x2)/max(x1), ' growth ', growth
end
