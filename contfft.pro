nbeg=16
nend=nbeg
for nfile=nbeg,nend do begin


snoopyread, vx,vy, vz,bx,by,bz, xx3d,yy3d,zz3d,xx,yy,zz,nx,ny,nz,nfile, time


a=vx^2+vy^2+vz^2
b=bx^2+by^2+bz^2

vfft=(abs(fft(vx,/center)))


axobj=1

vfft=vfft[nx/3:2*nx/3,ny/3:2*ny/3,nz/3:2*nz/3]

SHADE_VOLUME, vfft, 0.01, v, p, /LOW
; Obtain the dimensions of the volume.
; Variables S[1], S[2], and S[3] now contain
; the number of columns, rows, and slices in the volume:
s = SIZE(vfft)
; Use SCALE3 to establish the three-dimensional
; transformation matrix. Rotate 45 degrees about the z-axis:
SCALE3, XRANGE=[0,S[1]], YRANGE=[0,S[2]], $
   ZRANGE=[0,S[3]], AX=0, AZ=45
; Render and display the polygons:
cgloadct,33
cgimage, POLYSHADE(v, p, /T3D)




endfor

end

