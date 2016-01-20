
cgdisplay, xs=1900,ys=700
pos=cglayout([4,1])
for nfile=0,200 do begin

p=rp(nfile)
f=rf(nfile)


ex=f.ex[5,0,*]
ey=f.ey[5,0,*]
ez=f.ez[5,0,*]

bx=f.bx[5,0,*]
by=f.by[5,0,*]
bz=f.bz[5,0,*]

b2=bx^2+by^2+bz^2
e2=ex^2+ey^2+ez^2

sz=size(ex, /dimensions)
z=findgen(sz(2))/sz(2)*f.s.gn[2]*f.s.ds[2]
zmin=z[0]
zmax=z[sz(2)-1]

x=p.r(*,2,0)
v=p.p(*,2,0)
cgplot, x,v, psym=2, pos=pos[*,0], xrange=[zmin,zmax]
x=p.r(*,2,1)
v=p.p(*,2,1)
cgplot, x,v, psym=2, pos=pos[*,1], /noerase, xrange=[zmin,zmax]

cgplot, z, e2, pos=pos[*,2], /noerase, xrange=[zmin,zmax]
cgplot, z, b2, pos=pos[*,3], /noerase, xrange=[zmin,zmax]
wait,1

endfor


end
