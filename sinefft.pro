

nx=128
ny=128
nz=64

x=findgen(nx)/nx*2-1
y=findgen(ny)/ny*2-1
z=findgen(nz)/nz*2-1

x3d=rebin(reform(x,nx,1,1),nx,ny,nz)
y3d=rebin(reform(y,1,ny,1),nx,ny,nz)
z3d=rebin(reform(z,1,1,nz),nx,ny,nz)



vz=sin((x3d+y3d)*!DPI)

fftvz=fft(vz)

afftvz=abs(fftvz)

print, where( afftvz eq max(afftvz))



end
