
nx=4
ny=4
nz=4
v1=randomn(0,nx,ny,nz)
v2=v1
v3=v1


nfile=1
nend=15
nstart=15
for nfile=nstart,nend do begin
snoopyread, vx,vy, vz,bx,by,bz, xx3d,yy3d,zz3d,xx,yy,zz,nx,ny,nz,nfile, time

invii=fltarr(nx,ny,nz)
inviii=fltarr(nx,ny,nz)


for i=0,nx-1 do begin
for j=0,ny-1 do begin
for k=0,nz-1 do begin


    u1=vx(i,j,k)
    u2=vy(i,j,k)
    u3=vz(i,j,k)

 ;reystresstensor, u1,u2,u3, rey
 reystressanisotropytensor, u1,u2,u3, rey


invariants, rey, traa, det
invii(i,j,k)=traa
inviii(i,j,k)=det

;print, trace(rey)^2-trace(rey^2), det

;print, invii(i,j,k)
;print, rey(0,0), trace(rey^2), determ(rey)

endfor
endfor
endfor

print, max(invii), max(inviii)
print, min(invii), min(inviii)

endfor


r=rey

detr= r(0,0)*(r(1,1)*r(2,2)-r(1,2)*r(2,1))- r(0,1)*(r(1,0)*r(2,2)-r(1,2)*r(2,0))+ r(0,2)*(r(1,0)*r(2,1)-r(1,1)*r(2,0))

end
