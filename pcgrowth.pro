pro pcgrowth, mx,my,mz,x1 
xs=800
window,xs=xs,ys=1.6*xs
background=1
nend=84
dt=0.1

varfile='VAR0'
pc_read_var, obj=f0, varfile=varfile, /trimall, /bb
v1=f0.uu[*,*,0]
v2=f0.uu[*,*,1]
initv1=v1
initv2=v2
b1=f0.bb[*,*,0]
b2=f0.bb[*,*,1]
initb1=f0.bb[*,*,0]
initb2=f0.bb[*,*,1]

print, mx, my
print, x
print, y
x1=x[3:mx-4]
x2=y[3:my-4]
nx=mx-6
ny=my-6

initvort=getvort( initb1,initb2, x1,x2,nx,ny)

totbez=total(b2^2)
totbex=total(b1^2)
totbe=total(b1^2+b2^2)
totvez=total(v2^2)
totvex=total(v1^2)
totve=total(v1^2+v2^2)
time=fltarr(1)
bez=fltarr(1)
bex=fltarr(1)
vez=fltarr(1)
vex=fltarr(1)
bez[0]=totbez/totbe
bex[0]=totbex/totbe
vez[0]=totvez/totbe
vex[0]=totvex/totbe


for i=0,nend do begin
tag=string(i, format='(I0)')
tag2=string(i, format='(I06)')
filetag='pencil_kh'+tag2
fname=filetag



varfile='VAR1'
varfile='VAR'+tag
path='data/proc0/'

if (  file_test(path+varfile)  ne 1 ) then begin
print, varfile+' does not exist, exiting'
break
endif
pc_read_var, obj=ff, varfile=varfile, /trimall, /bb
b1=ff.bb[*,*,0]
b2=ff.bb[*,*,1]
v1=ff.uu[*,*,0]
v2=ff.uu[*,*,1]
vort=getvort( b1,b2, x1,x2,nx,ny)

totbez=total(b2^2)/totbe
totbex=total(b1^2)/totbe
totvez=total(v2^2)/totbe
totvex=total(v1^2)/totbe
time=[time,i*dt]
bez=[bez,totbez]
bex=[bex,totbex]
vez=[vez,totvez]
vex=[vex,totvex]

a=vort-initvort

for usingps=0,1 do begin

if ( usingps ) then begin
set_plot,'ps'
device,filename=fname+'.eps',/encapsulated
device, /color
!p.font=0
device, /times
legchar=0.9
xs=10.
ys=6
DEVICE, XSIZE=xs, YSIZE=ys, /INCHES
!p.charsize=0.9
cbarchar=0.9
xyout=0.9
endif else begin
set_plot,'x'
!p.font=-1
;!p.color=0
;!p.background=255
!p.charsize=1.8
cbarchar=1.8
legchar=1.4
xyout=1.8
;device, set_resolution=[1100,800]
endelse


cgloadct,33
!p.multi=[0,1,2]
pos=[0.1,0.1,0.98,.9]
cgimage,a, position=pos, background='white'
cgcontour,x1#x2,x1,x2,/nodata,/noerase, position=pos, background='white', title='Current', xtitle='x', ytitle='z', axiscolor='black'
q=25
if (background eq 1) then begin
cv1=congrid(b1-initb1,q,q)
cv2=congrid(b2-initb2,q,q)
endif else begin
cv1=congrid(b1,q,q)
cv2=congrid(b2,q,q)
endelse
cx=congrid(x1,q)
cy=congrid(x2,q)

cgloadct,0
velovect, cv1,cv2, cx,cy, /noerase,/overplot, position=pos , color=cgcolor('white')

cgplot, time, bez, xrange=[0.1,10], yrange=[1e-5,1], color='blue', linestyle=0, psym=-16, /xlog, /ylog, title='Energy', axiscolor='black'
cgplot, time, bex, /overplot, color='red', linestyle=2, psym=-17 
cgplot, time, vez, /overplot, color='green', linestyle=3, psym=-18 
cgplot, time, vex, /overplot, color='orange', linestyle=4, psym=-19 
legcolors=['blue','red','green','orange']
al_legend, ['bz!U2!N','bx!U2!N', 'v1!U2!N','v2!U2!N'], PSym=[-16,-17,-18,-19], $
      LineStyle=[0,2,3,4], Color=legcolors,textcolors=legcolors, charsize=legchar, /left, outline_color='black'



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
