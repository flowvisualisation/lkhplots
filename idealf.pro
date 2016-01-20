
function idealf, nx,ny, theta
a=gaussian2d( nx,ny, theta)

b=a
b(*,*)=0
for i=0,nx-1 do begin
for j=0,ny-1 do begin
if ( a[i,j] gt .95) then begin
b[i,j]=1
endif
endfor
endfor

return, b
end
