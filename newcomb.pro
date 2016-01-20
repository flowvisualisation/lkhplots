



; compute  -grad rho

nfile=322000L

d=h5_read(nfile, /B, /rho)
rho=transpose(d.rho)
bx1=reform(transpose(d.b(0,*,*,*)))
bx2=reform(transpose(d.b(1,*,*,*)))
bx3=reform(transpose(d.b(2,*,*,*)))
grd_ctl, model=nfile, g,c
nx1=g.nx
nx2=g.ny
nx3=g.nz
x3=g.z
gradrho=rho

for i=0,nx1-1 do begin
for j=0,nx2-1 do begin

gradrho(i,j,*)=deriv(x3,rho(i,j,*))

endfor
endfor
; compute (rho*g)/(gamma*p+b^2)

grav= -x3/abs(x3)^3
grav3d=rebin(reform(grav,1,1,nx3),nx1,nx2,nx3)
ggamma=1.666666666667
b2=bx1^2+bx2^2+bx3^2
pres=rho^ggamma
crit= rho*grav3d/(ggamma*pres+b2)


stab=gradrho-crit

end
