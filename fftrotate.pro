



pro fftrotate, inarr, outarr, time

sz=size(inarr, /dimensions)
nx=sz[0]
ny=sz[1]

fftydir=dcomplexarr(nx,ny)
outarr=dcomplexarr(nx,ny)

;; do fft sweep in y direction
for i=0,nx-1 do begin
 fftydir(i,*)=fft(inarr(i,*))
endfor

;; rotate around shearing angle 2*!PI q omega/ Ly

;; shearing box q
	q=1.5d
;; shearing box omega
	omega=1e-3
	Ly=1.0d
	t=time

xvec=dindgen(nx)/nx-0.5
x=rebin(reform(xvec, nx, 1 ), nx,ny)

	a=findgen(nx/2)
	b=-reverse(findgen(nx/2))-1
	littlen1d=[a,b]
littlen=rebin(reform(littlen1d, nx, 1 ), nx,ny)
	theta=-q*omega*t*2*!PI*ny*x/Ly

	costheta=cos(theta)
	sintheta=sin(theta)
	print, q*omega*t*2*!PI*ny/Ly
	phaseshift= complex( costheta,sintheta )
	rotarr=fftydir  *phaseshift

display, rotarr, ims=10
;; do fft sweep in x direction
for j=0,ny-1 do begin
 outarr(*,j)=fft(rotarr(*,j))
endfor

outarr=rotarr
end
