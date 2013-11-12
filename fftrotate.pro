



pro fftrotate, inarr, outarr, time

sz=size(inarr, /dimensions)
nx=sz[0]
ny=sz[1]

;; do fft sweep in y direction
fftydir=dcomplexarr(nx,ny)
outarr=dcomplexarr(nx,ny)

for i=0,nx-1 do begin
 fftydir(i,*)=fft(inarr(i,*))
endfor




;; rotate around shearing angle 2*!PI q omega/ Ly

;; shearing box q
	q=1.5
;; shearing box omega
	omega=1e-3
	Ly=1.0
	t=time


xvec=findgen(nx)
x=rebin(reform(xvec, nx, 1 ), nx,ny)



	theta=-q*omega*t*2*!PI*ny*x/Ly

	costheta=cos(theta)
	sintheta=sin(theta)
	rotarr=fftydir*complex( costheta,sintheta )

;; do fft sweep in x direction
for j=0,ny-1 do begin
 outarr(*,j)=fft(rotarr(*,j))
endfor




end
