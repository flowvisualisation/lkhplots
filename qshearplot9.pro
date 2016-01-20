
xs=900
ys=xs
cgdisplay, xs=xs, ys=ys


if ( firstcall eq !NULL ) then begin 
datarr=ptrarr(9)
x1arr=ptrarr(9)
x2arr=ptrarr(9)

dirnum=1
for dirnum=1,9 do begin
nfile=44
dir='q1_'+string(dirnum,format='(I1)')+'/data/'
snoopyreaddir, vx,vy, vz,bx,by,bz, xx3d,yy3d,zz3d,xx,yy,zz,nx,ny,nz,nfile, time, dir

var=reform(by(*,*,nz/2))

vec=var
nx1=nx
nx2=ny
ffttot=complexarr(nx1,nx2)
q=1.+0.1*dirnum
omega=1.0
S=q*omega
mytime=time mod (1./q)
dt=mytime
print, 'time=',time,',  q=',q, ', dt=', dt
Ly=2.0
qomegat_Ly=q*omega*dt/Ly
x2d=rebin(xx,nx,ny)

x1=xx
 shearfft2d, vec, ffttot, qomegat_Ly,x2d, nx1,nx2, x1

var=alog10(abs(shift(ffttot,nx/2,ny/2)))
var=var(nx/6:nx-nx/6,ny/6:ny-ny/6)
;var=by(*,*,nz/2)
datarr[dirnum-1]=ptr_new(var) 
kx=findgen(nx)-nx/2
ky=findgen(ny)-ny/2
kx=kx(nx/6:nx-nx/6)
ky=ky(ny/6:ny-ny/6)
x1arr[dirnum-1]=ptr_new(kx) 
x2arr[dirnum-1]=ptr_new(ky) 
endfor

firstcall=1
endif


pos=cglayout([3,3], OXMargin=[4,1], OYMargin=[9,6], XGap=4, YGap=9 )

cgloadct,33
for i=0,8 do begin
d=*datarr[i]
r=cgscalevector(d,1,254)
x1=*x1arr[i]
x2=*x2arr[i]
cgimage, r, pos=pos[*,i], /noerase
print, i
help,r 
cgcontour, r,x1,x2,  /nodata, $
    pos=pos[*,i],   $
    /noerase, $
    title='q=1.'+string(i+1, format='(I1)')
endfor

end
