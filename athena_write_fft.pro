

FUNCTION snapshot_rf2vtk_test, j
;------------------------------------------------------------------------
;snoopyread, vx,vy, vz,bx,by,bz, xx3d,yy3d,zz3d,xx,yy,zz,nx,ny,nz,j

;------------------------------------------------------------------------


openw,2,'ffftvzbz'+STRTRIM(j,2)+'.vtk',/SWAP_ENDIAN 

v2=vx^2+vy^2+vz^2
b2=bx^2+by^2+bz^2

a=fft(vz,/center)
fftvz=abs(a)
a=fft(bz,/center )
fftbz=abs(a)

fftbx=abs(fft(bx,/center ))
fftby=abs(fft(by,/center ))
fftvx=abs(fft(vx,/center ))
fftvy=abs(fft(vy,/center ))
fftv2=abs(fft(v2,/center ))
fftb2=abs(fft(b2,/center ))


print, min(fftbz), max(fftbz)
fftbz(0,0,0)=0

sz=size(vz, /dimensions)
grid0 = 0 	
grid1 = sz(0)
grid3 =  sz(1)
grid5 =  sz(2)

grid_tot = (grid1)*(grid3)*(grid5)


spa1 =1
spa2 =1
spa3 =1

print,'Writing the binary data of snapshot',j

printf,2,'# vtk DataFile Version 2.0'
printf,2,'PIC'
printf,2,'BINARY'
printf,2,'DATASET STRUCTURED_POINTS'
printf,2,'DIMENSIONS '+STRTRIM(grid1)+STRTRIM(grid3)+STRTRIM(grid5)
printf,2,'ORIGIN 0 0 0'
printf,2,'SPACING '+STRTRIM(spa1)+STRTRIM(spa2)+STRTRIM(spa3)
printf,2,'POINT_DATA '+STRTRIM(grid_tot)
printf,2,'SCALARS fftvz FLOAT'
printf,2,'LOOKUP_TABLE default'
writeu,2,fftvz
printf,2,'SCALARS fftbz FLOAT'
printf,2,'LOOKUP_TABLE default'
writeu,2,fftbz
printf,2,'SCALARS fftby FLOAT'
printf,2,'LOOKUP_TABLE default'
writeu,2,fftbx
printf,2,'SCALARS fftbx FLOAT'
printf,2,'LOOKUP_TABLE default'
writeu,2,fftby
printf,2,'SCALARS fftvx FLOAT'
printf,2,'LOOKUP_TABLE default'
writeu,2,fftvx
printf,2,'SCALARS fftvy FLOAT'
printf,2,'LOOKUP_TABLE default'
writeu,2,fftvy
printf,2,'SCALARS fftv2 FLOAT'
printf,2,'LOOKUP_TABLE default'
writeu,2,fftv2
printf,2,'SCALARS fftb2 FLOAT'
printf,2,'LOOKUP_TABLE default'
writeu,2,fftb2
close,2
return,j
END

PRO PIC_data2vtk
;@stagger_6th
;@snapshot_rf2vtk_test

;------------------------------------------------------------------------
n = 200    ; number of snapshots to be written to vtk files
;------------------------------------------------------------------------

for j = 0,n,2 do begin  
  r=snapshot_rf2vtk_test(j)
endfor

END

