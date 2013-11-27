
!p.charsize=2
!p.position=0
nx = f.s.gn[0]
nz = f.s.gn[2]
slice= f.s.gn[1]/2

bx=reform(f.bx[*,slice,*],nx,nz)
by=reform(f.by[*,slice,*],nx,nz)
bz=reform(f.bz[*,slice,*],nx,nz)
ex=reform(f.ex[*,slice,*],nx,nz)
ey=reform(f.ey[*,slice,*],nx,nz)
ez=reform(f.ez[*,slice,*],nx,nz)
vix=reform(f.v[*,slice,*,0,1],nx,nz)
viy=reform(f.v[*,slice,*,1,1],nx,nz)
viz=reform(f.v[*,slice,*,2,1],nx,nz)
vex=reform(f.v[*,slice,*,0,0],nx,nz)
vey=reform(f.v[*,slice,*,1,0],nx,nz)
vez=reform(f.v[*,slice,*,2,0],nx,nz)


loadct,0
window, xs=1100,ys=1200
!p.multi=[0,3,4]
!x.style=1
!y.style=1
loadct,33
tvlct, 0,0,0,0
tvlct, 255,255,255,1

!p.background=1

xx=findgen(nx)
yy=findgen(nz)


dataptr=ptrarr(12)

dataptr(0)=ptr_new(ex)
dataptr(1)=ptr_new(ey)
dataptr(2)=ptr_new(ez)
dataptr(3)=ptr_new(bx)
dataptr(4)=ptr_new(by)
dataptr(5)=ptr_new(bz)
dataptr(6)=ptr_new(vix)
dataptr(7)=ptr_new(viy)
dataptr(8)=ptr_new(viz)
dataptr(9)=ptr_new(vex)
dataptr(10)=ptr_new(vey)
dataptr(11)=ptr_new(vez)


pos=[0.1,0.1,0.9,0.9]

for i=0,11 do begin
r=*dataptr(i)
cgimage, r, multimargin=0.25
endfor

end

