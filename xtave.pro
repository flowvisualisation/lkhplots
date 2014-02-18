
nfile=0
snoopyread, vx,vy, vz,bx,by,bz, xx3d,yy3d,zz3d,xx,yy,zz,nx,ny,nz,nfile

nend=370
nend=370
xt=fltarr(nend,nx,6)
yt=fltarr(nend,ny,6)
zt=fltarr(nend,nz,6)
for nfile=0,nend-1 do begin
snoopyread, vx,vy, vz,bx,by,bz, xx3d,yy3d,zz3d,xx,yy,zz,nx,ny,nz,nfile

xt[nfile,*,0]=xave(vx,2,2)
xt[nfile,*,1]=xave(vy,2,2)
xt[nfile,*,2]=xave(vz,2,2)
xt[nfile,*,3]=xave(bx,2,2)
xt[nfile,*,4]=xave(by,2,2)
xt[nfile,*,5]=xave(bz,2,2)


yt[nfile,*,0]=xave(vx,1,2)
yt[nfile,*,1]=xave(vy,1,2)
yt[nfile,*,2]=xave(vz,1,2)
yt[nfile,*,3]=xave(bx,1,2)
yt[nfile,*,4]=xave(by,1,2)
yt[nfile,*,5]=xave(bz,1,2)


zt[nfile,*,0]=xave(vx,1,1)
zt[nfile,*,1]=xave(vy,1,1)
zt[nfile,*,2]=xave(vz,1,1)
zt[nfile,*,3]=xave(bx,1,1)
zt[nfile,*,4]=xave(by,1,1)
zt[nfile,*,5]=xave(bz,1,1)

endfor

end

