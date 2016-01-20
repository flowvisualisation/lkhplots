
cgloadct,33
nx=300L
ny=nx
x1=dindgen(nx)/nx-0.5d
x2=dindgen(ny)/ny-0.5d
x1=x1*4
x2=x2*4
x=rebin(reform(x1,nx,1),nx,ny)
y=rebin(reform(x2,1,ny),nx,ny)
th=atan(x,y)
th=35*!DTOR
xrot=x*cos(th)-y*sin(th)
yrot=x*sin(th)+y*cos(th)
xrot=xrot*1.5
r=sqrt(x^2+y^2)
r=sqrt(xrot^2+yrot^2)

gam=.1
noise1=randomu(0,nx*ny)-0.5
noise=reform(noise1, nx,ny)*1e-2
lor= gam/(xrot^2+yrot^2 + gam^2)+noise
kx=findgen(nx)-nx/2
ky=findgen(ny)-ny/2
display, ims=[800,800],x1=kx,x2=ky, alog10(lor)
end
