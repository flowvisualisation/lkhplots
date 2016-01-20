pro my2ddipole,den, b1,b2,b3,x1d,y1d,z1d,nx,ny,nz
mx=reform(b1(*,ny/2,*))
mz=reform(b3(*,ny/2,*))
rho=den(*,ny/2,*)

mx=reform(b2(nx/2,*,*))
mz=reform(b3(nx/2,*,*))

rho=reform(den(nx/2,*,*))
for j=0,ny-1 do begin
for k=0,nz-1 do begin
rs=sqrt(y1d[j]^2 +z1d[k]^2)
 if ( rs le .35) then begin
 rho[j,k]=1e-3
 mx[j,k]=0
 mz[j,k]=0
 endif
endfor
endfor

cx=4.24
cgloadct,33
display, /hbar, ims=[800,800], x1=x1d, x2=z1d, alog10(rho+1e-3), $
    xrange=[-cx,cx], yrange=[-cx,cx]


for i=0.9, 3.2,0.3 do begin
field_line_old, mx, mz, x1d,z1d,  i,0.1, rr,zz ;, /quiet
cgplot, rr,zz,color='white', /overplot, thick=2
field_line_old, mx, mz, x1d,z1d,  -i,0.1, rr,zz ;, /quiet
cgplot, rr,zz,color='white', /overplot, thick=2
endfor
end
