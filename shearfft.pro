

nbeg=0
nend=0

for nfile=nbeg,nend do begin

pload,nfile


vx=vx1
vy=vx2
vz=vx3

nx=nx1
ny=nx2
nz=nx3

xx=rebin(reform(x1,nx, 1, 1 ) ,nx,ny,nz)
yy=rebin(reform(x2, 1,ny, 1 ) ,nx,ny,nz)
zz=rebin(reform(x3, 1, 1,nz ) ,nx,ny,nz)



vec1=vx


fft_xdir=complexarr(nx,ny,nz)

for j=1,nz-1 do begin

fft_xdir(*,j,*) = fft( reform(vec1(*,j,*)))
endfor
	
endfor







end
