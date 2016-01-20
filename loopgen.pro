xs=1200
ys=1250
cgdisplay, xs=xs,ys=ys
cgloadct,33
dir="./"


mytime1=systime(1)
spawn, "ls "+dir+"usr??????.h5 ",a6

slen=strlen(dir)
;spawn, "ls usr???????.h5 ",a7
sz=size(a6, /dimensions )
arrnum=lonarr(sz(0))
for i=0, sz(0)-1 do begin
a2=a6(i)
b=strmid(a2,slen+3,7)
nend2=long(b)
n=nend2(0)
arrnum[i]=n
endfor

pos=cglayout([3,3] , xgap=4, ygap=6, oxmargin=[9,1], oymargin=[7,9])

nplots=sz(0)
nend=nplots-4
;nbeg=nend-10
nbeg=nend
spawn,'uname', listing
if ( listing ne 'Darwin') then begin
nbeg=nend-1
endif
for i=nbeg,nplots-1,1 do begin


print, arrnum(i)
r=h5_read(arrnum(i),/v, /b )
fname='q15'+string(arrnum[i],format='(I07)') 
grd_ctl, model=arrnum[i], g,c

nx=g.nx-1
ny=g.ny-1
nz=g.nz-1
vx=reform(transpose(r.v[0,*,*,*]))
vy=reform(transpose(r.v[1,*,*,*]))
vz=reform(transpose(r.v[2,*,*,*]))

v2=sqrt(vx^2+vy^2+vz^2)
bx=reform(transpose(r.b[0,*,*,*]))
by=reform(transpose(r.b[1,*,*,*]))
bz=reform(transpose(r.b[2,*,*,*]))
b2=sqrt(bx^2+by^2+bz^2)
v2m=reform(v2[*,*,nz/2])
b2m=reform(b2[*,*,nz/2])
bxm=reform(bx[*,*,nz/2])

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
cgimage,cgscalevector(v2m,1,254),  pos=pos[*,0], title=string(arrnum[i]), /noerase, /keep_aspect
aspect=g.ny*1./(g.nx)
cgcontour, v2m,x,y, /noerase, /nodata, title="|B|" , pos=pos[*,0] , aspect=aspect, ytitle='Y'
cgimage,cgscalevector(b2m,1,254),  pos=pos[*,1], /noerase, /keep_aspect, title='B!U2!N'
cgcontour, v2m,x,y, /noerase, /nodata, title="|v|" , pos=pos[*,1] , aspect=aspect
cgimage,cgscalevector(bxm,1,254),  pos=pos[*,2], /noerase, /keep_aspect, title='B!DX!N'
cgcontour, v2m,x,y, /noerase, /nodata, title="B!DX!N" , pos=pos[*,2] , aspect=aspect
 gft1=mpfit2dpeak(ft1, aa1,/tilt, /moffat)
 gft1g=mpfit2dpeak(ft1, aa1g,/tilt, /gauss)
 gft1l=mpfit2dpeak(ft1, aa1l,/tilt, /lorentz)
 gft2=mpfit2dpeak(ft2, aa2,/tilt, /moffat)
 gft3=mpfit2dpeak(ft3, aa3,/tilt, /moffat)
cgimage, cgscalevector(lft1,1,254),   /noerase, pos=pos[*,3], /keep_aspect
kxx=findgen(ny)-ny/2
kyy=kxx
 cgcontour, alog10(gft1),kxx,kyy,  /noerase, pos=pos[*,3], aspect=1.0, label=0, xtitle='k!DX!N', ytitle='k!Dy!N', title='DFT(|B|)'
cgimage, cgscalevector(lft2,1,254),   /noerase, pos=pos[*,4], /keep_aspect
 cgcontour, alog10(gft2),kxx,kyy,  /noerase, pos=pos[*,4], aspect=1.0, label=0, xtitle='k!DX!N', title='DFT(|v|)'
cgimage, cgscalevector(lft3,1,254),   /noerase, pos=pos[*,5], /keep_aspect
 cgcontour, alog10(gft3),kxx,kyy,  /noerase, pos=pos[*,5], aspect=1.0, label=0, xtitle='k!DX!N', title='DFT(B!Dx!N)'
 ny2=ny/2
 ny1=ny-1
kx=findgen(ny2)
cgplot, kx, ft1[ny2:ny1,ny2],  /noerase, pos=pos[*,6], /xlog, /ylog, xrange=[1,ny/2], xtitle='k'
cgplot, kx,gft1[ny2:ny1,ny2], /overplot, pos=pos[*,6], color='red'
cgplot, kx,gft1g[ny2:ny1,ny2], /overplot, pos=pos[*,6], color='green'
cgplot, kx,gft1l[ny2:ny1,ny2], /overplot, pos=pos[*,6], color='blue'
al_legend, ['Moffat','Gauss','Lorentzian'], linestyle=[0,0,0],colors=['red','green','blue'], /right
cgplot, kx, ft2[ny2:ny1,ny2],  /noerase, pos=pos[*,7], /xlog, /ylog, xrange=[1,ny/2], xtitle='k'
cgplot, kx,gft2[ny2:ny1,ny2], /overplot, pos=pos[*,7]
cgplot, kx, ft3[ny2:ny1,ny2],  /noerase, pos=pos[*,8], /xlog, /ylog, xrange=[1,ny/2], xtitle='k'
cgplot, kx,gft3[ny2:ny1,ny2], /overplot, pos=pos[*,8]

xpos=.5
ypos=.95
cgtext, xpos,ypos, "t="+string(c.time/2/!DPI,format='(F4.1)')+' orbits', /normal

im=cgsnapshot(filename=fname, /jpeg, /nodialog)

endfor
mytime2=systime(1)

print, (mytime2-mytime1)/60.0 ,  ' minutes'

end
