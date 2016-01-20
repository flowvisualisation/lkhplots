;   .r ../vis/idl/pltath
pro athpol, n
COMMON SHARE1,nx,ny,nz,nvar,nscalars
COMMON SHARE2,x,y,z
COMMON SHARE3,time,dt,gamm1,isocs
COMMON SHARE4,d,e,p,vx,vy,vz,bx,by,bz,s,phi


readvtk, 'CylNewtZ8.'+string(n, format='(I04)')+'.vtk', pfact
print, nx, ny,nz
 xx=findgen(nx)/nx*2+1 & yy=findgen(ny)/ny*!DPI*2.-!DPI  &   zz=findgen(ny)/ny*2-1 & dd=d[*,*,nz/2]
 x1=xx & x2=yy & x3=zz

 ;polar, dd, xx,yy, sample=3 

cgloadct,33
 display,ims=[800,800] , x1=x1,x2=x2, /polar, /hbar, d[*,*,16]
 end
