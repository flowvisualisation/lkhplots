
;  

nx=24
ny=72
nz=24
if (1 ) then begin
nx=48
ny=3*nx
nz=nx
endif

pload,nlast, /silent
print, nlast
a=fltarr(nx,ny,nz,5)

a(*,*,*,0)=congrid(rho,nx,ny,nz)
a(*,*,*,1)=congrid(vx1,nx,ny,nz)
a(*,*,*,2)=congrid(vx2,nx,ny,nz)
a(*,*,*,3)=congrid(vx3,nx,ny,nz)
a(*,*,*,4)=congrid(prs,nx,ny,nz)


openw, lun, 'forjose.txt', /get_lun

for i=0,nx-1 do begin
for j=0,ny-1 do begin
for k=0,nz-1 do begin

printf,lun, i,j,k, a(i,j,k,0) , a(i,j,k,1) ,a(i,j,k,2) ,a(i,j,k,3) ,a(i,j,k,4), format='(3I5,F10.4,3E11.3,F10.4)'

endfor
endfor
endfor

close,lun


end
