
qsm=7
cgdisplay, xs=700,ys=1200
cgloadct,33
for nfile=12,650,2 do begin

sload,nfile

fftarg=vx^2+vy^2+vz^2 
fftarg=bx^2+by^2+bz^2 

fftarg=fftarg-mean(fftarg)
;a=fft( fftarg, /center)

q=1.5d
omega=1.0
S=q*omega
Ly=2.0
dt=time mod  0.666666666666666666666666666666666666d
qomegat_Ly=q*omega*dt/Ly

ky=[findgen(ny/2), -ny/2+findgen(ny/2)]
ky3d=rebin(reform(ky,1,ny,1),nx,ny,nz)


cfft1=fft(fftarg,dimension=2)
jimag=complex(0,1)
cfft1shift=cfft1*exp ( -jimag * ky3d * xx3d *2 *!PI *qomegat_Ly ) 
cfft2=fft(cfft1shift, dimension=1 )
cfft3=fft(cfft2, dimension=3 )

a=shift(cfft3,nx/2,ny/2,nz/2)
myfft=abs(a(*,*,nz/2))^2

smoothmyfft=smooth(myfft,qsm, /edge_wrap)
logfft=alog10(myfft)
smoothlog=smooth(logfft,qsm, /edge_wrap)
k1=findgen(nx)-nx/2
k2=findgen(ny)-ny/2

;display, smoothlog,x1=k1,x2=k2, ims=4, xrange=[-60,60], yrange=[-60,60]


print, 't=' ,time
fname="myfft_smooth"+string(nfile, format='(I04)')
for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet
endif else  begin
set_plot, 'x'
endelse



pos = cglayout([1,2] , OXMargin=[9,9], OYMargin=[5,6], XGap=9, YGap=6)
r=cgscalevector(smoothlog,1,254)
cgimage, r, pos=pos[*,0]
cgcontour, r,k1,k2, $
   ; /nodata, $
    /noerase, pos=pos[*,0], xtitle='k!Dx!N', ytitle='k!Dy!N', title='time='+string(time)

kx=findgen(nx/2)

cut45=findgen(nx/2)
cut315 =findgen(nx/2)
for q=0,nx/2-2 do begin
cut45[q]= smoothmyfft(nx/2+q+1,ny/2+q )
cut315[q]= smoothmyfft(nx/2+q+1,ny/2-q )
endfor

powlaw=2.5
powlaw=0.

cgplot, kx,kx^(powlaw)*cut45,pos=pos[*,1], /noerase, /xlog, xrange=[9e-1,125], /ylog, xtitle='k', ytitle= '|DFT(vx!U2!N+vy!U2!N+vz!U2!N)|^2'
cgplot, kx,kx^(powlaw)*cut315,/overplot
;cgplot, kx,cut45(0)*kx^(-5./2.) ,  /overplot
;cgplot, kx,cut45(0)*kx^(-5./3.) ,  /overplot


wait, 1



if ( usingps ) then begin
cgps_close, /jpeg,  Width=2048, /nomessage
endif else begin
fname2=fname
;im=cgsnapshot(filename=fname2,/nodialog,/jpeg)
endelse


endfor

endfor

end
