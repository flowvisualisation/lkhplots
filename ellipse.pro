

nx=100
ny=nx

a=0.5
b=0.25



rho=fltarr(nx,ny)

rho[*,*]=0

for i=-nx/2,nx/2-1 do begin
for j=-ny/2,ny/2-1 do begin

th=atan((j*1.0d)/i)

t=  atan(  a/b*tan(th) )

x=a*cos(t)
y=b*sin(t)

r=a*b/sqrt( (b*cos(th))^2 + (a*sin(th))^2 )

print, r
x=i*.5/nx
y=j*0.5/ny
r=x^2+y^2+1e-6
rho[i+nx/2,j+ny/2]=sqrt(abs(x/a)^2+abs(y/b)^2)^(-3.5)
rho(nx/2,ny/2)=1
;rho(nx/2,*)=0.5*(rho(nx/2-1,*)+rho(nx/2+1,*))
;rho(*,ny/2)=0.5*

endfor
endfor

cgloadct,33
display, alog10(rho), ims=[800,800], /hbar



end
