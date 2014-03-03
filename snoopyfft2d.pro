   cgDisplay, WID=1,xs=1800, ys=700, xpos=100, ypos=700
; load some sheared data

nfile=2
nend=300
for nfile=0,nend do begin
snoopyread, vx,vy, vz,bx,by,bz, xx3d,yy3d,zz3d,xx,yy,zz,nx,ny,nz,nfile, time

final=reform(vz(*,4,*))

dataptr=ptrarr(18)

dataptr[ 0]=ptr_new(final)
dataptr[ 1]=ptr_new(alog10(abs(fft(final, /center))))
dataptr[ 2]=ptr_new(vfft)
dataptr[ 3]=ptr_new(pf1)
dataptr[ 4]=ptr_new(pf2)
dataptr[ 5]=ptr_new(ky2d)
dataptr[ 6]=ptr_new(xx2d)
dataptr[ 7]=ptr_new(final)
dataptr[ 8]=ptr_new(rcfft2)
dataptr[ 9]=ptr_new(rcfft2)
dataptr[10]=ptr_new(rcfft2)
dataptr[11]=ptr_new(final)
dataptr[12]=ptr_new(final)
dataptr[13]=ptr_new(final)
dataptr[14]=ptr_new(final)
dataptr[15]=ptr_new(final)

pos=[0.2,0.1,0.9,0.9]

titlestr=strarr(18,30)
titlestr[ 0,*]='vz'
titlestr[ 1,*]='DFT(vz)'
titlestr[ 2,*]='fft(vz)'
titlestr[ 3,*]='fft dimension 1'
titlestr[ 4,*]='fft dimension 2'
titlestr[ 5,*]='ky2d'
titlestr[ 6,*]='xx2d'
titlestr[ 7,*]='bz'
titlestr[ 8,*]='bz'
titlestr[ 9,*]='bz'
titlestr[10,*]='bz'
titlestr[10,*]='bz'
titlestr[10,*]='bz'
titlestr[10,*]='bz'
titlestr[10,*]='bz'
titlestr[10,*]='bz(z,t)'


  
fname="fft2d"+string(nfile, format='(I03)')
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet
endif else  begin
set_plot, 'x'
endelse





   cgLoadCT, 33
   pos = cglayout([2,1] , OXMargin=[4,12], OYMargin=[5,4], XGap=12, YGap=2)
   FOR j=0,1 DO BEGIN
     p = pos[*,j]
     d= *dataptr(j)
	r=cgscalevector(d, 1,254)
	imin=min(*dataptr[j])
	imax=max(*dataptr[j])
     cgImage, r, NoErase=j NE 0, Position=p
  cgcontour,xx#yy, xx,yy , /nodata, /noerase, xtitle='x', pos=p, title=titlestr(j), Charsize=cgDefCharsize()*0.5
  ;   cgColorBar, position=[p[2]+0.06, p[1], p[2]+0.07, p[3]],range=[imin-1e-6,imax+1e-6], Charsize=cgDefCharsize()*0.5 , /vertical
   ENDFOR
   cgText, 0.5, 0.9, /Normal,  'vz and DFT(vz), t='+string(time), Alignment=0.5, Charsize=cgDefCharsize()*1.25


if ( usingps ) then begin
;device,/close
cgps_close, /jpeg,  Width=2048
;set_plot,'x'
endif else begin
;set_plot,'x'
fname2=fname
;im=cgsnapshot(filename=fname2,/nodialog,/jpeg)
endelse

endfor


endfor



end
