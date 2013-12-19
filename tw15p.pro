;
; uses cgimage to plot photonplasma datafiles
; for comparison with the Pessah 2010 paper
;
pro tw15p, nobackground=nobackground, big_endian=big_endian, lowres=lowres, zbuf=zbuf, maxnum=maxnum
background=0
if (keyword_set(nobackground) )then begin
background=1
endif
little_endian=1
if (keyword_set(big_endian) ) then begin
little_endian=0
endif
;little_endian = getendian()
;little_endian = 0
hires=1
doxwin=1
if ( keyword_set(lowres)) then begin
xs=800
ys=800
endif else begin
xs=1300
ys=1300
endelse 
if ( keyword_set(zbuf) ) then begin
set_plot, 'z'
device, set_resolution=[1300,1100], Decomposed=1, Set_Pixel_Depth=24
endif else begin
set_plot, 'x'
window, xs=xs, ys=ys
endelse

qtag='with_background_'
if ( background eq 1) then begin
qtag='background_subtracted_'
endif
onefile=0
if ( onefile eq 1 ) then begin
qnumq=0
nend=30
nstart=nend
nstep=1
endif else begin
nend=400
nstart=0
if ( background eq 1) then begin
nstart=0
endif
nstep=1
endelse

if (keyword_set(maxnum) ) then begin
nend=1
endif


t=findgen(1)
if( nend gt 0) then begin
t=findgen(nend)
endif

slice=0


   IF (little_endian) THEN $
f=rf(0, /b,/den, /e, /vel) ELSE $
f=rf(0, /b,/den, /e, /vel, /swap_endian)

downsample=10
nx=f.s.gn[0]/downsample
nz=f.s.gn[2]/downsample
xx=findgen(nx)
yy=findgen(nz)

vix0=congrid(reform(f.v[*,slice,*,0,1]/f.d[*,slice,*,1]),nx,nz)
viy0=congrid(reform(f.v[*,slice,*,1,1]/f.d[*,slice,*,1]),nx,nz)
viz0=congrid(reform(f.v[*,slice,*,2,1]/f.d[*,slice,*,1]),nx,nz)
vex0=congrid(reform(f.v[*,slice,*,0,0]/f.d[*,slice,*,0]),nx,nz)
vey0=congrid(reform(f.v[*,slice,*,1,0]/f.d[*,slice,*,0]),nx,nz)
vez0=congrid(reform(f.v[*,slice,*,2,0]/f.d[*,slice,*,0]),nx,nz)
bx0=congrid(reform(f.bx[*,slice,*]),nx,nz)
by0=congrid(reform(f.by[*,slice,*]),nx,nz)
bz0=congrid(reform(f.bz[*,slice,*]),nx,nz)
ex0=congrid(reform(f.ex[*,slice,*]),nx,nz)
ey0=congrid(reform(f.ey[*,slice,*]),nx,nz)
ez0=congrid(reform(f.ez[*,slice,*]),nx,nz)

f=0
;filter= butterworth(size(vix0, /dimensions), order=2, cutoff=10)
;filter= butterworth(size(vix0, /dimensions), order=3, cutoff=1)
;filter= butterworth(size(vix0, /dimensions), order=6, cutoff=2)
filter= chebyfil(size(vix0, /dimensions), order=6, cutoff=2)
qsm=100
vexsm=applyfilt(vex0, filter)
vezsm=applyfilt(vez0, filter)
vixsm=applyfilt(vix0, filter)
vizsm=applyfilt(viz0, filter)
bxsm0=applyfilt(bx0, filter)
bysm0=applyfilt(by0, filter)
bzsm0=applyfilt(bz0, filter)
exsm0=applyfilt(ex0, filter)
eysm0=applyfilt(ey0, filter)
ezsm0=applyfilt(ez0, filter)


initionvort=getvort(vixsm,vizsm,xx,yy,nx,nz)

initionvort=applyfilt(initionvort,filter)
jx0=getvort(bysm0,bzsm0,xx,yy,nx,nz) -ex0
curlB0=getvort(bxsm0,bzsm0,xx,yy,nx,nz) 
curlB0=applyfilt(curlB0, filter)
jy0=curlB0 -eysm0
jz0=getvort(bxsm0,bysm0,xx,yy,nx,nz) -ez0
vixsm0=vixsm
vizsm0=vizsm

initelecvort=getvort(vexsm,vezsm,xx,yy,nx,nz)
initelecvort=applyfilt(initelecvort,filter)
vexsm0=vexsm
vezsm0=vezsm

totalelecke0=total(vex0^2+vez0^2)
totalionke0=total(vix0^2+viz0^2)
totalb0=total(bx0^2+bz0^2)
totalen=totalb0+totalelecke0+totalionke0
tvz2=fltarr(1)
tvx2=fltarr(1)
tbx2=fltarr(1)
tbz2=fltarr(1)
maxvz2=fltarr(1)
maxvdiff=fltarr(1)

for nfile=nstart,nend,nstep do begin
print, ' nfile= ' , nfile

ll=6
zero=''
nts=strcompress(string(nfile),/remove_all)
lnt=strlen(nts)
for j=1,ll-lnt do zero=zero+'0'
           fname='ebvd_'+qtag+zero+nts


varfile='VAR1'
tag=zero+nts+'.dat'
varfile='fields-'+tag
path='Data/'

if (  file_test(path+varfile)  ne 1 ) then begin
print, varfile+' does not exist, exiting'
break
endif

   IF (little_endian) THEN $
f=rf(nfile, /b,/den, /e, /vel) ELSE $
f=rf(nfile, /b,/den, /e, /vel, /swap_endian)
;p=rp(nfile, /wrap)

!p.position=0
;nx = f.s.gn[0]
;nz = f.s.gn[2]
nx1=findgen(nx)
nx2=findgen(nz)
;print, nx,nz
slice= f.s.gn[1]/2

bx=congrid(reform(f.bx[*,slice,*]),nx,nz)
by=congrid(reform(f.by[*,slice,*]),nx,nz)
bz=congrid(reform(f.bz[*,slice,*]),nx,nz)
ex=congrid(reform(f.ex[*,slice,*]),nx,nz)
ey=congrid(reform(f.ey[*,slice,*]),nx,nz)
ez=congrid(reform(f.ez[*,slice,*]),nx,nz)
vix=congrid(reform(f.v[*,slice,*,0,1]/f.d[*,slice,*,1]),nx,nz)
viy=congrid(reform(f.v[*,slice,*,1,1]/f.d[*,slice,*,1]),nx,nz)
viz=congrid(reform(f.v[*,slice,*,2,1]/f.d[*,slice,*,1]),nx,nz)
vex=congrid(reform(f.v[*,slice,*,0,0]/f.d[*,slice,*,0]),nx,nz)
vey=congrid(reform(f.v[*,slice,*,1,0]/f.d[*,slice,*,0]),nx,nz)
vez=congrid(reform(f.v[*,slice,*,2,0]/f.d[*,slice,*,0]),nx,nz)

spawn, "echo ${PWD##*/}" , dir
qqtag=" backgr incl"
if (background eq 1) then begin
qqtag=" backgr. subtr"
endif
mesg=dir+' t='+string(f.s.time,format='(F12.5)')+' , '+qqtag+' ncellsx '+string(f.s.gn[0])+' '+string(f.s.ds(0))
f=0


for usingps=0,1 do begin

if ( usingps ) then begin
set_plot,'ps'
device,filename=fname+'.eps',/encapsulated
device, /color
!p.font=0
device, /times
pxs=11.
pys=12
!p.charsize=1.8
DEVICE, XSIZE=pxs, YSIZE=pys, /INCHES
endif else begin
!p.font=-1
!p.color=0
!p.background=255
!p.charsize=1.8
legchar=0.6
;window, xs=1100,ys=800
;device, Set_Resolution=[1100,800]
if ( keyword_set(zbuf) ) then begin
set_plot, 'z'
device, set_resolution=[1300,1100], Decomposed=1, Set_Pixel_Depth=24
endif else begin
legchar=1.1
set_plot, 'x'
;window, xs=xs, ys=ys
legchar=0.6
endelse
endelse

;window, xs=1100,ys=800
dophasespace=0
!p.multi=[0,3,5]
 if ( dophasespace eq 1) then begin
!p.multi=[0,4,4]
endif
!x.style=1
!y.style=1


xx=findgen(nx)
yy=findgen(nz)

p1 = !P & x1 = !X & y1 = !Y


elec=0
ion=1
xdir=0
ydir=1
zdir=2
px=0
py=1
pz=2

;qnparq=n_Elements(p.r[*,xdir,elec])
;var=fltarr(16,qnparq)

titlstr=strarr(15,30)



;;
;;  
;;;

ux=vix
uy=viy
uz=viz

var=ptrarr(15)
;help,var, vex,vey,vez
vexsm=applyfilt(vex, filter )
vezsm=applyfilt(vez, filter )
vixsm=applyfilt(vix, filter )
vizsm=applyfilt(viz, filter )
bxsm =applyfilt(bx , filter )
bysm =applyfilt(by , filter )
bzsm =applyfilt(bz , filter )
exsm =applyfilt(ex , filter )
eysm =applyfilt(ey , filter )
ezsm =applyfilt(ez , filter )


jx=getvort(bysm,bzsm,xx,yy,nx,nz)-exsm
jy=getvort(bxsm,bzsm,xx,yy,nx,nz)-eysm
curlB=getvort(bxsm,bzsm,xx,yy,nx,nz)
curlB=applyfilt(curlB, filter)
jz=getvort(bxsm,bysm,xx,yy,nx,nz)-ezsm
vortion=getvort(vixsm,vizsm,xx,yy,nx,nz)
vortelec=getvort(vexsm,vezsm,xx,yy,nx,nz)
vortion=applyfilt(vortion,filter)
vortelec=applyfilt(vortelec,filter)


a=(max(vexsm-vexsm0))
b=(max(vezsm-vezsm0))
c=(max(bxsm-bxsm0))
d=(max(bzsm-bzsm0))
;e=max(jy-jy0)
;f=max(vezsm-vezsm0)
a=max(vixsm)
b=max(vizsm)
e=max(vexsm)
f=max(vezsm)
print, 'maxvx', e, 'maxvz',f
tvz2=[tvz2, a]
tvx2=[tvx2, b]
tbx2=[tbx2, c]
tbz2=[tbz2, d]
maxvz2=[maxvz2, e]
maxvdiff=[maxvdiff, f]
print, a,b,c,d,e,f

if (background eq 1 ) then begin
 var(0)=ptr_new(vixsm-vixsm0)
var(1)=ptr_new(vizsm-vizsm0)
vort1=getvort(vixsm-vixsm0,vizsm-vizsm0,xx,yy,nx,nz) 
vort1=applyfilt(vort1,filter)
var(2)=ptr_new(vort1)
var(3)=ptr_new(vexsm-vexsm0)
var(4)=ptr_new(vezsm-vezsm0)
vort2=getvort(vexsm-vexsm0,vezsm-vezsm0,xx,yy,nx,nz) 
vort2=applyfilt(vort2,filter)
var(5)=ptr_new(vort2)
var(6)=ptr_new(ex-ex0)
var(7)=ptr_new(eysm-eysm0)
var(8)=ptr_new(curlB-curlB0)
var(9)=ptr_new(bxsm-bxsm0)
var(10)=ptr_new(by-by0)
var(11)=ptr_new(bzsm-bzsm0)
var(12)=ptr_new(jx-jx0)
var(13)=ptr_new(jy-jy0)
var(14)=ptr_new(jz-jz0)
endif else begin
var(0)=ptr_new( vixsm)
var(1)=ptr_new( vizsm)
var(2)=ptr_new( vortion)
var(3)=ptr_new( vexsm)
var(4)=ptr_new( vezsm)
var(5)=ptr_new( vortelec)
var(6)=ptr_new(jx)
var(7)=ptr_new(jy)
var(8)=ptr_new(jz)
var(9)=ptr_new(bxsm)
var(10)=ptr_new(by)
var(11)=ptr_new(bzsm)
var(12)=ptr_new(curlB)
var(13)=ptr_new(eysm)
var(14)=ptr_new(ex)
endelse



titlstr=strarr(15,30)
titlstr(0,*)="V!Dion, X!N"
titlstr(1,*)="V!Dion, Z!N"
titlstr(2,*)="Ion Vorticity"
titlstr(3,*)="V!Delec, X!N"
titlstr(4,*)="V!Delec, Z!N"
titlstr(5,*)="Electron Vorticity"
titlstr(6,*)="J!DX!N"
titlstr(7,*)="J!DY!N"
titlstr(8,*)="J!DZ!N"
titlstr(9,*)="B!DX!N"
titlstr(10,*)="B!DY!N"
titlstr(11,*)="B!DZ!N"
titlstr(12,*)="(Curl B)!DY!N"
titlstr(13,*)="E!DY!N"
titlstr(14,*)="E!DX!N"

for  qgmq = 0,13 do begin
a=*var(qgmq)
mx=max(a)
mn=min(a)
titlstr(qgmq,*) = titlstr(qgmq,*)+' , ' +string(mn, format='(G8.2)')+string(mx , format='(G8.2)')

endfor



;contour, vez, xx,yy,/nodata, title='V!Delec, Z!N'
;tvimage, r, /overplot

 cgLoadCT, 33, CLIP=[5, 245]

for i=0,13 do begin
   pos = [0.02, 0.35, 0.98, 0.91]
localimagecopy=reform(*var(i))
 cgIMAGE, localimagecopy, POSITION=pos, /KEEP_ASPECT_RATIO ,background='white', scale=1
 cgcontour, xx#yy, xx,yy,POSITION=pos, /NOERASE, XSTYLE=1, $
      YSTYLE=1,  NLEVELS=10, /nodata, title=titlstr(i), $
       axiscolor='black',$
      xtitle='x ', ytitle='y'
imin=min(localimagecopy)-1e-6
imax=max(localimagecopy)+1e-6
cgcolorbar, Position=[pos[0], pos[1]-0.04, pos[2], pos[1]-0.03], range=[imin,imax], format='(G12.1)', annotatecolor='black'

q=25
if ( i eq 8 or i eq 2 or i eq 5) then begin
case i>2<8 of
2:    begin
        if ( background eq 1 ) then begin
        cv1=congrid(vixsm-vixsm0,q,q)
        cv2=congrid(vizsm-vizsm0,q,q)
        endif else begin
        cv1=congrid(vixsm,q,q)
        cv2=congrid(vizsm,q,q)
        endelse
      end
5: begin
        if ( background eq 1 ) then begin
        cv1=congrid(vexsm-vexsm0,q,q)
        cv2=congrid(vezsm-vezsm0,q,q)
        endif else begin
        cv1=congrid(vexsm,q,q)
        cv2=congrid(vezsm,q,q)
        endelse 
end
8: begin
        if ( background eq 1 ) then begin
        cv1=congrid(bxsm-bxsm0,q,q)
        cv2=congrid(bzsm-bzsm0,q,q)
        endif else begin
        cv1=congrid(bxsm,q,q)
        cv2=congrid(bzsm,q,q)
        endelse 
end
endcase
cx=congrid(xx,q)
cy=congrid(yy,q)

velovect, cv1,cv2, cx,cy, /noerase,/overplot, position=pos , color=cgcolor('white'), c_thick=4
cgloadct,33
endif
endfor


!x.range=0
!y.range=0

cgplot,     tvz2, title='Growth vs time',color='black',  /ylog, yrange=[1e-4,1e-0]
cgplot,     tvx2,  /overplot, color='blue'  , psym=-15, linestyle=2
cgplot,     tbx2,  /overplot, color='green' , psym=-16, linestyle=3
cgplot,     tbz2,  /overplot, color='red'   , psym=-17, linestyle=4
cgplot,   maxvz2,  /overplot, color='orange', psym=-18, linestyle=5
cgplot,  maxvdiff, /overplot, color='violet', psym=-19, linestyle=1


al_legend, ['ViX','ViZ', 'bx','bz','VeX','VeZ'], PSym=[-14,-15,-16,-17,-18,-19], $
      LineStyle=[0,2,3,4,5,1], Color=['black','blue','green','red','orange','violet'], charsize=legchar, /left

xyouts, 0.01,0.01,$
   mesg, /normal, charsize=2

!p.position=0
!p.multi=0


if ( usingps ) then begin
device,/close
;set_plot,'x'
if ( keyword_set(zbuf) ) then begin
set_plot, 'z'
device, set_resolution=[1300,1100], Decomposed=1, Set_Pixel_Depth=24
endif else begin
set_plot, 'x'
endelse
endif else begin
;set_plot,'x'
if ( keyword_set(zbuf) ) then begin
set_plot, 'z'
device, set_resolution=[1300,1100], Decomposed=1, Set_Pixel_Depth=24
endif else begin
set_plot, 'x'
endelse
fname2=fname
im=cgsnapshot(filename=fname2,/nodialog,/jpeg)
endelse

endfor
;set_plot,'x'


print, MEMORY(/CURRENT)/1024./1024.,  'MB'
var=0
heap_Free, var
;print,a,b
endfor

cgloadct,0, /reverse
end
