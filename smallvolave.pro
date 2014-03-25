nx=10
ny=10
nz=10

b=fltarr(nx,ny,nz)




ray=0

for i=0,nx-1,2  do begin
for j=0,ny-1,2  do begin
for k=0,nz-1,2  do begin

for ii=i,i+1 do begin
for jj=j,j+1 do begin
for kk=k,k+1 do begin

ray=ray+b(ii,jj,kk)

endfor
endfor
endfor


endfor
endfor
endfor

end
