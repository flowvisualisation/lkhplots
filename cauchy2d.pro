function cauchy2d, nx, ny, theta
f=fltarr(nx,ny)
;f(x,y) = A \exp\left(- \left(a(x - x_o)^2 + 2b(x-x_o)(y-y_o) + c(y-y_o)^2 \right)\right)

x1d=findgen(nx)/nx*15-7.5
y1d=findgen(ny)/ny*15-7.5
X=rebin(reform(x1d,nx,1),nx,ny)
Y=rebin(reform(y1d,1,ny),nx,ny)

x0=0
y0=0
sigma_x=3.
sigma_y=1.

  a = cos(theta)^2/2/sigma_x^2 + sin(theta)^2/2/sigma_y^2;
    b = -sin(2*theta)/4/sigma_x^2 + sin(2*theta)/4/sigma_y^2 ;
    c = sin(theta)^2/2/sigma_x^2 + cos(theta)^2/2/sigma_y^2;

f=1/(1 + (a*(X-x0)^2 + 2*b*(X-x0)*(Y-y0) + c*(Y-y0)^2)) ;
print, max(f), min(f)

return, f
;cgloadct,33 & display, ims=[800,800],f
end

