

nx=100
ny=100
arr=fltarr(nx,ny)


x1=findgen(nx)
x2=findgen(ny)

cx=x1(nx-1)/2
cy=x2(ny-1)/2

for i=0,nx-1 do begin
for j=0,ny-1 do begin

r1=x1(i)-cx
r2=x2(j)-cy
arr(i,j)=100- sqrt( r1^2+r2^2)

endfor
endfor


cgloadct,33
display, arr, ims=10


rad=findgen(nx)
power=findgen(nx)


for i=0,nx-1 do begin
for j=0,ny-1 do begin

; compute rad

r1=x1(i)-cx
r2=x2(j)-cy
rad=sqrt(r1^2+r2^2)

radint=fix(rad)
val=arr[i,j]
print, i,j,radint
power[rad]  += val/rad;/2/!DPI



endfor
endfor

radius=findgen(nx)
cgplot,radius,  (smooth(power,5)/2/!DPI)^2
cgplot, radius,arr[50,50:99]^2, /overplot

end
