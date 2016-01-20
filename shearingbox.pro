!p.font=0
device,set_font="-adobe-times-medium-r-normal--20-140-100-100-p-96-iso8859-15"
cgloadct,33
nx=20
ny=nx
u=fltarr(nx,ny,2)

x=findgen(nx)/nx
x2d=rebin(reform(x,nx,1),nx,ny)
y=findgen(ny)/ny
y2d=rebin(reform(y,1,ny),nx,ny)

rho=fltarr(nx,ny)
rho(*,*)=1
p=fltarr(nx,ny)
p(*,*)=1
flux=fltarr(nx,ny)
u(*,*,0)=sin(2*!PI*(x2d+y2d))
u(*,*,1)=sin(2*!PI*(x2d+y2d))

omega=1.0
q=1.5

for nstep=1,10 do begin

; timestep
dtdx= max (u)

;; flux

vx=reform(u(*,*,0))
vy=reform(u(*,*,1))


for i=0,nx-1 do begin
for j=0,ny-1 do begin

;flux(i,j)=rho*(vx^2 +vx*vy) + p

endfor
endfor


xflux= vx*vx 
yflux= vx*vy+ vy*vy + q*omega*x2d


unew=u+dtdx*(flux)

;; boundary conditions
xl=u(0,*,*)
xu=u(nx-1,*,*)


u(0,*,*)=shift(xu,1)
u(nx-1,*,*)=shift(xl,-1)

display,u(*,*,0), ims=[800,800]
wait,1
endfor

end
