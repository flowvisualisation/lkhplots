
nbeg=0
nend=nlast
pload,0
vx0=vx1
sbq=1.5d
sbomega=1.d
sba=-0.5*sbq*sbomega
vsh=2*sba
x3d=rebin(reform(x1,nx1,1,1),nx1,nx2,nx3)
vshear=vsh*x3d
vy0=vx2-vshear
cgdisplay, xs=800,ys=800
for nfile=nbeg,nend do begin
fname='vort'+string(nfile, format='(I04)')


pload,nfile
b1=max(vx1)
b2=max(vx2)
print, "background",b1,b2
amp=exp(0.07/2.*nfile )
amp=0.5*(b1+b2)/9.0d
print, "amp", amp
dvx=vx1-amp*vx0
dvy=vx2-vshear-amp*vy0
dvz=vx3

curl, dvx,dvy,dvz, cx,cy,cz


; vort projected into 45 and -135 degrees

th=!DPI/4.
vortproj=cy*cos(th)-cx*sin(th)
;vortpar= -cy*sin(th)+cx*cos(th)


uhp=  dvx*cos(th)+dvy*sin(th)
vhp= -dvx*sin(th)+dvy*cos(th)


usl=reform(uhp(*,0,*))
vsl=reform(vhp(*,0,*))
wsl=reform(dvz(*,0,*))
vortprojsl=reform( vortproj(*,0,*))

for i=0,nx1-1 do begin
usl(i,*)=uhp(i,i,*)
vsl(i,*)=vhp(i,i,*)
wsl(i,*)=dvz(i,i,*)
vortprojsl(i,*)= vortproj(i,i,*)
endfor

mx=0.1
if ( nfile lt 7 ) then begin
    for i=0,nx1-1 do begin
    for j=0,nx3-1 do begin
    if (vortprojsl(i,j) gt mx ) then begin
     vortprojsl(i,j)=mx
    endif
    if (vortprojsl(i,j) lt -mx ) then begin
     vortprojsl(i,j)=-mx
    endif
    endfor
    endfor
endif

x=findgen(nx1)
z=findgen(nx3)
qx=congrid(usl,23,17)
qy=congrid(wsl,23,17)

xx=(findgen(nx1)/nx1*2-1)*sqrt(2)

qqx=congrid(x1,23)
qqz=congrid(x3,17)




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
velovect, qx,qy,qqx,qqz, color=cgcolor('white'), pos=pos, /overplot, c_thick=4.25, len=2.5 

if ( usingps ) then begin
cgps_close, /jpeg,  Width=2048, /nomessage
endif else begin
fname2=fname
;im=cgsnapshot(filename=fname2,/nodialog,/jpeg)
endelse

endfor



endfor
end
