pro shearfft2d, vec, ffttot, time,x2d, nx1,nx2, x1
ffttemp=complexarr(nx1,nx2)
fftrot=complexarr(nx1,nx2)
    

 
 ;;;

 ;;;  y|_ x in the radial 

 ;; in the radial r, or x direction, x things are shifted.
 ;; in the theta y or theta direction, it is strictly periodic


; everything is already periodic in the y direction
for i=0,nx1-1 do begin
ffttemp(i,*) = fft( reform(vec(i,*)) )
endfor

jimag=complex(0,1)


ky=[findgen(nx2/2), -nx2/2+findgen(nx2/2)]




; do a mixed ky and x direction phase shift.
for i=0,nx1-1 do begin
fftrot(i,*) = ffttemp(i,*) * exp ( -jimag * ky * x1[i] *2 *!PI *time ) 

debug=0
if ( debug eq 1 ) then begin

if ( i eq nx1-2) then begin
!p.position=0
!p.multi=[0,1,6]
window, xs=900, ys=900
print, abs(exp(jimag*time*x1[i]*ky))
cgplot, vec(i,*)
cgplot, abs(ffttemp(i,*))
cgplot,  time*ky*x1[i]
cgplot,  time*ky*x1[i/2], /overplot
cgplot, abs(fft( ffttemp(i,*), /inverse)), linestyle=1
cgplot, abs(fft( fftrot(i,*), /inverse)), /overplot, linestyle=2
cgplot, abs(fft( ffttemp(nx1/2,*), /inverse)), linestyle=1
cgplot, abs(fft( fftrot(nx1/2,*), /inverse)), /overplot, linestyle=2
cgplot, abs(fft( ffttemp(0,*), /inverse)), linestyle=1
cgplot, abs(fft( fftrot(0,*), /inverse)), /overplot, linestyle=2
!p.multi=0
;display, ky2d
stop
endif
endif ; debug

endfor

;; 
for j=0,nx2-1 do begin
ffttot(*,j) = fft( reform(fftrot(*,j)))
endfor

end
