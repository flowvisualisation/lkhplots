



; compute  -grad rho

nbeg=400000L
nend=500000
nstep=2000

crit2d=fltarr(513,1)

for nc=1L, 100L, 1L do begin
nfile=nbeg+2000L*nc

;nfile=712000L
;nfile=000L

d=h5_read(nfile, /B, /rho)
rho=transpose(d.rho)
bx1=reform(transpose(d.b(0,*,*,*)))
bx2=reform(transpose(d.b(1,*,*,*)))
bx3=reform(transpose(d.b(2,*,*,*)))
grd_ctl, model=nfile, g,c
print, nfile
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

grav= -1/x3
grav3d=rebin(reform(grav,1,1,nx3),nx1,nx2,nx3)
ggamma=5.d/3.d
;b21d=bx1^2+bx2^2+bx3^2
b2=bx1^2+bx2^2+bx3^2
;rho1d=total(total(rho,1),1)
pres=rho^ggamma
cs2=(ggamma*pres/rho)
ca2=(b2/rho)

nu2=-grav3d/4/!DPI*(gradrho - grav3d/(cs2+ca2))

;stab=gradrho-crit

avenu=total(total(nu2,1),1)/nx1/nx2

crit2d=[ [crit2d] , [avenu] ]
cgplot,x3, avenu, yrange=[0,1], title='Magnetised Brunt-V'+string(228b)+'is'+string(228b)+'l'+string(228b)+' frequency', xtitle='z/H'

endfor
end
