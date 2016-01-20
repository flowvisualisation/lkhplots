
cgdisplay, xs=1200,ys=1200
nx=100
ny=100
rc=findgen(nx)/nx*7
z=findgen(ny)/ny*7

rs=sqrt(rc^2+z^2)


r2d=rebin(reform(rc,nx,1),nx,ny)
z2d=rebin(reform(rc,1,ny),nx,ny)
rs2d=sqrt(r2d^2+z2d^2)
th2d=atan(r2d/z2d)


    kr=1.01;
    gm=1
    p0a=0.01
    rdisk=1.0
    gravpot=-gm/rs2d
    centpot=fltarr(nx,ny)
    centpot(*,*)=kr*gm/rdisk*(1+ (rdisk^2-r2d(*,*)^2 ) /2/rdisk^2 ) ; 
    
    help, centpot

for i=0,nx-1 do begin
for j=0,ny-1 do begin
if ( r2d[i,j] ge 1) then begin 
    centpot[i,j]=(kr*gm/(r2d[i,j])); 
    endif
    endfor
    endfor


    ee= (kr-1)*gm/1.;
    ff=ee-gravpot-centpot;
    ff[0,0]=ff[1,1]
    tc=1;
    td=0.01;
    mpm=1.;
    p=p0a*exp(ff*mpm/tc);
    

rho=mpm*p/tc
for i=0,nx-1 do begin
for j=0,ny-1 do begin
if ( ( th2d[i,j] ge  !DPI*9./20.)  and (r2d[i,j] ge rdisk) ) then begin 
    p[i,j]=p0a*exp(ff[i,j]*mpm/td);
    rho[i,j]=mpm*p[i,j]/td
    endif
    endfor
    endfor

pos=cglayout([2,2])
cgcontour, gravpot,rc,z, pos=pos[*,0], nlev=64
cgcontour, centpot,rc,z, pos=pos[*,1], /noerase
cgcontour, ff,rc,z, pos=pos[*,2], /noerase, nlev=60


;cgimage,  alog10(rho),  pos=pos[*,3], /noerase
;cgcontour, alog10(rho),rc,z, pos=pos[*,3], /noerase, nlev=40
cgcontour, rho, rc,z,  pos=pos[*,3], /noerase, lev=[0.004, 0.008,0.009,0.01,   1.655,2.135]
print, min(p), max(p)

end
