
nx=100
ny=100
kpar=findgen(nx,ny)
kperp=findgen(nx,ny)


kpar1 =findgen(nx)/(nx-1)-0.5
kperp1=findgen(ny)/(ny-1)-0.5




kpar1=kpar1*1000
kperp1=kperp1*1000

kpar1=kpar1
kperp1=kperp1

kpar =rebin(reform( kpar1,nx,1),nx,ny)
kperp=rebin(reform(kperp1,1,ny),ny,ny)
kr=sqrt(kpar^2+kperp^2)

ek=kr*(abs(kpar)^2)^(-8./3.)*(abs(kperp)^2)^(-7./2.)

display,$
    alog10( ek) , $
    x1=kpar1,$
    x2=kperp1,$
    /hbar,$
     ims=[800,800]


end
