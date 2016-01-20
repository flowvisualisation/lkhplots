

nx=100
ny=nx

rmax=5
rmin=-5
x1d=findgen(nx)/nx*(rmax-rmin)+rmin
y1d=findgen(ny)/ny*(rmax-rmin)+rmin
z1d=findgen(ny)/ny*(rmax-rmin)+rmin
z1d(*)=0

x2d=rebin(reform(x1d, nx,1),nx,ny)
y2d=rebin(reform(y1d, 1,ny),nx,ny)
z2d=rebin(reform(z1d, 1,ny),nx,ny)

rc2d=sqrt(x2d^2)

vphi=rc2d^(0.5)


phi2d=fltarr(nx,ny)
phi2d[0:nx/2,*]=!DPI
phi2d[nx/2:nx-1,*]=0


alp=!PI/4.
;alp=0

; step one: rotate the coridnate system
 rotalp, x2d, y2d, phi2d,alp, xd, yd ,phid
 rd=sqrt(xd^2)


; step 2: compute the new values in the rotated frame, f'
kep=-0.5
phid=acos(xd/(rd+1e-6))
vxd=abs(xd)^(kep)*cos(phid)
vyd=abs(xd)^(kep)*sin(phid)
rc2d=sqrt(x2d^2+ y2d^2)
vz=0; rc2d^(-0.5)

for i=0,nx-1 do begin
for j=0,ny-1 do begin
if ( abs(xd[i,j]) le 1) then begin
vxd[i,j]=1*signum(xd[i,j])
vyd[i,j]=1*signum(xd[i,j])

endif
endfor
endfor

; step 3: rotate back to the normal cartesian frame, f
 rotalp, vxd, vyd, vzd, -alp, vxd2, vyd2, vzd2 
for i=0,nx-1 do begin
for j=0,ny-1 do begin
if ( abs(xd[i,j]) lt 1 ) then begin

;vxd[i,j]=1
;vyd[i,j]=1
endif
endfor
endfor

cgloadct,33
display,vxd2, $
    /hbar, $
    ims=[800,800] 


end


