

nfile=20
snoopyread, vx,vy, vz,bx,by,bz, xx3d,yy3d,zz3d,xx,yy,zz,nx,ny,nz,nfile, time


p1=0
p2=0
p3=0
a=randomn(seed,3, /double)
a= [ vx[p1,p2,p3] , vy[p1,p2,p3] , vz[p1,p2,p3]]

m1=a#a

b=randomn(seed,3, /double)
p3=1
b= [ vx[p1,p2,p3] , vy[p1,p2,p3] , vz[p1,p2,p3]]

m2=b#b


m3=m1+m2

print, determ(m3)


m4=m3/trace(m3) -1.d/3.d*identity(3)
print, determ(m4)


end

