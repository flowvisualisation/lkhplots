

nx=200
ny=nx
x=findgen(nx)/nx
y=x
z=x


x2d=rebin(reform(x,nx,1),nx,ny)
y2d=rebin(reform(y,1,ny),nx,ny)

ek=dblarr(nx,ny)
vx=dblarr(nx,ny)
vy=dblarr(nx,ny)
ek[*,*]=0.0


for km=4,20 do begin
seed=km
randx=randomn(seed,2)
rand=randx(0)
rand2=randx(1)
for i=0,nx-1 do begin
for j=0,ny-1 do begin
xpos=x2d[i,j]
ypos=y2d[i,j]
vpar=exp(-1./3.*km)*sin(2*!PI*(km*xpos))
vperp=exp(-1./2.*km)*cos(2*!PI*(km*ypos))
th=rand/2.+!PI/4.
;th=!PI/6.
vx1= vpar*cos(2*!DPI*th)+vperp*sin(2*!PI*th+rand)
vy1= -vpar*sin(2*!DPI*th)+vperp*cos(2*!PI*th+rand2)
;vpar=sin(2*!DPI*km )
;help, vpar
;print, i,j
vx[i,j]=vx1
vy[i,j]=vy1
ek[i,j]=ek[i,j]+vx1^2+vy1^2
endfor
endfor
;display,ims=[800,800], vx^2+vy^2
display,ims=[800,800], vx
;print, exp(-1/2.*km), rand
print, th*!RADEG
endfor


cgloadct,33
;display, ims=[800,800],$
;    ek

pos=cglayout([2,1])

ek=ek-mean(ek)
cgdisplay,xs=1100,ys=800
cgimage, cgscalevector(ek,1,254), pos=pos(*,0)
cgimage, alog10(abs(fft(ek,/center))), pos=pos(*,1), /noerase


end
