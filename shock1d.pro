
spawn, 'ls Data/field*.dat',a
sz=size(a, /dimensions)
b=a(sz-1)
c=strmid(b,12,6)
d=long(c)
nend=d(0)
print,nend
nbeg=nend-10
nbeg=0
if ( (nend-5) gt 0) then begin
nbeg =nend-5
endif


nfile=0

cgdisplay, xs=1300,ys=1300
pos=cglayout([1,8] , OXMargin=[8,1], OYMargin=[6,3], XGap=1, YGap=3)

for nfile=nbeg,nend do begin
p=rp(nfile)
f=rf(nfile)
den=reform(f.d(*,0,*,0))
di=reform(f.d(*,0,*,1))
bx=reform(f.bx(*,0,*))
by=reform(f.by(*,0,*))
bz=reform(f.bz(*,0,*))
b2=bx^2+by^2+bz^2
ex=reform(f.ex(*,0,*))
ey=reform(f.ey(*,0,*))
ez=reform(f.ez(*,0,*))
e2=ex^2+ey^2+ez^2

vx=reform( f.v(*,0,*,0,0))
vy=reform( f.v(*,0,*,1,0))
vz=reform( f.v(*,0,*,2,0))
di=reform(alog10( abs(f.d(*,0,*,0))))

nx=f.s.gn(0)
ny=f.s.gn(1)
nz=f.s.gn(2)
dx=f.s.ds(0)
dy=f.s.ds(1)
dz=f.s.ds(2)
x=findgen(nx)*dx
y=findgen(ny)*dy
z=findgen(nz)*dz
fname='shock'+string(nfile, format='(I06)')

xbi=nz/4
xei=3*nz/4
xbi=3*nz/4
xbi=0*nz/4
xei=nz-1
xbeg=z[xbi]
xend=z[xei]
cgloadct,0

 cgplot, p.r(*,2,0), p.p(*,2,0), psym=3, pos=pos[*,0], title=string(nfile), xrange=[xbeg,xend], ytitle='v!Dx,e!N'
 cgplot, p.r(*,2,1), p.p(*,2,1), psym=3, pos=pos[*,1], /noerase, xrange=[xbeg,xend], ytitle='v!Dx,ion!N', ticklen=0


cgplot,z, bx[0,*], pos=pos[*,2], /noerase, xrange=[xbeg,xend],  ytitle='b!Dx!N'
cgplot,z, by[0,*], pos=pos[*,3], /noerase, xrange=[xbeg,xend],  ytitle='b!Dy!N'
cgplot,z, bz[0,*], pos=pos[*,4], /noerase, xrange=[xbeg,xend],  ytitle='b!Dz!N'
cgplot,z, den[0,*], pos=pos[*,5], /noerase, xrange=[xbeg,xend],  ytitle='d!Di!N'
cgplot,z, di[0,*], pos=pos[*,6], /noerase, xrange=[xbeg,xend],  ytitle='d!De!N'
cgplot,z, ez[0,*], pos=pos[*,7], /noerase, xrange=[xbeg,xend],  ytitle='e!Dz!N'

;cgtext, 0,0, "3200",  Charsize=cgDefCharsize()*0.6
ttag="cells 3200, ld=2"
cgtext, 0.05,0.01, ttag, color='black', Charsize=cgDefCharsize()*1.9, /normal
print, fname
im=cgsnapshot(filename=fname, /jpeg, /nodialog)
endfor
!p.position=0
end
