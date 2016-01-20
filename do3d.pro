
 nfile=6                                                                          
  snoopyread, vx,vy, vz,bx,by,bz, xx3d,yy3d,zz3d,xx,yy,zz,nx,ny,nz,nfile, time
 a=cgscalevector(vz,1,255)
 b=congrid(a,64,64,32)
 xvolume, b

end
