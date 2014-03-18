nbeg=16
nend=nbeg
for nfile=nbeg,nend do begin


snoopyread, vx,vy, vz,bx,by,bz, xx3d,yy3d,zz3d,xx,yy,zz,nx,ny,nz,nfile, time


a=vx^2+vy^2+vz^2
b=bx^2+by^2+bz^2

vfft=(abs(fft(vx,/center)))


axobj=1
;r=volume(vfft , rgb_table0=33, title='FFT(v)',axes=axobj,xtitle='kx', ytitle='ky', ztitle='kz')

vfft=vfft[nx/3:2*nx/3,ny/3:2*ny/3,nz/3:2*nz/3]



r=VOLUME(vfft, RENDER_EXTENTS=0, $
   HINTS = 3, $
   /AUTO_RENDER, $
   RGB_TABLE0=33, $
   AXIS_STYLE=3, $
   RENDER_QUALITY=2, $
   BACKGROUND_COLOR='gray', $
   DEPTH_CUE=[0, 2], $
   ;/PERSPECTIVE, $
   volume_dimensions=[256,256,128]*0.5,$
   volume_location=[-128,-128,-64]*0.5,$
   title='FFT(v)',$
   xtitle='kx', $
   ytitle='ky', $
   ztitle='kz'$
   )



endfor

end

