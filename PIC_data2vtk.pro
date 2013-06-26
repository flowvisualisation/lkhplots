

FUNCTION snapshot_rf2vtk_test, j
;------------------------------------------------------------------------
f = rf(j,datadir='./')      ; change directory if needed
;------------------------------------------------------------------------

openw,2,'fields_electrons_'+STRTRIM(j,2)+'.vtk',/SWAP_ENDIAN 

;V-field
vx = f.v[*,*,*,0,0]
vy = f.v[*,*,*,1,0]
vz = f.v[*,*,*,2,0]

;;E-field
ex = f.ex
ey = f.ey
ez = f.ez

;B-field
bx = f.bx
by = f.by
bz = f.bz

bx2 = bx*bx   
by2 = by*by
bz2 = bz*bz

ex2 = ex*ex
ey2 = ey*ey
ez2 = ez*ez


;jx = xdn(ddydn(bz)-ddzdn(by))   ; MHD def.
;jy = ydn(ddzdn(bx)-ddxdn(bz))
;jz = zdn(ddxdn(by)-ddydn(bx))
                                ; PIC def.
jx = (f.s.charge[0]*f.v[*,*,*,0,0]  +  f.s.charge[1]*f.v[*,*,*,0,1])
jy = (f.s.charge[0]*f.v[*,*,*,1,0]  +  f.s.charge[1]*f.v[*,*,*,1,1])
jz = (f.s.charge[0]*f.v[*,*,*,2,0]  +  f.s.charge[1]*f.v[*,*,*,2,1])

; electric current parallel to magn. field
bdotb = (bx2^2 + by2^2 + bz2^2) > 1e-30                     ;allow b to be zero
jdotb = (jx*bx2 + jy*by2 + jz*bz2)/bdotb
;jbx = bx2*jdotb					    ;electric current parallel to B, x-component
;jby = by2*jdotb
;jbz = bz2*jdotb
jdotb = jdotb*sqrt(bdotb)                                   ;signed J \cdot \hat{B}
; jdotbTOTx = total(jdotb[*,*,*],1)			    ;sum over x component

; electric field parallel to magn. field
edotb = (ex2*bx2 + ey2*by2 + ez2*bz2)/bdotb
edotb = edotb*sqrt(bdotb)


grid0 = 0 	
grid1 = f.s.gn[0]        ;dim. in x-direc		; e.g. Array[64, 64, 62]
grid3 = f.s.gn[1]	 ;dim. in y-direc	
grid5 = f.s.gn[2]	 ;dim. in z-direc

grid_tot = (grid1)*(grid3)*(grid5)


spa1 = f.s.ds[0]		; ds = cell size 
spa2 = f.s.ds[1]	
spa3 = f.s.ds[2]	

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
writeu,2,vx
printf,2,'SCALARS Vy FLOAT'
printf,2,'LOOKUP_TABLE default'
writeu,2,vy
printf,2,'SCALARS Vz FLOAT'
printf,2,'LOOKUP_TABLE default'
writeu,2,vz
printf,2,'SCALARS Bx FLOAT'
printf,2,'LOOKUP_TABLE default'
writeu,2,bx
printf,2,'SCALARS By FLOAT'
printf,2,'LOOKUP_TABLE default'
writeu,2,by
printf,2,'SCALARS Bz FLOAT'
printf,2,'LOOKUP_TABLE default'
writeu,2,bz
printf,2,'SCALARS jx FLOAT'
printf,2,'LOOKUP_TABLE default'
writeu,2,jx
printf,2,'SCALARS jy FLOAT'
printf,2,'LOOKUP_TABLE default'
writeu,2,jy
printf,2,'SCALARS jz FLOAT'
printf,2,'LOOKUP_TABLE default'
writeu,2,jz
printf,2,'SCALARS jdotB FLOAT'
printf,2,'LOOKUP_TABLE default'
writeu,2,jdotB
printf,2,'SCALARS edotB FLOAT'
printf,2,'LOOKUP_TABLE default'
writeu,2,edotB
close,2
return,j
END

PRO PIC_data2vtk
;@stagger_6th
;@snapshot_rf2vtk_test

;------------------------------------------------------------------------
n = 35    ; number of snapshots to be written to vtk files
;------------------------------------------------------------------------

for j = 0,n,1 do begin  
  r=snapshot_rf2vtk_test(j)
endfor

END

