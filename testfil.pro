;pro testfil
little_endian=0
!p.multi=0
!p.position=0

!p.charsize=2

window, xs=1800,ys=1200
for ord=3,9 do begin
for cut=1,1 do begin
   IF (little_endian) THEN $
f=rf(0) ELSE $
f=rf(0, /swap_endian)
vx0=reform(f.bx[*,0,*])
vz0=reform(f.bz[*,0,*])
   IF (little_endian) THEN $
f=rf(30) ELSE $
f=rf(30, /swap_endian)
vx=reform(f.bx[*,0,*])
vz=reform(f.bz[*,0,*])
vxraw=vx
vzraw=vz
filter = BUTTERWORTH( SIZE(vx0, /DIMENSIONS) , order=ord, cutoff=cut)  
vx0 = applyfilt(vx0,filter)
vz0 = applyfilt(vz0,filter) 
vx  = applyfilt(vx ,filter)
vz  = applyfilt(vz ,filter)

a=size(vx,/dimensions)
nx=a[0]
ny=a[1]
x1=findgen(nx)
x2=findgen(ny)

vort0=getvort( vx0, vz0,x1,x2,nx,ny)
vort=getvort( vx, vz,x1,x2,nx,ny)
vxvx0= vx-vx0
vzvz0 = vz-vz0
;vortvort0 = getvort( vx-vx0,vz- vz0,x1,x2,nx,ny)
vort=applyfilt(vort,filter)
vort0=applyfilt(vort0,filter)
vortvort0=vort-vort0


print, memory(/current)

cgloadct,33

!p.multi=[0,3,4]
titlstr=strarr(8,30)

var=ptrarr(12)
titlstr=strarr(12,30)

var(0)= ptr_new(vx)
var(1)= ptr_new(vz)
var(2)= ptr_new(vort)
var(3)= ptr_new(vxraw)
var(4)= ptr_new(vzraw)
var(5)= ptr_new(vortvort0)
var(6)= ptr_new(vxvx0)
var(7)= ptr_new(vzvz0)
var(8)= ptr_new(vortvort0)
var(9)= ptr_new(vx0)
var(10)= ptr_new(vz0)
var(11)= ptr_new(vort0)


titlstr(0)= "Vx"
titlstr(1)= "Vz"
titlstr(2)= "Vort"
titlstr(3)= "Vxraw"
titlstr(4)= "Vzraw"
titlstr(5)= "Vort -Vort0"
titlstr(6)= "Vx-Vx0"
titlstr(7)= "Vz-Vz0"
titlstr(8)= "Vort -Vort0"
titlstr(9)= "Vort -Vort0"
titlstr(10)= "Vort -Vort0"
titlstr(11)= "Vort -Vort0"

for i=0,11 do begin
   pos = [0.02, 0.35, 0.98, 0.91]
localimagecopy=*var(i)
 cgIMAGE, localimagecopy, POSITION=pos, /KEEP_ASPECT_RATIO ,background='white', scale=1
 cgcontour, localimagecopy, xx,yy,POSITION=pos, /NOERASE, XSTYLE=1, $
      YSTYLE=1,  NLEVELS=10, /nodata, title=titlstr(i), $
       axiscolor='black',$
      xtitle='x ', ytitle='y'
imin=min(localimagecopy)-1e-6
imax=max(localimagecopy)+1e-6
cgcolorbar, Position=[pos[0], pos[1]-0.04, pos[2], pos[1]-0.03], range=[imin,imax], format='(G12.1)', annotatecolor='black'

endfor

ordstr=strcompress(string(ord),/remove_all)
cutstr=strcompress(string(cut),/remove_all)

fname2="butter_ord_"+ordstr+"_cut_"+cutstr


xyouts, 0.01,0.01, fname2, /normal, charsize=3
im=cgsnapshot(filename=fname2,/nodialog,/jpeg)


print, " Memory usage " , memory(/current)/1024.^3, " GB "

endfor
endfor

cgloadct,0
!p.multi=0
end


