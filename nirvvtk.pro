

pro nirvvtk, nfile,tag, rey1


openw,2,tag+STRing(nfile, format='(I07)')+'.vtk',/SWAP_ENDIAN 


;nfile=322000

d=h5_read(nfile, /B)
rey1=transpose(reform(d.b(0,*,*,*)))
rey2=transpose(reform(d.b(1,*,*,*)))
rey3=transpose(reform(d.b(2,*,*,*)))




sz=size(rey1, /dimensions)
grid0 = 0 	
grid1 = sz(0)
grid3 =  sz(1)
grid5 =  sz(2)

grid_tot = (grid1)*(grid3)*(grid5)


spa1 =1
spa2 =1
spa3 =1

print,'Writing the binary data of snapshot',nfile

printf,2,'# vtk DataFile Version 2.0'
printf,2,'PIC'
printf,2,'BINARY'
printf,2,'DATASET STRUCTURED_POINTS'
printf,2,'DIMENSIONS '+STRTRIM(grid1)+STRTRIM(grid3)+STRTRIM(grid5)
printf,2,'ORIGIN 0 0 0'
printf,2,'SPACING '+STRTRIM(spa1)+STRTRIM(spa2)+STRTRIM(spa3)
printf,2,'POINT_DATA '+STRTRIM(grid_tot)
printf,2,'SCALARS rey1 FLOAT'
printf,2,'LOOKUP_TABLE default'
writeu,2,rey1
printf,2,'SCALARS rey2 FLOAT'
printf,2,'LOOKUP_TABLE default'
writeu,2,rey2
printf,2,'SCALARS rey3 FLOAT'
printf,2,'LOOKUP_TABLE default'
writeu,2,rey3
close,2
END
