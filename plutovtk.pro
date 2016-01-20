

FUNCTION plutovtk, tag, nfile, den, v1,v2,v3,b1,b2,b3,pr
;------------------------------------------------------------------------
;------------------------------------------------------------------------


openw,2,tag+'pluto'+STRing(nfile,format='(I06)')+'.vtk' ,/SWAP_ENDIAN 






sz=size(v3, /dimensions)
print, sz
grid0 = 0 	
dim1 = sz(0)
dim2 =  sz(1)
dim3 =  sz(2)

grid_tot = (dim1)*(dim2)*(dim3)


xs=12.0
ys=xs
zs=xs
dx=xs/dim1
dy=ys/dim2
dz=zs/dim3

spa1 =dx
spa2 =dy
spa3 =dz

ori1=-dx*dim1/2
ori2=-dy*dim2/2
ori3=-dz*dim3/2

print,'Writing the binary data of snapshot',nfile

printf,2,'# vtk DataFile Version 2.0'
printf,2,'PIC'
printf,2,'BINARY'
printf,2,'DATASET STRUCTURED_POINTS'
printf,2,'DIMENSIONS '+STRTRIM(dim1)+STRTRIM(dim2)+STRTRIM(dim3)
printf,2,'ORIGIN '    +STRTRIM(ori1)+STRTRIM(ori2)+STRTRIM(ori3)
printf,2,'SPACING '   +STRTRIM(spa1)+STRTRIM(spa2)+STRTRIM(spa3)
printf,2,'POINT_DATA '+STRTRIM(grid_tot)
printf,2,'SCALARS den FLOAT'
printf,2,'LOOKUP_TABLE default'
writeu,2,den
printf,2,'SCALARS v1 FLOAT'
printf,2,'LOOKUP_TABLE default'
writeu,2,v1
printf,2,'SCALARS v2 FLOAT'
printf,2,'LOOKUP_TABLE default'
writeu,2,v2
printf,2,'SCALARS v3 FLOAT'
printf,2,'LOOKUP_TABLE default'
writeu,2,v3
printf,2,'SCALARS b1 FLOAT'
printf,2,'LOOKUP_TABLE default'
writeu,2,b1
printf,2,'SCALARS b2 FLOAT'
printf,2,'LOOKUP_TABLE default'
writeu,2,b2
printf,2,'SCALARS b3 FLOAT'
printf,2,'LOOKUP_TABLE default'
writeu,2,b3
printf,2,'SCALARS pr FLOAT'
printf,2,'LOOKUP_TABLE default'
writeu,2,pr
close,2
return,0
END
