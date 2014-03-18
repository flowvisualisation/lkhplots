
cgdisplay, xs=1600, ys=800
nfile=16
for nfile=2,18,2 do begin
snoopyread, vx,vy, vz,bx,by,bz, xx3d,yy3d,zz3d,xx,yy,zz,nx,ny,nz,nfile, time


a=vx^2+vy^2+vz^2
b=bx^2+by^2+bz^2

vfft=(abs(fft(vx,/center)))


qx1=nx/2-20
qx2=nx/2+20
qy1=ny/2-20
qy2=ny/2+20
qz1=nz/2-10
qz2=nz/2+10
vfft=vfft[qx1:qx2,qy1:qy2,qz1:qz2]
cgloadct,0, /reverse


sz=size(vfft, /dimensions)
n1=sz[0]-1
n2=sz[1]-1
n3=sz[2]-1

data=vfft

      surf=fltarr(2)
  surf[0]=0.1*max(vfft)
  surf[1]=0.01*max(vfft)


fname="fft_comparison"+string(nfile, format='(I03)')
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet
endif else  begin
set_plot, 'x'
endelse



!p.charsize=2
!p.multi=[0,2,1]
;!p.multi=0
for qq=0,1 do begin
SURFACE, Dist(10,10), XRANGE=[0,n1] ,YRANGE=[0,n2], $
      ZRANGE=[0,n3], /SAVE, /NODATA, XSTYLE=5, YSTYLE=5, $
      ZSTYLE=5
   
      ; Obtain the isosurface.

   SHADE_VOLUME, data, surf[qq], vertices, polygons, /LOW
   
      ; Display the isosurface in the 3D space.
   
      cgloadct,33
      tvlct,255,255,255,0
      im=POLYSHADE(vertices, polygons, /T3d, xsize=1000, ysize=500)
      ;help, im
      sz=size(im, /dimensions)
      q1=fltarr(2)
      q2=fltarr(2)
      q1[0]=0
      q2[0]=499
      q1[1]=500
      q2[1]=999
   cgimage, im[q1[qq]:q2[qq],*], /overplot
   ;cgloadct,0,/reverse

      ; Redraw the axes.
   
   cgloadct,0
   SURFACE, Dist(10,10), XRANGE=[-n1/2,n1/2], YRANGE=[-n2/2,n2/2], $
      ZRANGE=[-n3/2,n3/2], /SAVE, /NODATA, XSTYLE=1, YSTYLE=1, $
      ZSTYLE=1, XTITLE='kx', YTITLE='ky', $
      ZTITLE='kx', $
     ; title='surf='+string(surf[qq]), $
      /NOERASE

cgText, -10.1, 20.56,   'surf='+string(surf[qq]),  Charsize=cgDefCharsize()*1.25, color='black'



      endfor

cgText, 0.5, 0.96, /Normal,  '3D FFT of v, t='+string(nfile), Alignment=0.5, Charsize=cgDefCharsize()*1.25, color='black'



if ( usingps ) then begin
;device,/close
cgps_close, /jpeg,  Width=1100
;set_plot,'x'
endif else begin
;set_plot,'x'
fname2=fname
;im=cgsnapshot(filename=fname2,/nodialog,/jpeg)
endelse

endfor



endfor


      end
