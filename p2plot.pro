
doannotation=1
dogrowth=1
background=1
xs=1300
window, xs=xs, ys=0.5*xs
nend=200
dt=0.1

varfile='VAR0'
pc_read_var, obj=f0, varfile=varfile, /trimall
v1=f0.uu[*,*,0]
v2=f0.uu[*,*,1]
initv1=f0.uu[*,*,0]
initv2=f0.uu[*,*,1]

print, mx, my
print, x
print, y
x1=x[3:mx-4]*2*!PI
x2=y[3:my-4]*2*!PI; *fix(x1)/x2
aspectratio=max(x2)/max(x1)
x1=x[3:mx-4]*2*!PI*aspectratio
nx=mx-6
ny=my-6

initvort=getvort( initv1,initv2, x1,x2,nx,ny)

totkez=total(v2^2)
totkex=total(v1^2)
totke=total(sqrt(v1^2+v2^2))
time=fltarr(1)
kez=fltarr(1)
kex=fltarr(1)
kez[0]=totkez/totke
kex[0]=totkex/totke

!p.position=0

for i=1,nend do begin
tag=string(i, format='(I0)')
tag2=string(i, format='(I06)')
filetag='v1v2pencil_kh'+tag2
if (background eq 1) then begin
filetag='v1v2pencil_kh_no_background'+tag2
endif
fname=filetag



varfile='VAR1'
varfile='VAR'+tag
path='data/proc0/'

if (  file_test(path+varfile)  ne 1 ) then begin
print, varfile+' does not exist, exiting'
break
endif
pc_read_var, obj=ff, varfile=varfile, /trimall
v1=ff.uu[*,*,0]
v2=ff.uu[*,*,1]
vort=getvort( v1,v2, x1,x2,nx,ny)

totkez=total(abs(v2))/totke
totkex=total(abs(v1))/totke
time=[time,i*dt]
kez=[kez,totkez]
kex=[kex,totkex]

a=vort
if ( background eq 1) then begin
a=vort-initvort
endif

for usingps=0,1 do begin

if ( usingps ) then begin
set_plot,'ps'
device,filename=fname+'.eps',/encapsulated
device, /color
!p.font=0
device, /times
xs=8.
ys=4
DEVICE, XSIZE=xs, YSIZE=ys, /INCHES
!p.charsize=0.9
cbarchar=0.9
xyout=0.9
legchar=0.9
xychar=0.9
endif else begin
set_plot,'x'
!p.font=-1
;!p.color=0
;!p.background=255
!p.charsize=1.8
cbarchar=1.3
legchar=1.9
xyout=1.8
xychar=1.9
;device, set_resolution=[1100,800]
endelse
!p.position=0
!p.multi=[0,2,1]


var=fltarr(3,nx,ny)
str_g=strarr(3,80)
var(0,*,*)=v1
var(1,*,*)=v2
if ( background eq 1 ) then begin
var(0,*,*)=v1-initv1
var(1,*,*)=v2-initv2
endif
var(2,*,*)=a
str_g(0,*)="V!DX!N , "
str_g(1,*)="V!DZ!N , "
str_g(2,*)="Vorticity , "


cgloadct,33


for qq=2,2 do begin
pos=[0.2,0.2,0.98,.95]
r=reform(var(qq,*,*))
imin=min(r)
imax=max(r)
cgimage,r, position=pos, background='white',  scale=1 
cgcontour,x1#x2,x1,x2,/nodata,/noerase, position=pos, background='white', title=str_g(qq)+string(min(r), format='(G8.2)')+' '+string(max(r), format='(G8.2)'), xtitle='x', ytitle='z', axiscolor='black'
cgcolorbar, Position=[pos[0], pos[1]-0.08, pos[2], pos[1]-0.06], range=[imin,imax], format='(G8.2)', charsize=cbarchar,  annotatecolor='black'


if ( qq eq 2) then begin 
q=23
if (background eq 1) then begin
cv1=congrid(v1-initv1,q,q)
cv2=congrid(v2-initv2,q,q)
endif else begin
cv1=congrid(v1,q,q)
cv2=congrid(v2,q,q)
endelse
cx=congrid(x1,q)
cy=congrid(x2,q)

velovect, cv1,cv2, cx,cy, /noerase,/overplot, position=pos , color=cgcolor('white'), len=2.5, thick=1.25

endif

endfor

legcolors=['blue','red']
cgplot, time, kez, xrange=[0.1,10], yrange=[1e-1,1], color=legcolors[0], $ 
      xtitle='time', ytitle='E', $
      linestyle=0, psym=-16, /ylog, title='Energy', axiscolor='black' ;, position=pos
cgplot, time, kex, /overplot, color=legcolors[1], linestyle=2, psym=-17 
al_legend, [ 'vz!U2!N','vx!U2!N'], PSym=[-16,-17], $
      LineStyle=[0,2], Color=legcolors,textcolors=legcolors, $ 
      charsize=legchar, /left, outline_color='black'

tnorm=time

nel=n_elements(kez)
gam2=[0.1, 0.2]
tam2=interpol( tnorm(0:nel-1),kez, gam2)

print, tam2
print, gam2
growth=(gam2[1]-gam2[0])/(tam2[1]-tam2[0])
;growth=(alog10(gam2[1])-alog10(gam2[0]))/(tam2[1]-tam2[0])

if ( dogrowth ) then begin
;oplot,t,exp(growth*t/0.1)*gam2[0]/exp(growth*tam2[0]/0.1)
cgplot, tnorm, (growth*(tnorm-tam2[0]))+(gam2[0]) ,  /overplot
cgplot, tam2, (gam2), psym=-18, /overplot
endif


tsound=1

if ( doannotation eq 1) then begin
xyouts, 0.01,0.01,$
   'KH , t='+string(i*dt,format='(F5.1)')+ $
     ', growth rate'+string(growth, format='(F7.4)')+$
      ', aspect ratio '+string(aspectratio, format='(F7.4)')+$
      ' , t!DS!N'+string(tsound, format='(F7.4)'),$
         color=cgcolor('black'), $
   /normal, charsize=xychar
endif



if ( usingps ) then begin
device,/close
set_plot,'x'

endif else begin
;set_plot,'x'
fname2=fname
im=cgsnapshot(filename=fname2,/nodialog,/jpeg)
endelse

endfor

endfor

!p.multi=0
end
