

nx=64
ny=nx
nz=nx

rmax=5
rmin=-5
x1d=findgen(nx)/nx*(rmax-rmin)+rmin
y1d=findgen(ny)/ny*(rmax-rmin)+rmin
z1d=findgen(nz)/nz*(rmax-rmin)+rmin

x3d=rebin(reform(x1d, nx,1, 1),nx,ny,nz)
y3d=rebin(reform(y1d, 1,ny, 1),nx,ny,nz)
z3d=rebin(reform(z1d, 1, 1,nz),nx,ny,nz)

rc2d=sqrt(x3d^2)

vphi=rc2d^(0.5)




alp=!PI/4.
alp=0

; step one: rotate the coridnate system
 rotalp3d, x3d, y3d, z3d,alp, xd, yd ,zd
 rd=sqrt(xd^2+yd^2)


; step 2: compute the new values in the rotated frame, f'
kep=-0.5
;phid=atan(xd,yd)
phid=atan(yd,xd)
vxd= -rd^(kep)*sin(phid)
vyd= rd^(kep)*cos(phid)
vzd=fltarr(nx,ny,nz)
vzd(*,*,*)=0

for i=0,nx-1 do begin
for j=0,ny-1 do begin
for k=0,nz-1 do begin
if ( abs(rd[i,j,k]) le 1) then begin
vxd[i,j,k]= -sin(phid[i,j,k])
vyd[i,j,k]= cos(phid[i,j,k])
;vzd[i,j,k]=1*signum(xd[i,j,k])

endif
endfor
endfor
endfor

; step 3: rotate back to the normal cartesian frame, f
 rotalp3d, vxd, vyd, vzd, -alp, vxd2, vyd2, vzd2 

cgloadct,33
display,vxd2[*,*,nz/2],x1=x1d,x2=y1d, $
    /hbar, $
    ims=[800,800] 



den=xd
tag="mytest3d"
nfile=0
g=plutovtk( tag, nfile, rd, vxd,vyd,vzd,vxd2,vyd2,vzd2,phid)

end


