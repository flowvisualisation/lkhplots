
rsize=5
nx=100
ny=100
x=(findgen(nx)+1)/nx*rsize
y=(findgen(ny)+1)/ny*rsize

x2d=rebin(reform(x,nx,1),nx,ny)
y2d=rebin(reform(y,1,ny),nx,ny)


r2d=sqrt(x2d^2+y2d^2) 
phi=atan(y2d/x2d)
phi[0,0]=0




flux=sin(phi)^2 /r2d
flux[0,0]=0
br=1/r2d^3*2*cos(phi)
bphi=-1/r2d^2*sin(phi)

im= alog10(br[1:nx-1,1:ny-1])
im= alog10(bphi[1:nx-1,1:ny-1]^2)
cgloadct,33
display, im, ims=10, /hbar,x1=x[1:nx-1],x2=y[1:ny-1]

bx=br*sin(phi) + bphi*cos(phi)
by=br*sin(phi) + bphi*cos(phi)


q=13
cv1=congrid(bx,q,q)
cv2=congrid(by,q,q)
cx=congrid(x,q)
cy=congrid(y,q)

xf=2.0
for i=0.26, xf,0.1 do begin

field_line, br, bphi, x,y,  i,0.05, rr,zz
oplot, rr,zz,color=255
;field_line, b1(0), b2(0), x1,x2,  10,i, rr,zz
;oplot, rr,zz,color=255
endfor


end
