
sload,0
vx0=vx[0:nx/2-1,0:ny/2-1,*]
vy0=vy[0:nx/2-1,0:ny/2-1,*]
cgdisplay, xs=800,ys=800
for nfile=0,10 do begin
fname='vort'+string(nfile, format='(I04)')


sload,nfile
b1=max(vx)
b2=max(vy)
print, "background",max(vx), max(vy)
amp=exp(0.07/2.*nfile )
amp=0.5*(b1+b2)/9.0d
print, "amp", amp
dvx=vx[0:nx/2-1,0:ny/2-1,*]-amp*vx0
dvy=vy[0:nx/2-1,0:ny/2-1,*]-amp*vy0
dvz=vz[0:nx/2-1,0:ny/2-1,*]

curl, dvx,dvy,dvz, cx,cy,cz


; vort projected into 45 and -135 degrees

th=!DPI/4.
vortproj=cy*cos(th)-cx*sin(th)
;vortpar= -cy*sin(th)+cx*cos(th)


uhp=  dvx*cos(th)+dvy*sin(th)
vhp= -dvx*sin(th)+dvy*cos(th)


usl=reform(uhp(*,0,*))
vsl=reform(vhp(*,0,*))
wsl=reform( dvz(*,0,*))
vortprojsl=reform( vortproj(*,0,*))

for i=0,nx/2-1 do begin
usl(i,*)=uhp(i,i,*)
vsl(i,*)=vhp(i,i,*)
wsl(i,*)= vz(i,i,*)
vortprojsl(i,*)= vortproj(i,i,*)
endfor

mx=0.1
if ( nfile lt 0 ) then begin
    for i=0,nx-1 do begin
    for j=0,nz-1 do begin
    if (vortprojsl(i,j) gt mx ) then begin
     vortprojsl(i,j)=mx
    endif
    if (vortprojsl(i,j) lt -mx ) then begin
     vortprojsl(i,j)=-mx
    endif
    endfor
    endfor
endif

x=findgen(nx)
z=findgen(nz)
qx=congrid(usl,23,17)
qy=congrid(wsl,23,17)

xx=(findgen(nx/2)/nx-1)*sqrt(2)

qqx=congrid(xx,23)
qqz=congrid(zz,17)




for usingps=0,1 do begin
if (usingps eq 1) then begin
cgps_open, fname+'.eps', /encapsulated, /color, tt_font='Times', /quiet
endif else  begin
set_plot, 'x'
endelse





cgloadct,0
pos=[0.1,0.15,0.85,0.9]
pos=[0.1,0.15,0.85,0.9]
pos=[0.01,0.01,0.99,0.99]
cgloadct,33
var=vortprojsl
imin=min(var)
imax=max(var)
r=cgscalevector(vortprojsl,1,255) 
cgimage, r, pos=pos
;cgcolorbar, range=[imin, imax] , pos=[pos[2]+0.07, pos[1], pos[2]+0.08, pos[3]], /vertical
cgcontour, cgscalevector(vortprojsl,1,455),xx,zz, /nodata,/noerase, pos=pos
velovect, qx,qy,qqx,qqz, color=cgcolor('white'), pos=pos, /overplot, c_thick=8.25, len=2.5 , thick=8

if ( usingps ) then begin
cgps_close, /jpeg,  Width=2048, /nomessage
endif else begin
fname2=fname
;im=cgsnapshot(filename=fname2,/nodialog,/jpeg)
endelse

endfor



endfor
end
