;
; uses cgimage to plot photonplasma datafiles
; for comparison with the Pessah 2010 paper
;
pro tw15p, background, little_endian
;little_endian = getendian()
;little_endian = 0
;background=0
hires=1
doxwin=1
if ( hires eq 1) then begin
xs=1300
ys=1300
endif else begin
xs=800
ys=800
endelse 
if ( doxwin eq 1 ) then begin
set_plot, 'x'
window, xs=xs, ys=ys
endif else begin
set_plot, 'z'
device, set_resolution=[1300,1100]
endelse

qtag='with_background_'
if ( background eq 1) then begin
qtag='background_subtracted_'
endif
onefile=1
if ( onefile eq 1 ) then begin
qnumq=0
nend=30
nstart=nend
nstep=1
endif else begin
nend=400
nstart=1
if ( background eq 1) then begin
nstart=1
endif
nstep=1
endelse
t=findgen(1)
if( nend gt 0) then begin
t=findgen(nend)
endif

slice=0


   IF (little_endian) THEN $
f=rf(0) ELSE $
f=rf(0, /swap_endian)

downsample=1
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
filter= butterworth(size(vix0, /dimensions), order=3, cutoff=2)
qsm=100
vexsm=real_part(FFT( FFT(vex0, -1) * filter, 1 ) )
vezsm=real_part(FFT( FFT(vez0, -1) * filter, 1 ) )
vixsm=real_part(FFT( FFT(vix0, -1) * filter, 1 ) )
vizsm=real_part(FFT( FFT(viz0, -1) * filter, 1 ) )
bxsm0=real_part(FFT( FFT(bx0, -1) * filter, 1 ) )
bysm0=real_part(FFT( FFT(by0, -1) * filter, 1 ) )
bzsm0=real_part(FFT( FFT(bz0, -1) * filter, 1 ) )
exsm0=real_part(FFT( FFT(ex0, -1) * filter, 1 ) )
eysm0=real_part(FFT( FFT(ey0, -1) * filter, 1 ) )
ezsm0=real_part(FFT( FFT(ez0, -1) * filter, 1 ) )


initionvort=getvort(vixsm,vizsm,xx,yy,nx,nz)
jx0=getvort(bysm0,bzsm0,xx,yy,nx,nz) -ex0
curlB0=getvort(bxsm0,bzsm0,xx,yy,nx,nz) 
jy0=curlB0 -ey0
jz0=getvort(bxsm0,bysm0,xx,yy,nx,nz) -ez0
vixsm0=vixsm
vizsm0=vizsm

initelecvort=getvort(vexsm,vezsm,xx,yy,nx,nz)
vexsm0=vexsm
vezsm0=vezsm

totalelecke0=total(vex0^2+vez0^2)
totalionke0=total(vix0^2+viz0^2)
gamma=fltarr(1)
tvx2=fltarr(1)
tvx2(*)=1

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
f=rf(nfile) ELSE $
f=rf(nfile, /swap_endian)
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


qqtag=" backgr included"
if (background eq 1) then begin
qqtag=" backgr. subtracted"
endif
mesg='t='+string(f.s.time,format='(F12.5)')+' , '+qqtag+' ncellsx '+string(f.s.gn[0])+' '+string(f.s.ds(0))
f=0

a=total(vex^2)/totalelecke0
b=total(vix^2)/totalionke0
gamma=[gamma, a]
tvx2=[tvx2, b]
;print, size(gamma)


for usingps=0,1 do begin

if ( usingps ) then begin
set_plot,'ps'
device,filename=fname+'.eps',/encapsulated
device, /color
!p.font=0
device, /times
xs=11.
ys=12
!p.charsize=1.8
DEVICE, XSIZE=xs, YSIZE=ys, /INCHES
endif else begin
set_plot,'x'
!p.font=-1
!p.color=0
!p.background=255
!p.charsize=1.8
;window, xs=1100,ys=800
;device, Set_Resolution=[1100,800]
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
vexsm=real_part(FFT( FFT(vex, -1) * filter, 1 ) )
vezsm=real_part(FFT( FFT(vez, -1) * filter, 1 ) )
vixsm=real_part(FFT( FFT(vix, -1) * filter, 1 ) )
vizsm=real_part(FFT( FFT(viz, -1) * filter, 1 ) )
bxsm=real_part(FFT( FFT(bx, -1) * filter, 1 ) )
bysm=real_part(FFT( FFT(by, -1) * filter, 1 ) )
bzsm=real_part(FFT( FFT(bz, -1) * filter, 1 ) )
exsm=real_part(FFT( FFT(ex, -1) * filter, 1 ) )
eysm=real_part(FFT( FFT(ey, -1) * filter, 1 ) )
ezsm=real_part(FFT( FFT(ez, -1) * filter, 1 ) )

jx=getvort(bysm,bzsm,xx,yy,nx,nz)-exsm
jy=getvort(bxsm,bzsm,xx,yy,nx,nz)-eysm
curlB=getvort(bxsm,bzsm,xx,yy,nx,nz)
jz=getvort(bxsm,bysm,xx,yy,nx,nz)-ezsm
if (background eq 1 ) then var(0)=ptr_new(vixsm-vixsm0)
if (background eq 1 ) then var(1)=ptr_new(vizsm-vizsm0)
;var(0,*,*)=smooth(var(0,*,*), qsm, /edge_wrap)
;var(1,*,*)=smooth(var(1,*,*), qsm, /edge_wrap)
var(0)=ptr_new( vixsm)
var(1)=ptr_new( vizsm)
;vixsm=vix
;vizsm=viz
vortion=getvort(vixsm,vizsm,xx,yy,nx,nz)
;vortion=getvort(bx,bz,xx,yy,nx,nz)
if (background eq 1 ) then begin
;var(2) =ptr_new( vortion-initionvort)
var(2)=ptr_new(getvort(vixsm-vixsm0,vizsm-vizsm0,xx,yy,nx,nz) )
endif else begin
        var(2)=ptr_new( vortion)
endelse

var(3)=ptr_new( vexsm)
if (background eq 1 ) then var(3)=ptr_new(vexsm-vexsm0)
var(4)=ptr_new( vezsm)
if (background eq 1 ) then var(4)=ptr_new(vezsm-vezsm0)
vortelec=getvort(vexsm,vezsm,xx,yy,nx,nz)
if (background eq 1 ) then begin
;var(5)=ptr_new( vortelec-initelecvort)
var(5)=ptr_new(getvort(vexsm-vexsm0,vezsm-vezsm0,xx,yy,nx,nz) )
endif else begin
var(5)=ptr_new( vortelec)
endelse
var(6)=ptr_new(ex)
var(7)=ptr_new(eysm)
var(8)=ptr_new(curlB)
var(9)=ptr_new(bxsm)
var(10)=ptr_new(by)
var(11)=ptr_new(bzsm)
var(12)=ptr_new(jx)
var(13)=ptr_new(jy)
var(14)=ptr_new(jz)
if (background eq 1 ) then begin
var(6)=ptr_new(ex-ex0)
var(7)=ptr_new(eysm-eysm0)
var(8)=ptr_new(curlB-curlB0)
var(9)=ptr_new(bxsm-bxsm0)
var(10)=ptr_new(by-by0)
var(11)=ptr_new(bzsm-bzsm0)
var(12)=ptr_new(jx-jx0)
var(13)=ptr_new(jy-jy0)
var(14)=ptr_new(jz-jz0)
endif

titlstr=strarr(15,30)
titlstr(0,*)="V!Dion, X!N"
titlstr(1,*)="V!Dion, Z!N"
titlstr(2,*)="Ion Vorticity"
titlstr(3,*)="V!Delec, X!N"
titlstr(4,*)="V!Delec, Z!N"
titlstr(5,*)="Electron Vorticity"
titlstr(6,*)="E!DX!N"
titlstr(7,*)="E!DY!N"
titlstr(8,*)="(Curl B)!DY!N"
titlstr(9,*)="B!DX!N"
titlstr(10,*)="B!DY!N"
titlstr(11,*)="B!DZ!N"
titlstr(12,*)="J!DX!N"
titlstr(13,*)="J!DY!N"
titlstr(14,*)="J!DZ!N"

for  qgmq = 0,14 do begin
a=*var(qgmq)
mx=max(a)
mn=min(a)
titlstr(qgmq,*) = titlstr(qgmq,*)+' , ' +string(mn, format='(F8.5)')+string(mx , format='(F8.5)')

endfor



;contour, vez, xx,yy,/nodata, title='V!Delec, Z!N'
;tvimage, r, /overplot

 cgLoadCT, 33, CLIP=[5, 245]

for i=0,14 do begin
   pos = [0.02, 0.35, 0.98, 0.91]
localimagecopy=reform(*var(i))
 cgIMAGE, localimagecopy, POSITION=pos, /KEEP_ASPECT_RATIO ,background='white', scale=1
 cgcontour, localimagecopy, xx,yy,POSITION=pos, /NOERASE, XSTYLE=1, $
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
;cgplot,  gamma, title='Total x-kinetic energy',color='black' ;, /xlog, /ylog
;cgplot,  tvx2, /overplot, color='black'

xyouts, 0.01,0.01,$
   mesg, /normal, charsize=3

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


print, MEMORY(/CURRENT)/1024./1024.,  'MB'
var=0
heap_Free, var
;print,a,b
endfor

cgloadct,0, /reverse
end
