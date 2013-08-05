
nx=40L
ny=41L
nz=42L

x=findgen(nx)+0.0
y=findgen(ny)+0.0
z=findgen(nz)+0.0


xx=rebin(reform(x,nx,1,1),nx,ny,nz )/1.0/nx-0.5+1e-6
yy=rebin(reform(y,1,ny,1),nx,ny,nz)/1.0/ny-0.5+1e-6
zz=rebin(reform(z,1,1,nz),nx,ny,nz )/1.0/nz-0.5+1e-6

rr=sqrt(xx^2 + yy^2)
zz=zz
theta=atan(yy,xx  )

ar=fltarr(nx,ny,nz)
atheta=fltarr(nx,ny,nz)
az=fltarr(nx,ny,nz)

help,ar

pitchangle=0.2
for i=0,nx-1 do begin
for j=0,ny-1 do begin
for k=0,nz-1 do begin
for n=1,5 do begin
a=2.0
scrh=n*pitchangle
r=rr[i,j,k]
z=zz[i,j,k]
thet=theta[i,j,k]  
nka=scrh*a
nkr=scrh*rr[i,j,k]
phi=0.45
if (r lt a) then begin
KnkaInkrplus1=beselk(nka,n+1)*beseli(nkr,n+1)
ar[i,j,k] += (beselk(nka,n+1)*beseli(nkr,n+1)-beselk(nka,n-1)*beseli(nkr,n-1))
atheta[i,j,k] += (beselk(nka,n+1)*beseli(nkr,n+1)+beselk(nka,n-1)*beseli(nkr,n-1))
az[i,j,k] += (beselk(nka,n)*beseli(nkr,n))
endif else begin
ar[i,j,k] += (beseli(nka,n+1)*beselk(nkr,n+1)-beseli(nka,n-1)*beselk(nkr,n-1))
ar[i,j,k] += (beseli(nka,n+1)*beselk(nkr,n+1)+beseli(nka,n-1)*beselk(nkr,n-1))
az[i,j,k] += (beseli(nka,n+1)*beselk(nkr,n+1))
endelse
 ar[i,j,k]= pitchangle*n*ar[i,j,k]*sin ( n*( thet -phi - pitchangle*z) )
 az[i,j,k]= ar[i,j,k]*cos ( n*( thet -phi - pitchangle*z) )
;print, i,j,k
endfor
 atheta[i,j,k] +=  rr[i,j,k]

endfor
endfor
endfor

plot9, ar,atheta,az

ax=ar*cos(theta) -sin(theta) *atheta
ay=ar*sin(theta) +cos(theta) *atheta

curl, ax,ay,ax, bx,by,bz

j=1
;------------------------------------------------------------------------
;f = rf(j,datadir='./')      ; change directory if needed
;------------------------------------------------------------------------

openw,2,'fields_electrons_'+STRTRIM(j,2)+'.vtk',/SWAP_ENDIAN 


;B-field


grid0 = 0       
grid1 = nx
grid3 = ny
grid5 = nz

grid_tot = (grid1)*(grid3)*(grid5)


spa1 = 1.
spa2 = 1.
spa3 = 1.

print,'Writing the binary data of snapshot',j

printf,2,'# vtk DataFile Version 2.0'
printf,2,'PIC'
printf,2,'BINARY'
printf,2,'DATASET STRUCTURED_POINTS'
printf,2,'DIMENSIONS '+STRTRIM(grid1)+STRTRIM(grid3)+STRTRIM(grid5)
printf,2,'ORIGIN 0 0 0'
printf,2,'SPACING '+STRTRIM(spa1)+STRTRIM(spa2)+STRTRIM(spa3)
printf,2,'POINT_DATA '+STRTRIM(grid_tot)
printf,2,'SCALARS Vx FLOAT'
printf,2,'LOOKUP_TABLE default'
writeu,2,ar
printf,2,'SCALARS Vy FLOAT'
printf,2,'LOOKUP_TABLE default'
writeu,2,atheta
printf,2,'SCALARS Vz FLOAT'
printf,2,'LOOKUP_TABLE default'
writeu,2,az
printf,2,'SCALARS Bx FLOAT'
printf,2,'LOOKUP_TABLE default'
writeu,2,bx
printf,2,'SCALARS By FLOAT'
printf,2,'LOOKUP_TABLE default'
writeu,2,by
printf,2,'SCALARS Bz FLOAT'
printf,2,'LOOKUP_TABLE default'
writeu,2,bz
close,2
end
