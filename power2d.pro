nx1=100
nx2=nx1
k1=findgen(nx1)-nx1/2
k2=findgen(nx2)-nx2/2


kx=k1
ky=k2

kx2d=rebin(reform (kx,nx1,1),nx1,nx2)
ky2d=rebin(reform (ky,1,nx2),nx1,nx2)


kr=sqrt(kx2d^2+ky2d^2)


dist2=(kr^(-5./3.))
dist2[nx1/2-2:nx1/2+2,nx2/2-2:nx2/2+2 ]=1

dist3=alog10(dist2)
cgloadct,33
display, ims=[800,800], dist3, /hbar

end
