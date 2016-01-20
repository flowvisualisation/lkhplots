nx=300
ny=nx

x=findgen(nx)/nx*10
y=findgen(ny)/ny*10-5

x2d=rebin(reform(x,nx,1),nx,ny)
y2d=rebin(reform(y,1,ny),nx,ny)

Rsph=sqrt(x2d^2+y2d^2)
Rsph[0:2,ny/2-1:ny/2+1]=1
th=atan(y2d,x2d)
th[0:2,ny/2-1:ny/2+1]=1

az=sin(th)/Rsph^2

bstar=1.0
rstar=2.0

fl=bstar*rstar^3*sin(th)^2/Rsph
br=1/Rsph^3*2*cos(th)*bstar*rstar^3
bth=-1/Rsph^3*sin(th)*bstar*rstar^3
b1=2*cos(th)/Rsph^3
b2=-1*sin(th)/Rsph^3
b1=br
b2=bth



b1[0:2,ny/2-1:ny/2+1]=1e-3
b2[0:2,ny/2-1:ny/2+1]=1e-3
display, alog10(b1^2+b2^2+1e-6), $
    x1=x,x2=y,$
    ims=[800,800]
vecfield, b1,b2,x,y , /overplot

for i=0.1, 9.2,0.3 do begin
field_line_old, b1, b2, x,y,  i,0.1, rr,zz ;, /quiet
oplot, rr,zz,color=255
endfor


end
