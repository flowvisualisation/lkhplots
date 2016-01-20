xs=900
ys=1250
cgdisplay, xs=xs,ys=ys
pos=cglayout([2,3] , xgap=4, ygap=6, oxmargin=[9,1], oymargin=[7,9])
cgloadct,33
dir="./"
;spawn, "ls "+dir+"usr??????.h5 ",a6

slen=strlen(dir)
;spawn, "ls usr???????.h5 ",a7
sz=size(a6, /dimensions )
sz0=4
arrnum=lonarr(sz0)
for i=0, sz(0)-1 do begin
a2=a6(i)
b=strmid(a2,slen+3,7)
nend2=long(b)
n=nend2(0)
arrnum[i]=n
endfor


nplots=sz(0)
nend=nplots-1
;nbeg=nend-10
nbeg=nend
spawn,'uname', listing
if ( listing ne 'Darwin') then begin
nbeg=4
endif
;for i=nbeg,nplots-1,1 do begin


dir1='nirvqmri/q03/' 
r=h5_read(0,/v, dir=dir1)
vy0=transpose(r.v[1,*,*,*])
tag=511056
print, arrnum(i)
r=h5_read(tag,/v, dir=dir1)
fname='q03'+string(arrnum[i],format='(I07)') 
grd_ctl, model=tag, g,c,dir=dir1
print, c.time

nx=g.nx-1
ny=g.ny-1
nz=g.nz-1

bx=reform(transpose(r.v[0,*,*,*]))
by=reform(transpose(r.v[1,*,*,*]))-vy0
bz=reform(transpose(r.v[2,*,*,*]))
b2=sqrt(bx^2+by^2+bz^2)

dir2='nirvq/q03/' 
r=h5_read(0,/v, dir=dir2)
vy0=transpose(r.v[1,*,*,*])
tag=393256
r=h5_read(tag,/v, dir=dir2 )
grd_ctl, model=tag, g,c,dir=dir2
print, c.time
vx=reform(transpose(r.v[0,*,*,*]))
vy=reform(transpose(r.v[1,*,*,*]))-vy0
vz=reform(transpose(r.v[2,*,*,*]))
v2=sqrt(vx^2+vy^2+vz^2)

v2m=reform(v2[*,*,nz/2])
b2m=reform(b2[*,*,nz/2])
bxm=b2m

qsm=5
ft1=smooth(congrid( abs(fft(v2m, /center)), ny,ny ),qsm)
ft2=smooth(congrid( abs(fft(b2m, /center)), ny,ny ),qsm)
ft3=smooth(congrid( abs(fft(bxm, /center)), ny,ny ),qsm)
ft1=ft1/max(ft1)
ft2=ft2/max(ft2)
ft3=ft3/max(ft3)
lft1=alog10(ft1)
lft2=alog10(ft2)
lft3=alog10(ft3)

cgerase
x=g.x
y=g.y
cgimage,transpose(cgscalevector(alog10(v2m),1,254)),  pos=pos[*,0], title=string(arrnum[i]), /noerase, /keep_aspect
aspect=g.ny*1./(g.nx)
aspect=1.0d/aspect
cgcontour, transpose(v2m),y,x, /noerase, /nodata, title="q=0.3, HD |v|" , pos=pos[*,0] , aspect=aspect, xtitle='Y', ytitle='X'
cgimage,transpose( cgscalevector(alog10(b2m),1,254)),  pos=pos[*,1], /noerase, /keep_aspect, title='B!U2!N'
cgcontour, transpose(v2m),y,x, /noerase, /nodata, title="q=0.3, MHD, |v|" , pos=pos[*,1] , aspect=aspect
;cgimage,cgscalevector(bxm,1,254),  pos=pos[*,2], /noerase, /keep_aspect, title='B!DX!N'
;cgcontour, v2m,x,y, /noerase, /nodata, title="B!DX!N" , pos=pos[*,2] , aspect=aspect
 gft1=mpfit2dpeak(ft1, aa1,/tilt, /moffat)
 gft1g=mpfit2dpeak(ft1, aa1g,/tilt, /gauss)
 gft1l=mpfit2dpeak(ft1, aa1l,/tilt, /lorentz)

 gft2=mpfit2dpeak(ft2, aa2,/tilt, /moffat)
 gft2g=mpfit2dpeak(ft2, aa2g,/tilt, /gauss)
 gft2l=mpfit2dpeak(ft2, aa2l,/tilt, /lorentz)

 gft3=mpfit2dpeak(ft3, aa3,/tilt, /moffat)
cgimage, cgscalevector(lft1,1,254),   /noerase, pos=pos[*,2], /keep_aspect
kxx=findgen(ny)-ny/2
kyy=kxx
 cgcontour, alog10(gft1),kxx,kyy,  /noerase, pos=pos[*,2], aspect=1.0, label=0, xtitle='k!DX!N', ytitle='k!Dy!N', title='DFT(|v|)'
cgimage, cgscalevector(lft2,1,254),   /noerase, pos=pos[*,3], /keep_aspect
 cgcontour, alog10(gft2),kxx,kyy,  /noerase, pos=pos[*,3], aspect=1.0, label=0, xtitle='k!DX!N', title='DFT(|v|)'
;cgimage, cgscalevector(lft3,1,254),   /noerase, pos=pos[*,5], /keep_aspect
; cgcontour, alog10(gft3),kxx,kyy,  /noerase, pos=pos[*,5], aspect=1.0, label=0, xtitle='k!DX!N', title='DFT(B!Dx!N)'




 ny2=ny/2
 ny1=ny-1


kx=findgen(ny2)
ky=kx
th=aa1[6]-!DPI/2
print, 'angle= ',th*!RADEG
xi=ky
yi=ky
xq=ny2+xi*cos(th) - yi *sin(th)
yq=ny2+xi*sin(th) + yi *cos(th)
maxstress=interpolate(ft1,xq,yq)
gaus_int=interpolate(gft1g,xq,yq)
moff_int=interpolate(gft1 ,xq,yq)
lore_int=interpolate(gft1l,xq,yq)



kx=findgen(ny2)
ky=kx
th=aa2[6];-!DPI/2
print, 'angle= ',th*!RADEG
xi=ky
yi=ky
xq=ny2+xi*cos(th) - yi *sin(th)
yq=ny2+xi*sin(th) + yi *cos(th)
maxstress2=interpolate(ft2,xq,yq)
gaus_int2=interpolate(gft2g,xq,yq)
moff_int2=interpolate(gft2 ,xq,yq)
lore_int2=interpolate(gft2l,xq,yq)




ymin=1e-4
px=pos[*,4]
cgplot, kx, maxstress,  /noerase, pos=px, /xlog, /ylog, xrange=[1,ny/2], xtitle='k', yrange=[ymin,1]
cgplot, kx, moff_int, /overplot, pos=px, color='red'
cgplot, kx, gaus_int, /overplot, pos=px, color='green'
cgplot, kx, lore_int, /overplot, pos=px, color='blue'
al_legend, ['Moffat','Gauss','Lorentzian'], linestyle=[0,0,0],colors=['red','green','blue'], /right
px=pos[*,5]
cgplot, kx, maxstress2,  /noerase, pos=px, /xlog, /ylog, xrange=[1,ny/2], xtitle='k', yrange=[ymin,1]
cgplot, kx,moff_int2, /overplot, pos=px, color='red'
cgplot, kx, gaus_int2, /overplot, pos=px, color='green'
cgplot, kx, lore_int2, /overplot, pos=px, color='blue'

;cgplot, kx, ft3[ny2:ny1,ny2],  /noerase, pos=pos[*,8], /xlog, /ylog, xrange=[1,ny/2], xtitle='k'
;cgplot, kx,gft3[ny2:ny1,ny2], /overplot, pos=pos[*,8]

xpos=.5
ypos=.95
cgtext, xpos,ypos, "t="+string(c.time/2/!DPI,format='(F6.1)')+' orbits', /normal

im=cgsnapshot(filename=fname, /jpeg, /nodialog)

;endfor

end
