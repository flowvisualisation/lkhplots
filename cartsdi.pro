
x=rebin(reform(x1,nx1,1,1),nx1,nx2,nx3)
y=rebin(reform(x2,1,nx2,1),nx1,nx2,nx3)
z=rebin(reform(x3,1,1,nx3),nx1,nx2,nx3)

r=sqrt(x^2+y^2)
rs=sqrt(x^2+y^2+z^2)
phi=atan(y,x)
th=acos(z/rs)
r3=r^3
bmag=sqrt(2./125.)
    br = 2.0*Bmag*cos(th)/r3;
   bth =     Bmag*sin(th)/r3;
   bx=br*sin(th)*cos(phi)+bth*cos(th)*cos(phi);
   by=br*sin(th)*sin(phi)+bth*cos(th)*sin(phi);
   bz=br*cos(th)-bth*sin(th);



bxback=bx
byback=by
bzback=bz
pload,/h5,0

bx=bx1+bxback
by=bx2+byback
bz=bx3+bzback


cgloadct,33
display,x1=x1,x2=x2,/hbar,ims=[800,800], alog10(rho(*,nx2/2,*))

b2=(bx^2+by^2+bz^2)/2.                                                                    
 betap=b2/prs
 cgcontour, reform(betap(*,nx2/2,*)),x1,x2, /overplot, lev=1, color='yellow'
 
 mx=reform(bx(*,nx2/2,*))
 mz=reform(bz(*,nx2/2,*))
 x1d=x1
 z1d=x3
 for j=0,nx1-1 do begin
for k=0,nx3-1 do begin
rs=sqrt(x1d[j]^2 +z1d[k]^2)
 if ( rs le .35) then begin
 rho[j,k]=1e-3
 mx[j,k]=0
 mz[j,k]=0
 endif
endfor
endfor

for i=0.9, 3.2,0.3 do begin
field_line_old, mx, mz, x1d,z1d,  i,0.1, rr,zz ;, /quiet
cgplot, rr,zz,color='white', /overplot, thick=2
field_line_old, mx, mz, x1d,z1d,  -i,0.1, rr,zz ;, /quiet
cgplot, rr,zz,color='white', /overplot, thick=2
endfor


end

