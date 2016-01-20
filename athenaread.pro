

COMMON SHARE1,nx,ny,nz,nvar,nscalars
COMMON SHARE2,x,y,z
COMMON SHARE3,time,dt,gamm1,isocs
COMMON SHARE4,d,e,p,vx,vy,vz,bx,by,bz,s,phi
tag="HKDisk."
numstr=string(num, format='(I04)')
filename=tag+numstr+'.vtk'
readvtk,filename,pfact
end
