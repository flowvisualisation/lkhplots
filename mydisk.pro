
nx=13
ny=nx
x=findgen(nx)-nx/2
y=findgen(ny)-ny/2

x2d=rebin(reform(x,nx,1),nx,ny)
y2d=rebin(reform(y,1,ny),nx,ny)

th=atan(y2d,x2d)

velovect, -sin(th),cos(th)

end

