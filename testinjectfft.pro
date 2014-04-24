
; make array
nx=128
ny=8
nz=64

a=fltarr(nx,ny,nz)


x=findgen(nx)/nx*2-1
z=findgen(nz)/nz*2-1


x3d=rebin(reform(x,nx,1,1),nx,ny,nz)
z3d=rebin(reform(z,1,1,nz),nx,ny,nz)


vz=sin(!PI*x3d)
 display, vz(*,3,*)



fftvz=fft(vz)

fftvz_trunc=fftvz[*,*,0:nz/2+1]

;b=b(*,0:4,*)
d=transpose(fftvz_trunc)
d=transpose(fftvz)
print, where(fftvz_trunc gt 0.4)
print, where(d gt 0.4)



help,b



b=fltarr(nx,ny,nz)
 aa=fft(b)          
 aa[2]=1.           
 b=fft(aa,-1)       
 ;display, b(*,2,*) 

end
