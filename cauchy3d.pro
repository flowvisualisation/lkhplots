nx=400
ny=nx
nz=nx

xphw=3
yphw=1
zphw=1

kx=(findgen(nx)-nx/2)
ky=kx
kz=kx

cau= 1/(1+kx)^2

cgloadct,33
;cgplot, kx, cau, /ylog, /xlog, xrange=[1,nx-1]
kx2d=rebin(reform(kx,nx,1),nx,ny)
ky2d=rebin(reform(ky,1,ny),nx,ny)
kr2d=sqrt((kx2d/xphw)^2+ky2d^2)
cau2d=1/(1+kr2d)^2
display, alog10(cau2d),x1=kx,x2=ky



end

